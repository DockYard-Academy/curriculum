defmodule Utils.Feedback.Assertion do
  defmacro __using__(_otps) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :feedback_functions, accumulate: true)
      Module.register_attribute(__MODULE__, :ignored, accumulate: true)

      import ExUnit.CaptureLog
      import Utils.Feedback.AssertionHelpers
      require Logger

      def get_answers() do
        :persistent_term.get(:answers)
      end

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def solutions do
        @feedback_functions -- @ignored
      end

      def feedback_functions do
        @feedback_functions
      end

      def ignored do
        @ignored
      end
    end
  end

  defmacro feedback(description, opts \\ [], do: assertion) do
    quote do
      @feedback_functions unquote(description)

      if Keyword.get(unquote(opts), :ignore) do
        @ignored unquote(description)
      end

      def feedback(unquote(description), answers) do
        :persistent_term.put(:answers, answers)

        try do
          unquote(assertion)
          IO.puts("Solved!")
        rescue
          e in AssertionError ->
            IO.puts(e.message)
            :error

          e ->
            format_error(e, __STACKTRACE__)
            :error
        end
      end
    end
  end

  def format_error(error, stacktrace) do
    try do
      [{_module, _function, _arity, info} | _tail] = stacktrace
      file = Keyword.get(info, :file)
      line = Keyword.get(info, :line)

      code =
        file
        |> File.stream!()
        |> Enum.at(line - 1)
        |> String.trim()

      IO.puts("""
      Assertion crashed.#{code && "\n  code: #{code}"}
        error: #{inspect(error.message)}
      """)
    rescue
      _ ->
        IO.puts("""
        Assertion crashed.
          error: #{inspect(error)}
        """)
    end
  end

  defmacro get_code(caller, line) do
    quote do
      unquote(caller).file |> File.stream!() |> Enum.at(unquote(line) - 1) |> String.trim()
    end
  end

  defmacro assert(expression, hint \\ nil)

  defmacro assert({operator, meta, [lhs, rhs]} = x, hint)
           when operator in [:==, :===, :<=, :>=, :>, :<] do
    [line: line] = meta
    code = get_code(__CALLER__, line)

    args =
      case lhs do
        {{:., _,
          [
            _,
            _function
          ]}, _, args} ->
          args

        _ ->
          nil
      end

    quote bind_quoted: [
            operator: operator,
            lhs: lhs,
            rhs: rhs,
            code: code,
            hint: hint,
            args: args
          ] do
      case apply(Kernel, operator, [lhs, rhs]) do
        true ->
          :ok

        false ->
          raise AssertionError,
            message: Utils.Feedback.Assertion.format(operator, lhs, rhs, code, args, hint)
      end
    end
  end

  defmacro assert(assertion, hint) do
    {function, [line: line], args} = assertion
    code = get_code(__CALLER__, line)

    quote do
      if unquote(assertion) do
        :ok
      else
        raise AssertionError,
          message: """
          Expected truthy, got #{unquote(assertion)}.
            code: #{unquote(code)}
          """
      end
    end
  end

  defmacro assert_raise(expected_error, assertion, hint \\ nil) do
    {function, [line: line], args} = assertion
    code = get_code(__CALLER__, line)

    quote do
      try do
        unquote(assertion)

        raise AssertionError
      rescue
        unquote(expected_error) ->
          :ok

        AssertionError ->
          raise AssertionError,
            message: """
            Expected exception #{unquote(expected_error)} but nothing was raised
              code: #{unquote(code)}#{unquote(hint) && "\n\n#{unquote(hint)}"}
            """

        error ->
          raise AssertionError,
            message: """
            Expected exception #{unquote(expected_error)} but instead raised #{inspect(error)}
              code: #{unquote(code)}#{unquote(hint) && "\n\n#{unquote(hint)}"}
            """
      end
    end
  end

  def format(operator, recieved, expected, code, args, hint) do
    code = Regex.replace(~r/, \"\"\"/, code, ")")

    called_with = args && "\n  called_with: #{Enum.map(args, &inspect/1) |> Enum.join(", ")}"

    """
    Assertion with #{operator} failed.
      code: #{code}#{called_with}
      left: #{inspect(recieved, pretty: true)}
      right: #{inspect(expected, pretty: true)}#{hint && "\n\n#{hint}"}
    """
  end
end

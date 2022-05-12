defmodule Utils.Feedback.Assertion do
  defmacro __using__(_otps) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :feedback_functions, accumulate: true)
      Module.register_attribute(__MODULE__, :ignored, accumulate: true)

      import ExUnit.CaptureLog
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

        if is_nil(answers) or (is_list(answers) and Enum.all?(answers, &is_nil/1)) do
          IO.puts("Please enter an answer above.")
        else
          try do
            unquote(assertion)
            IO.puts("Solved!")
          rescue
            err ->
              IO.puts(err.message)
              :error
          end
        end
      end
    end
  end

  defmacro get_code(caller, line) do
    quote do
      unquote(caller).file |> File.stream!() |> Enum.at(unquote(line) - 1) |> String.trim()
    end
  end

  defmacro assert({operator, meta, [lhs, rhs]}, hint \\ nil) do
    [line: line] = meta
    code = get_code(__CALLER__, line)

    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs, code: code, hint: hint] do
      case apply(Kernel, operator, [lhs, rhs]) do
        true -> :ok
        false -> raise Utils.Feedback.Assertion.format(operator, lhs, rhs, code, hint)
      end
    end
  end

  def format(operator, recieved, expected, code, hint) do
    code = Regex.replace(~r/, \"\"\"/, code, ")")

    """
    Assertion with #{operator} failed.
      code: #{code}
      left: #{inspect(recieved)}
      right: #{inspect(expected)}#{hint && "\n\n#{hint}"}
    """
  end
end

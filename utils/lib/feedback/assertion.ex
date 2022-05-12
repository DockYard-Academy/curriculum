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
        unquote(assertion)
      end
    end
  end

  defmacro get_code(caller, line) do
    quote do
      unquote(caller).file |> File.stream!() |> Enum.at(unquote(line) - 1) |> String.trim()
    end
  end

  defmacro assert({operator, meta, [lhs, rhs]}) do
    [line: line] = meta
    code = get_code(__CALLER__, line)

    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs, code: code] do
      Utils.Feedback.Assertion.custom_assert(operator, lhs, rhs, code)
    end
  end

  defmacro assert({_, meta, _} = assertion) do
    [line: line] = meta
    code = get_code(__CALLER__, line)

    quote bind_quoted: [assertion: assertion, code: code] do
      Utils.Feedback.Assertion.custom_assert(assertion, code)
    end
  end

  defmacro assert(assertion) do
    quote bind_quoted: [assertion: assertion] do
      Utils.Feedback.Assertion.custom_assert(assertion)
    end
  end

  def custom_assert(operator, lhs, rhs, code) do
    if apply(Kernel, operator, [lhs, rhs]) do
      IO.write(".")
      :ok
    else
      IO.puts(message(operator, lhs, rhs, code))
      :error
    end
  end

  def custom_assert(assertion) do
    if assertion do
      IO.write(".")
      :ok
    else
      IO.puts(message(assertion))
      :error
    end
  end

  def custom_assert(assertion, code) do
    if assertion do
      IO.write(".")
      :ok
    else
      IO.puts(message(assertion, code))
      :error
    end
  end

  def message(recieved, code) do
    """
    Solution Failed.
      Code: #{code}
      Expected: truthy
      Recieved: #{recieved}
    """
  end

  def message(recieved) do
    """
    Solution Failed.
      Expected truthy, got #{recieved}
    """
  end

  def message(operator, recieved, expected, code) do
    """
    Solution Failed.
      Code: #{code}
      Expected: #{expected}
      To Equal: #{recieved}
    """
  end

  def passed?(operator, lhs, rhs) do
    apply(Kernel, operator, [lhs, rhs])
  end

  def passed?(truthy), do: truthy not in [false, nil]
end

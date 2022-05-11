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

  defmacro assert(stuff, message \\ nil)

  defmacro assert({operator, _, [lhs, rhs]}, message) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Utils.Feedback.Assertion.custom_assert(operator, lhs, rhs)
    end
  end

  defmacro assert(assertion, message) do
    quote bind_quoted: [assertion: assertion] do
      Utils.Feedback.Assertion.custom_assert(assertion)
    end
  end

  def custom_assert(:===, lhs, rhs) when lhs === rhs, do: passed()
  def custom_assert(:===, lhs, rhs) when lhs != rhs, do: failed(lhs, rhs)

  def custom_assert(:==, lhs, rhs) when lhs == rhs, do: passed()

  def custom_assert(:==, lhs, rhs) when lhs != rhs, do: failed(lhs, rhs)

  def custom_assert(assertion) when assertion, do: passed()

  def custom_assert(assertion) when assertion do
    IO.puts("""
    Failed
    """)

    :fail
  end

  defp passed do
    Mix.env() !== :test && IO.write("Solved!")
    :ok
  end

  defp failed(lhs, rhs) do
    Mix.env() !== :test &&
      IO.puts("""
      Failed:
        Recieved: #{inspect(lhs)}
        Expected: #{inspect(rhs)}
      """)

    :error
  end

  # defmacro feedback(module_name, do: assertion) do
  #   quote do
  #     @tests unquote(module_name)
  #     def feedback(unquote(module_name), answers) do
  #       :persistent_term.put(:answers, answers)

  #       list_contains_value = is_list(answers) and Enum.any?(answers)
  #       has_non_list_value = not is_nil(answers) and not is_list(answers)

  #       should_run = Mix.env() == :test or has_non_list_value or list_contains_value

  #       if should_run do
  #         ExUnit.start(auto_run: false)

  #         defmodule unquote(module_name) do
  #           use ExUnit.Case

  #           def get_answers() do
  #             :persistent_term.get(:answers)
  #           end

  #           def reset_message do
  #             "Something went wrong, please reset the exercise or speak to your teacher."
  #           end

  #           test unquote(module_name) do
  #             unquote(assertion)
  #           end
  #         end

  #         ExUnit.run()
  #       else
  #         "Please enter your answer above."
  #       end
  #     end
  #   end
  # end
end

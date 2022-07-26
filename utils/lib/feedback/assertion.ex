defmodule Utils.Feedback.Assertion do
  defmacro __using__(_otps) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute(__MODULE__, :tests, accumulate: true)

      import ExUnit.CaptureLog
      require Logger
    end
  end

  defmacro feedback(module_name, do: assertion) do
    quote do
      @tests unquote(module_name)
      def feedback(unquote(module_name), answers) do
        :persistent_term.put(:answers, answers)

        list_contains_value = is_list(answers) and Enum.any?(answers)
        has_non_list_value = not is_nil(answers) and not is_list(answers)

        should_run = Mix.env() == :test or has_non_list_value or list_contains_value

        if should_run do
          ExUnit.start(auto_run: false)

          defmodule unquote(module_name) do
            use ExUnit.Case

            def get_answers do
              :persistent_term.get(:answers)
            end

            def reset_message do
              "Something went wrong, please reset the exercise or speak to your teacher."
            end

            test unquote(module_name) do
              unquote(assertion)
            end
          end

          ExUnit.run()
        else
          "Please enter your answer above."
        end
      end
    end
  end
end

defmodule Utils.Macros do
  defmacro feedback(module_name, do: assertion) do
    quote do
      @test_module_names unquote(module_name)
      def test_module(unquote(module_name), answers) do
        :persistent_term.put(:answers, answers)

        defmodule unquote(module_name) do
          use ExUnit.Case

          def get_answers() do
            :persistent_term.get(:answers)
          end

          test unquote(module_name) do
            unquote(assertion)
          end
        end
      end
    end
  end
end

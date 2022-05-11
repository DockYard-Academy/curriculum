defmodule Utils.FeedbackCase do
  defmacro __using__(module: module, file: file_name) do
    quote do
      use ExUnit.Case

      test "feedback called from file match functions defined in module." do
        assert {:ok, file} = File.read(unquote(file_name))

        file_feedback_functions =
          Regex.scan(~r/Utils.feedback\(:(\w+)/, file)
          |> Enum.map(fn [_, test] -> String.to_atom(test) end)
          |> Enum.sort()

        feedback_functions = Enum.sort(unquote(module).feedback_functions())

        assert file_feedback_functions == feedback_functions,
               """
               Functions called in #{unquote(file_name)}
               Do not match functions defined in #{unquote(module)}

               File: #{inspect(file_feedback_functions)}
               Feedback Functions: #{inspect(feedback_functions)}
               """
      end

      test "solutions pass tests" do
        Enum.each(unquote(module).solutions(), fn each ->
          assert Keyword.get(unquote(module).__info__(:functions), each),
                 "Solution missing for #{unquote(module)}.#{Atom.to_string(each)}"

          solution = apply(unquote(module), each, [])

          # This assertion helps debug, but may be expensive.
          # As it is not required, we may opt to remove this if tests slow down.
          assert Utils.feedback(each, solution) == :ok,
                 "Solution fails for #{unquote(module)}.#{Atom.to_string(each)}}"

          assert Utils.feedback(each, solution) == :ok,
                 "Utils.feedback should delegate to #{unquote(module)}"
        end)
      end
    end
  end
end

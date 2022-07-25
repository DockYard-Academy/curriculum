defmodule Utils.SmartCell.ExerciseTest do
  use ExUnit.Case

  test "Exercises _ possible solution _ passes feedback test" do
    exercise_modules()
    |> Enum.each(fn module ->
      (module.possible_solution() <> module.feedback())
      |> Code.eval_string([], __ENV__)
    end)
  end

  test "Exercises _ default_source compiles" do
    assert exercise_modules()
           |> Enum.each(fn module ->
             module.default_source()
             |> Code.eval_string([], __ENV__)
           end)
  end

  defp exercise_modules do
    {:ok, modules} = :application.get_key(:utils, :modules)

    modules
    |> Enum.filter(fn module ->
      case Module.split(module) do
        [_utils, "SmartCell", "Exercise" | []] ->
          false

        [_utils, "SmartCell" , "Exercise" | _tail] ->
          true

        _ ->
          false
      end
    end)
  end
end

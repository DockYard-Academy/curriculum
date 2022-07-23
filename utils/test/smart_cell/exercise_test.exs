defmodule Utils.SmartCell.ExerciseTest do
  use ExUnit.Case

  test "Exercises _ expected solution _ passes feedback test" do
    exercise_modules()
    |> Enum.each(fn module ->
      (module.expected_solution() <> module.feedback())
      |> Code.eval_string([], __ENV__)
    end)
  end

  test "Exercises _ expected solution _ default_source compiles" do
    assert exercise_modules()
           |> Enum.each(fn module ->
             module.default_source()
             |> Code.eval_string([], __ENV__)
           end)
  end

  def exercise_modules do
    {:ok, modules} = :application.get_key(:utils, :modules)

    modules
    |> Enum.filter(fn module ->
      case Module.split(module) do
        [_utils, "SmartCell", "Exercise" | _tail] ->
          false

        [_utils, "SmartCell" | _tail] ->
          true

        _ ->
          false
      end
    end)
  end
end

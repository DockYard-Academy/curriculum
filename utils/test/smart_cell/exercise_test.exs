defmodule Utils.SmartCell.ExerciseTest do
  use ExUnit.Case
  alias Utils.SmartCell.Exercise

  test "Exercise Modules" do
    assert Utils.SmartCell.Exercise.StringConcatenationMadlib in Exercise.smart_cells()
  end

  test "Exercises _ possible solution _ passes feedback test" do
    Exercise.smart_cells()
    |> Enum.each(fn module ->
      # runs assertions against possible solution to ensure possible solution passes tests.
      (module.possible_solution() <> module.feedback())
      |> Code.eval_string([], __ENV__)
    end)
  end

  test "Exercises _ default_source compiles" do
    assert Exercise.smart_cells()
           |> Enum.each(fn module ->
             # ensures default source compiles
             module.default_source()
             |> Code.eval_string([], __ENV__)
           end)
  end
end

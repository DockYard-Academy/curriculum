defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils
  alias Utils.Solutions
  alias Utils.Factory

  test "slide/1" do
    Utils.Slide.__info__(:functions)
    |> Enum.each(fn {slide_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.slide(slide_name)
    end)
  end

  test "table/1" do
    Utils.Table.__info__(:functions)
    |> Enum.each(fn {table_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.table(table_name)
    end)
  end

  test "graph/1" do
    Utils.Graph.__info__(:functions)
    |> Enum.each(fn {graph_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.graph(graph_name)
    end)
  end

  test "constants/1" do
    Utils.Constants.__info__(:functions)
    |> Enum.each(fn {constant_name, _arity} ->
      assert Utils.constants(constant_name)
    end)
  end

  test "form/1" do
    Utils.Form.__info__(:functions)
    |> Enum.each(fn {form_name, _arity} ->
      assert %Kino.JS{} = Utils.form(form_name)
    end)
  end

  test "random" do
    assert Utils.random(:rock_paper_scissors) in [:rock, :paper, :scissors]
    assert Utils.random(1..9) in 1..9
  end

  test "feedback/2" do
    Enum.each(Utils.Feedback.test_names(), fn each ->
      exists = Keyword.has_key?(Solutions.__info__(:functions), each)

      if !exists do
        raise "define a Solutions.#{Atom.to_string(each)} function."
      end
    end)

    execute_tests_until_failure(Utils.Feedback.test_names())
  end

  test "feedback/2 with invalid atom" do
    atom = Factory.string() |> String.to_atom()

    assert Utils.feedback(atom, "non-nil answer") ==
             "Something went wrong, feedback does not exist for #{atom}. Please speak to your teacher and/or reset the exercise."
  end

  defp execute_tests_until_failure([]), do: nil

  defp execute_tests_until_failure([test | tail]) do
    test_failed = Utils.feedback(test, apply(Solutions, test, [])).failures > 0

    unless test_failed do
      execute_tests_until_failure(tail)
    end
  end
end

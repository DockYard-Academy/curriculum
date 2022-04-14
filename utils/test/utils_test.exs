defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils
  alias Utils.Solutions

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
      assert Keyword.has_key?(Solutions.__info__(:functions), each),
             "define a Solutions.#{Atom.to_string(each)} function."

      Utils.feedback(each, apply(Solutions, each, []))
    end)
  end
end

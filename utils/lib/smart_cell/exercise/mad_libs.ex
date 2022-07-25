defmodule Utils.SmartCell.Exercise.MadLibs do
  use Utils.SmartCell.Exercise

  @impl true
  def default_source do
    """
    name_of_company = nil
    a_defined_offering = nil
    a_defined_audience = nil
    solve_a_problem = nil
    secret_sauce = nil

    madlib = nil
    """
  end

  @impl true
  def possible_solution do
    """
    name_of_company = "DockYard"
    a_defined_offering = "DockYard Academy"
    a_defined_audience = "Junior Developers"
    solve_a_problem = "learn Elixir"
    secret_sauce = "Livebook"

    madlib = "My company, " <> name_of_company <> ", is developing " <> a_defined_offering <> " to help " <> a_defined_audience <> " " <> solve_a_problem <> " with " <> secret_sauce <> "."
    """
  end

  @impl true
  def feedback do
    """
    assert is_binary(name_of_company) and name_of_company != "", "name_of_company should be a non-empty string"
    assert is_binary(a_defined_offering) and a_defined_offering != "", "a_defined_offering should be a non-empty string"
    assert is_binary(a_defined_audience) and a_defined_audience != "", "a_defined_audience should be a non-empty string"
    assert is_binary(solve_a_problem) and solve_a_problem != "", "solve_a_problem should be a non-empty string"
    assert is_binary(secret_sauce) and secret_sauce != "", "secret_sauce should be a non-empty string"
    assert String.contains?(madlib, name_of_company), "name_of_company should be used in the madlib"
    assert String.contains?(madlib, a_defined_offering), "a_defined_offering should be used in the madlib"
    assert String.contains?(madlib, a_defined_audience), "a_defined_audience should be used in the madlib"
    assert String.contains?(madlib, solve_a_problem), "solve_a_problem should be used in the madlib"
    assert String.contains?(madlib, secret_sauce), "secret_sauce should be used in the madlib"
    """
  end
end

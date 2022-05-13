defmodule Utils.Feedback.BooleanOperators do
  use Utils.Feedback.Assertion

  feedback :boolean_diagram1 do
    answer = get_answers()
    assert answer == false
  end

  feedback :boolean_diagram2 do
    answer = get_answers()
    assert answer == true
  end

  feedback :boolean_diagram3 do
    answer = get_answers()
    assert answer == false
  end

  feedback :boolean_diagram4 do
    answer = get_answers()
    assert answer == false
  end

  feedback :boolean_diagram5 do
    answer = get_answers()
    assert answer == true
  end

  feedback :boolean_diagram6 do
    answer = get_answers()
    assert answer == true
  end

  def boolean_diagram1, do: false
  def boolean_diagram2, do: true
  def boolean_diagram3, do: false
  def boolean_diagram4, do: false
  def boolean_diagram5, do: true
  def boolean_diagram6, do: true
end

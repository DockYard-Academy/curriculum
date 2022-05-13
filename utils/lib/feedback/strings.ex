defmodule Utils.Feedback.Strings do
  use Utils.Feedback.Assertion

  feedback :string_concatenation do
    answer = get_answers()
    assert is_binary(answer) == true, "Ensure answer is a string."

    assert Regex.match?(~r/Hi, \w+\./, answer) == true,
           "Ensure answer is in the format: Hi, name."
  end

  feedback :string_interpolation do
    answer = get_answers()
    assert is_binary(answer) == true, "Ensure the answer is a string."

    assert Regex.match?(~r/I have \d+ classmate/, answer) == true,
           "Ensure the answer follows the format: I have X classmates."
  end

  def string_interpolation do
    "I have #{1 - 1} classmates."
  end

  def string_concatenation do
    "Hi, Peter."
  end
end

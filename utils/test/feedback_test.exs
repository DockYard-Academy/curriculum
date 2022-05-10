defmodule Utils.FeedbackTest do
  use ExUnit.Case
  doctest Utils.Feedback
  alias Utils.Feedback
  alias Utils.Solutions

  test "test_names" do
    assert length(Feedback.solutions()) >= 1
  end

  test "solutions" do
    Enum.each(Feedback.solutions(), fn each ->
      solution = apply(Solutions, each, [])
      assert Feedback.feedback(each, solution) == :ok
    end)
  end

  test "solution fails" do
    assert Feedback.feedback(:card_count_four, 10) == :error
  end
end

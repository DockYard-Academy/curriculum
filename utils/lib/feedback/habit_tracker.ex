defmodule Utils.Feedback.HabitTracker do
  use Utils.Feedback.Assertion

  feedback :habit_tracker_definition do
    [small, medium, large] = get_answers()
    assert small == 5
    assert medium == 20
    assert large == 30
  end

  feedback :habit_tracker_add do
    total_points = get_answers()
    assert total_points == 20 + 5
  end

  feedback :habit_tracker_percentage do
    percentage = get_answers()
    assert percentage == (5 + 20) / 40 * 100
  end

  feedback :habit_tracker_penalties_1 do
    total_points = get_answers()
    assert total_points == 5 + 20 + 30 * 0.5
  end

  feedback :habit_tracker_penalties_2 do
    total_points = get_answers()
    assert total_points == 5 / 2 * 3 + 20 / 2 * 3
  end

  feedback :habit_tracker_rewards do
    total_points = get_answers()
    assert total_points == 20 * 1.6 + 5 * 1.6 + 30 * 0.5
  end

  def habit_tracker_rewards do
    20 * 1.6 + 5 * 1.6 + 30 * 0.5
  end

  def habit_tracker_penalties_1 do
    5 + 20 + 30 * 0.5
  end

  def habit_tracker_penalties_2 do
    5 / 2 * 3 + 20 / 2 * 3
  end

  def habit_tracker_percentage do
    (5 + 20) / 40 * 100
  end

  def habit_tracker_add do
    20 + 5
  end

  def habit_tracker_definition do
    [5, 20, 30]
  end
end

defmodule Games.ScoreTrackerTest do
  use ExUnit.Case
  doctest Games.ScoreTracker
  alias Games.ScoreTracker

  test "current_score/1 retrieves the current score" do
    {:ok, pid} = ScoreTracker.start_link([])
    assert ScoreTracker.current_score(pid) == 0
  end

  test "add_points/1 adds points to the score" do
    {:ok, pid} = ScoreTracker.start_link([])
    ScoreTracker.add_points(pid, 10)
    ScoreTracker.add_points(pid, 10)
    assert ScoreTracker.current_score(pid) == 20
  end
end

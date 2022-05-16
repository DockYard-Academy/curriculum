defmodule Utils.Feedback.VoterCount do
  use Utils.Feedback.Assertion

  feedback :voter_count do
    voter_count = get_answers()

    assert voter_count.count([], :test), "Implement the `count` function."

    assert voter_count.count([:dogs, :dogs, :dogs, :cats], :dogs) == 3,
           "failed on ([:dogs, :dogs, :dogs, :cats], :dogs)"

    assert voter_count.count([:dogs, :dogs, :dogs, :cats], :cats) == 1,
           "Failed on ([:dogs, :dogs, :dogs, :cats], :cats)"

    assert voter_count.count([:apples, :oranges, :apples, :cats], :birds) == 0,
           "Failed on ([:apples, :oranges, :apples, :cats], :birds)"

    list = Enum.map(1..10, fn _ -> Enum.random([:cat, :dog, :bird, :apple, :orange]) end)
    choice = Enum.random([:cat, :dog, :bird, :apple, :orange])
    assert voter_count.count(list, choice) == Enum.count(list, fn each -> each == choice end)
  end

  defmodule VoterCount do
    def count(list_of_votes, vote) do
      Enum.count(list_of_votes, fn each -> each == vote end)
    end
  end

  def voter_count do
    VoterCount
  end
end

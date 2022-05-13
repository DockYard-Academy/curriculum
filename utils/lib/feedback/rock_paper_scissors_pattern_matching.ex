defmodule Utils.Feedback.RockPaperScissorsPatternMatching do
  use Utils.Feedback.Assertion

  feedback :rock_paper_scissors_pattern_matching do
    rock_paper_scissors = get_answers()

    assert rock_paper_scissors.play(:rock, :rock) == "draw",
           "Ensure you implement the RockPaperScissors.play/2 function."

    assert rock_paper_scissors.play(:paper, :paper) == "draw"
    assert rock_paper_scissors.play(:scissors, :scissors) == "draw"

    assert rock_paper_scissors.play(:rock, :scissors) == ":rock beats :scissors!"
    assert rock_paper_scissors.play(:scissors, :paper) == ":scissors beats :paper!"
    assert rock_paper_scissors.play(:paper, :rock) == ":paper beats :rock!"

    assert rock_paper_scissors.play(:rock, :paper) == ":paper beats :rock!"
    assert rock_paper_scissors.play(:scissors, :rock) == ":rock beats :scissors!"
    assert rock_paper_scissors.play(:paper, :scissors) == ":scissors beats :paper!"
  end

  defmodule Solution do
    def play(guess1, guess2) do
      case {guess1, guess2} do
        {:paper, :rock} -> ":paper beats :rock!"
        {:scissors, :paper} -> ":scissors beats :paper!"
        {:rock, :scissors} -> ":rock beats :scissors!"
        {:rock, :paper} -> ":paper beats :rock!"
        {:scissors, :rock} -> ":rock beats :scissors!"
        {:paper, :scissors} -> ":scissors beats :paper!"
        _ -> "draw"
      end
    end
  end

  def rock_paper_scissors_pattern_matching do
    Solution
  end
end

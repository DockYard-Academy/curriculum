defmodule Utils.Feedback.RockPaperScissors do
  use Utils.Feedback.Assertion

  feedback :rock_paper_scissors_ai do
    [player_choice, ai_choice] = get_answers()

    case player_choice do
      :rock ->
        assert ai_choice === :paper,
               "when player_choice is :rock, ai_choice should be :paper."

      :paper ->
        assert ai_choice === :scissors,
               "when player_choice is :paper, ai_choice should be :scissors."

      :scissors ->
        assert ai_choice === :rock,
               "when player_choice is :scissors, ai_choice should be :rock."
    end
  end

  feedback :rock_paper_scissors_two_player do
    [player1_choice, player2_choice, winner] = get_answers()

    case {player1_choice, player2_choice} do
      {:rock, :scissors} -> assert winner == :player1
      {:paper, :rock} -> assert winner == :player1
      {:scissors, :paper} -> assert winner == :player1
      {:scissors, :rock} -> assert winner == :player2
      {:rock, :paper} -> assert winner == :player2
      {:paper, :scissors} -> assert winner == :player2
      _ -> assert winner == :draw
    end
  end

  def rock_paper_scissors_ai do
    player_choice = Enum.random([:rock, :paper, :scissors])

    ai_choice =
      (player_choice == :rock && :paper) || (player_choice == :paper && :scissors) ||
        (player_choice == :scissors && :rock)

    [player_choice, ai_choice]
  end

  def rock_paper_scissors_two_player do
    player1_choice = Utils.random(:rock_paper_scissors)
    player2_choice = Utils.random(:rock_paper_scissors)

    winner =
      case {player1_choice, player2_choice} do
        {:rock, :scissors} -> :player1
        {:paper, :rock} -> :player1
        {:scissors, :paper} -> :player1
        {:scissors, :rock} -> :player2
        {:rock, :paper} -> :player2
        {:paper, :scissors} -> :player2
        _ -> :draw
      end

    [player1_choice, player2_choice, winner]
  end
end

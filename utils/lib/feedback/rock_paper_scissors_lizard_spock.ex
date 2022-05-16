defmodule Utils.Feedback.RockPaperScissorsLizardSpock do
  use Utils.Feedback.Assertion

  feedback :rock_paper_scissors_lizard_spock do
    module = get_answers()

    assert Keyword.has_key?(module.__info__(:functions), :play),
           "Ensure you define the `play/2` function"

    game_permutations =
      for player1 <- [:rock, :paper, :scissors, :lizard, :spock],
          player2 <- [:rock, :paper, :scissors, :lizard, :spock] do
        {player1, player2}
      end

    beats? = fn player1, player2 ->
      {player1, player2} in [
        {:rock, :paper},
        {:paper, :rock},
        {:scissors, :paper},
        {:rock, :lizard},
        {:lizard, :spock},
        {:scissors, :lizard},
        {:lizard, :paper},
        {:paper, :spock},
        {:spock, :rock}
      ]
    end

    Enum.each(game_permutations, fn {p1, p2} ->
      expected_result =
        cond do
          beats?.(p1, p2) -> "#{p1} beats #{p2}."
          beats?.(p2, p1) -> "#{p2} beats #{p1}."
          true -> "tie game, play again?"
        end

      actual = module.play(p1, p2)

      assert actual == expected_result,
             "Failed on RockPaperScissorsLizardSpock.play(:#{p1}, :#{p2})."
    end)
  end

  defmodule RockPaperScissorsLizardSpock do
    defp beats?(p1, p2) do
      {p1, p2} in [
        {:rock, :paper},
        {:paper, :rock},
        {:scissors, :paper},
        {:rock, :lizard},
        {:lizard, :spock},
        {:scissors, :lizard},
        {:lizard, :paper},
        {:paper, :spock},
        {:spock, :rock}
      ]
    end

    def play(p1, p2) do
      cond do
        beats?(p1, p2) -> "#{p1} beats #{p2}."
        beats?(p2, p1) -> "#{p2} beats #{p1}."
        true -> "tie game, play again?"
      end
    end
  end

  def rock_paper_scissors_lizard_spock do
    RockPaperScissorsLizardSpock
  end
end

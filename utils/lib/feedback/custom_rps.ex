defmodule Utils.Feedback.CustomRps do
  use Utils.Feedback.Assertion

  feedback :custom_rps do
    custom_game_module = get_answers()

    assert 3 == Keyword.get(custom_game_module.__info__(:functions), :new),
           "Ensure you define the `new/3` function"

    assert Keyword.get(custom_game_module.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert %{rock: _, paper: _, scissors: _} = struct(custom_game_module),
           "Ensure you use `defstruct` with :rock, :paper, and :scissors."

    assert %{rock: :custom_rock, paper: :custom_paper, scissors: :custom_scissors} =
             custom_game_module.new(:custom_rock, :custom_paper, :custom_scissors)

    assert 3 == Keyword.get(custom_game_module.__info__(:functions), :play),
           "Ensure you define the `play/3` function"

    game = custom_game_module.new(:custom_rock, :custom_paper, :custom_scissors)

    beats? = fn p1, p2 ->
      {p1, p2} in [
        {:custom_rock, :custom_scissors},
        {:custom_paper, :custom_rock},
        {:custom_scissors, :custom_paper}
      ]
    end

    for player1 <- [:custom_rock, :custom_paper, :custom_scissors],
        player2 <- [:custom_rock, :custom_paper, :custom_scissors] do
      result = custom_game_module.play(game, player1, player2)

      expected_result =
        cond do
          beats?.(player1, player2) -> "#{player1} beats #{player2}"
          beats?.(player2, player1) -> "#{player2} beats #{player1}"
          true -> "draw"
        end

      assert result == expected_result,
             "Failed on CustomGame.play/3(#{inspect(game)}, #{player1}, #{player2})"
    end
  end

  defmodule CustomGame do
    @enforce_keys [:rock, :paper, :scissors]
    defstruct @enforce_keys

    def new(rock, paper, scissors) do
      %__MODULE__{rock: rock, paper: paper, scissors: scissors}
    end

    def convert_choice(game, choice) do
      %{rock: rock, paper: paper, scissors: scissors} = game

      case choice do
        ^rock -> :rock
        ^paper -> :paper
        ^scissors -> :scissors
      end
    end

    def beats?(game, player1, player2) do
      {convert_choice(game, player1), convert_choice(game, player2)} in [
        {:rock, :scissors},
        {:paper, :rock},
        {:scissors, :paper}
      ]
    end

    def play(game, player1, player2) do
      cond do
        beats?(game, player1, player2) ->
          "#{player1} beats #{player2}"

        beats?(game, player2, player1) ->
          "#{player2} beats #{player1}"

        true ->
          "draw"
      end
    end
  end

  def custom_rps do
    CustomGame
  end
end

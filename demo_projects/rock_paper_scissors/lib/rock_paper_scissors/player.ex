defmodule RockPaperScissors.Player do
  
  use Agent

  defstruct wins: 0, loses: 0, draws: 0, guess: nil

  def start_link(player) do
    Agent.start_link(fn -> %__MODULE__{} end, name: player)
  end

  def get(player_name) do
    Agent.get(player_name, fn player -> player end)
  end


  def guess(player_name, guess) when guess in [:rock, :paper, :scissors] do
    Agent.update(player_name, fn player -> %{player | guess: guess} end)
  end

  # def guess(player_name, _invalid_guess), do: {:error, :invalid_guess}

  def play(player1_name, player2_name) do
    guess1 = get_guess(player1_name)
    guess2 = get_guess(player2_name)

    cond do
      beats?(guess1, guess2) ->
        win(player1_name)
        lose(player2_name)

      beats?(guess2, guess1) ->
        lose(player1_name)
        win(player2_name)

      guess1 === guess2 ->
        draw(player1_name)
        draw(player2_name)
    end
  end

  defp get_guess(player_name) do
    Agent.get(player_name, fn player -> player.guess end)
  end

  def beats?(guess1, guess2) do
    case {guess1, guess2} do
      {:rock, :scissors} -> true
      {:scissors, :paper} -> true
      {:paper, :rock} -> true
      _ -> false
    end
  end

  defp win(player_name) do
    Agent.update(player_name, fn player ->
      %{player | wins: player.wins + 1, guess: nil}
    end)
  end

  defp lose(player_name) do
    Agent.update(player_name, fn player ->
      %{player | loses: player.loses + 1, guess: nil}
    end)
  end

  defp draw(player) do
    Agent.update(player, fn player_struct ->
      %{player_struct | draws: player_struct.draws + 1, guess: nil}
    end)
  end
end

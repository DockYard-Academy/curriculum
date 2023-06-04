defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  """
  def main(args) do
    choice =
      IO.gets("""
      What game would you like to play?
      1. Guessing Game
      2. Rock Paper Scissors
      3. Wordle

      enter "stop" to exit
      enter "score" to view your current score
      """)
      |> String.trim()

    case choice do
      "stop" ->
        :ok

      "score" ->
        IO.puts("""
          ==================================================
          Your score is #{Games.ScoreTracker.current_score()}
          ==================================================
        """)

      "1" ->
        Games.GuessingGame.play()

      "2" ->
        Games.RockPaperScissors.play()

      "3" ->
        Games.Wordle.play()

      _ ->
        IO.puts("Invalid choice!")
    end

    unless choice == "stop" do
      main(args)
    end
  end
end

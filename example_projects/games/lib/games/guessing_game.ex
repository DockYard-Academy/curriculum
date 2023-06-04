defmodule Games.GuessingGame do
  @moduledoc """
  Documentation for `Games.GuessingGame`.
  """
  def play(answer \\ nil, attempt \\ 1) do
    answer = answer || Enum.random(1..10)
    guess = IO.gets("Guess a number between 1 and 10: ") |> String.trim() |> String.to_integer()

    cond do
      answer == guess ->
        Games.ScoreTracker.add_points(10)
        IO.puts("You win!")

      attempt == 5 ->
        IO.puts("You lose! The answer was #{answer}!")

      guess < answer ->
        IO.puts("Too low!")
        play(answer, attempt + 1)

      guess > answer ->
        IO.puts("Too high!")
        play(answer, attempt + 1)
    end
  end
end

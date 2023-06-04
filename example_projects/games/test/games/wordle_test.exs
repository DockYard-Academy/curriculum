defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle
  alias Games.Wordle
  import IO.ANSI, only: [green: 0, yellow: 0, light_black: 0, reset: 0]

  describe "feedback/2" do
    test "all greens" do
      #                      answer   guess
      assert Wordle.feedback("AAAAA", "AAAAA") == [:green, :green, :green, :green, :green]
    end

    test "all greys" do
      assert Wordle.feedback("AAAAA", "BBBBB") == [:grey, :grey, :grey, :grey, :grey]
    end

    test "all yellows" do
      assert Wordle.feedback("ABCDE", "EDBCA") == [:yellow, :yellow, :yellow, :yellow, :yellow]
    end

    test "greens, greys, and yellows" do
      assert Wordle.feedback("ABCDE", "ABXEC") == [:green, :green, :grey, :yellow, :yellow]
    end

    test "same letter is multiple colors" do
      assert Wordle.feedback("XXXAA", "AAAAY") == [:yellow, :grey, :grey, :green, :grey]
    end
  end

  test "colored_feedback" do
    expected =
      green() <>
        "a" <>
        green() <>
        "p" <>
        light_black() <>
        "p" <>
        yellow() <>
        "l" <>
        green() <>
        "e" <>
        reset()

    assert Wordle.colored_feedback([:green, :green, :grey, :yellow, :green], "apple") == expected
  end
end

defmodule RockPaperScissors.PlayerTest do
  use ExUnit.Case
  doctest RockPaperScissors.Player
  alias RockPaperScissors.Player

  describe "Player" do
    test "start_link/1" do
      {:ok, pid} = Player.start_link(:player1)
      assert is_pid(pid)
    end

    test "get/1" do
      Player.start_link(:player1)
      assert %Player{wins: 0, loses: 0, draws: 0, guess: nil} = Player.get(:player1)
    end

    test "guess/1" do
      Player.start_link(:player1)
      Player.guess(:player1, :rock)
      assert %Player{wins: 0, loses: 0, draws: 0, guess: :rock} = Player.get(:player1)
    end

    test "guess/1 invalid guess" do
      Player.start_link(:player1)
      assert {:error, :invalid_guess} = Player.guess(:player1, :invalid_guess)
      assert %Player{wins: 0, loses: 0, draws: 0, guess: nil} = Player.get(:player1)
    end

    test "play/1 _ draw with :rock" do
      Player.start_link(:player1)
      Player.start_link(:player2)
      Player.guess(:player1, :rock)
      Player.guess(:player2, :rock)
      Player.play(:player1, :player2)
      assert %Player{wins: 0, loses: 0, draws: 1, guess: nil} = Player.get(:player1)
      assert %Player{wins: 0, loses: 0, draws: 1, guess: nil} = Player.get(:player2)
    end

    test "play/1 _ :rock beats :scissors" do
      Player.start_link(:player1)
      Player.start_link(:player2)
      Player.guess(:player1, :rock)
      Player.guess(:player2, :scissors)
      Player.play(:player1, :player2)
      assert %Player{wins: 1, loses: 0, draws: 0, guess: nil} = Player.get(:player1)
      assert %Player{wins: 0, loses: 1, draws: 0, guess: nil} = Player.get(:player2)
    end

    test "play/1 _ :rock beats :scissors _ player2 wins" do
      Player.start_link(:player1)
      Player.start_link(:player2)
      Player.guess(:player1, :scissors)
      Player.guess(:player2, :rock)
      Player.play(:player1, :player2)
      assert %Player{wins: 0, loses: 1, draws: 0, guess: nil} = Player.get(:player1)
      assert %Player{wins: 1, loses: 0, draws: 0, guess: nil} = Player.get(:player2)
    end

    test "beats?/1" do
      assert Player.beats?(:rock, :scissors)
      assert Player.beats?(:scissors, :paper)
      assert Player.beats?(:paper, :rock)

      refute Player.beats?(:rock, :paper)
      refute Player.beats?(:scissors, :rock)
      refute Player.beats?(:paper, :scissors)

      refute Player.beats?(:rock, :rock)
      refute Player.beats?(:paper, :paper)
      refute Player.beats?(:scissors, :scissors)
    end

    # Draws
    for option <- [:rock, :paper, :scissors] do
      test "play/1 _ draw with #{option}" do
        option = unquote(option)
        Player.start_link(:player1)
        Player.start_link(:player2)
        Player.guess(:player1, option)
        Player.guess(:player2, option)
        Player.play(:player1, :player2)
        assert %Player{wins: 0, loses: 0, draws: 1, guess: nil} = Player.get(:player1)
        assert %Player{wins: 0, loses: 0, draws: 1, guess: nil} = Player.get(:player2)
      end
    end

    # Wins
    for {winner, loser} <- [{:rock, :scissors}, {:paper, :rock}, {:scissors, :paper}] do
      test "play/1 _ #{winner} beats #{loser}" do
        winner = unquote(winner)
        loser = unquote(loser)
        Player.start_link(:player1)
        Player.start_link(:player2)
        Player.guess(:player1, winner)
        Player.guess(:player2, loser)
        Player.play(:player1, :player2)
        assert %Player{wins: 1, loses: 0, draws: 0, guess: nil} = Player.get(:player1)
        assert %Player{wins: 0, loses: 1, draws: 0, guess: nil} = Player.get(:player2)
      end
    end

    test "play/1 no guess" do
      Player.start_link(:player1)
      Player.start_link(:player2)
      assert {:error, _} = Player.play(:player1, :player2)
      assert %Player{wins: 0, loses: 0, draws: 0, guess: nil} = Player.get(:player1)
      assert %Player{wins: 0, loses: 0, draws: 0, guess: nil} = Player.get(:player2)
    end
  end
end

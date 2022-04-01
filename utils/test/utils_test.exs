defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils
end

player1_choice = Enum.random([:rock, :paper, :scissors])
player2_choice = Enum.random([:rock, :paper, :scissors])

winner =
  (player1_choice == :rock && player2_choice == :scissors && :player1) ||
    (player1_choice == :scissors && player2_choice == :paper && :player1) ||
    (player1_choice == :paper && player2_choice == :rock && :player1) ||
    (player2_choice == :rock && player1_choice == :scissors && :player2) ||
    (player2_choice == :scissors && player1_choice == :paper && :player2) ||
    (player2_choice == :paper && player1_choice == :rock && :player2) || :draw

Utils.test(:rock_paper_scissors_two_player, [player1_choice, player2_choice, winner])

defmodule Utils.Solutions do
  def startup_madlib do
    name_of_company = "a"
    a_defined_offering = "a"
    a_defined_audience = "a"
    solve_a_problem = "a"
    secret_sauce = "a"

    madlib =
      "My company, #{name_of_company} is developing #{a_defined_offering} to help #{a_defined_audience} #{solve_a_problem} with #{secret_sauce}."

    [
      madlib,
      name_of_company,
      a_defined_offering,
      a_defined_audience,
      solve_a_problem,
      secret_sauce
    ]
  end

  def nature_show_madlib do
    animal = "a"
    country = "a"
    plural_noun = "a"
    a_food = "a"
    type_of_screen_device = "a"
    noun = "a"
    verb1 = "a"
    verb2 = "a"
    adjective = "a"

    madlib =
      "The majestic #{animal} has roamed the forests of #{country} for thousands of years. Today she wanders in search of #{plural_noun}. She must find food to survive. While hunting for #{a_food}, she found a/an #{type_of_screen_device} hidden behind a #{noun}. She has never seen anything like this before. What will she do? With the device in her teeth, she tries to #{verb1}, but nothing happens. She takes it back to her family. When her family sees it, they quickly #{verb2}. Soon, the device becomes #{adjective}, and the family decides to put it back where they found it."

    [
      animal,
      country,
      plural_noun,
      a_food,
      type_of_screen_device,
      noun,
      verb1,
      verb2,
      adjective,
      madlib
    ]
  end

  def rocket_ship do
    20
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

  def boolean_diagram1, do: false
  def boolean_diagram2, do: true
  def boolean_diagram3, do: false
  def boolean_diagram4, do: false
  def boolean_diagram5, do: true
  def boolean_diagram6, do: true

  def guess_the_word do
    guess = Enum.random(["answer", "incorrect answer"])
    answer = "answer"
    correct = (guess == answer && "Correct!") || "Incorrect."
    [guess, answer, correct]
  end

  def guess_the_number do
    guess = Enum.random(1..9)
    answer = Enum.random(1..9)

    correct =
      (guess == answer && "Correct") || (guess < answer && "Too low!") ||
        (guess > answer && "Too high!")

    [guess, answer, correct]
  end
end

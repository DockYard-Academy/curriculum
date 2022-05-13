defmodule Utils.Feedback.GuessingGames do
  use Utils.Feedback.Assertion

  feedback :guess_the_word do
    [guess, answer, correct] = answers = get_answers()

    assert Enum.all?(answers, &is_binary/1) == true,
           "Ensure `guess`, `answer`, and `correct` are all strings"

    if guess == answer do
      assert correct == "Correct!"
    else
      assert correct == "Incorrect."
    end
  end

  feedback :guess_the_number do
    [guess, answer, correct] = get_answers()

    assert is_integer(guess) == true, "Ensure `guess` is an integer"
    assert is_integer(answer) == true, "Ensure `answer` is an integer"
    assert is_binary(correct) == true, "Ensure `correct` is a string"

    cond do
      guess == answer -> assert correct == "Correct!"
      guess < answer -> assert correct == "Too low!"
      guess > answer -> assert correct == "Too high!"
    end
  end

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
      (guess == answer && "Correct!") || (guess < answer && "Too low!") ||
        (guess > answer && "Too high!")

    [guess, answer, correct]
  end
end

defmodule Utils.Feedback.NamingNumbers do
  use Utils.Feedback.Assertion

  feedback :naming_numbers do
    naming_numbers = get_answers()

    assert is_function(naming_numbers),
           "Ensure you bind `naming_numbers` to an anonymous function."

    list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    Enum.each(1..9, fn integer ->
      assert naming_numbers.(integer) == Enum.at(list, integer)
    end)
  end

  feedback :numbering_names do
    numbering_names = get_answers()

    assert is_function(numbering_names),
           "Ensure you bind `numbering_names` to an anonymous function."

    assert arity(numbering_names) == 1,
           "Ensure the `numbering_names` function accepts one parameter."

    list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    capital_list = Enum.map(list, &String.capitalize/1)

    assert numbering_names.("zero") == 0
    assert numbering_names.("one") == 1
    assert numbering_names.("two") == 2
    assert numbering_names.("three") == 3
    assert numbering_names.("four") == 4
    assert numbering_names.("five") == 5
    assert numbering_names.("six") == 6
    assert numbering_names.("seven") == 7
    assert numbering_names.("eight") == 8
    assert numbering_names.("nine") == 9

    assert numbering_names.("Zero") == 0
    assert numbering_names.("One") == 1
    assert numbering_names.("Two") == 2
    assert numbering_names.("Three") == 3
    assert numbering_names.("Four") == 4
    assert numbering_names.("Five") == 5
    assert numbering_names.("Six") == 6
    assert numbering_names.("Seven") == 7
    assert numbering_names.("Eight") == 8
    assert numbering_names.("Nine") == 9
  end

  def naming_numbers do
    fn integer ->
      list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
      Enum.at(list, integer)
    end
  end

  def numbering_names do
    fn name ->
      list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
      Enum.find_index(list, fn each -> each == String.downcase(name) end)
    end
  end
end

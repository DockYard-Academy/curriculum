defmodule Utils.Feedback.MadLibs do
  use Utils.Feedback.Assertion

  feedback :startup_madlib do
    [
      madlib,
      name_of_company,
      a_defined_offering,
      a_defined_audience,
      solve_a_problem,
      secret_sauce
    ] = answers = get_answers()

    assert Enum.all?(answers, &is_binary/1) == true, "Ensure each madlib value is a string"

    assert Enum.all?(answers, fn each -> String.length(each) > 0 end) == true,
           "Ensure each madlib value is a non-empty string"

    expected_madlib =
      "My company, #{name_of_company} is developing #{a_defined_offering} to help #{a_defined_audience} #{solve_a_problem} with #{secret_sauce}."

    assert madlib == expected_madlib
  end

  feedback :nature_show_madlib do
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
    ] = answers = get_answers()

    assert Enum.all?(answers, &is_binary/1) == true, "Ensure each madlib value is a string"

    assert Enum.all?(answers, fn each -> String.length(each) > 0 end) == true,
           "Ensure each madlib value is a non-empty string"

    expected_madlib =
      "The majestic #{animal} has roamed the forests of #{country} for thousands of years. Today she wanders in search of #{plural_noun}. She must find food to survive. While hunting for #{a_food}, she found a/an #{type_of_screen_device} hidden behind a #{noun}. She has never seen anything like this before. What will she do? With the device in her teeth, she tries to #{verb1}, but nothing happens. She takes it back to her family. When her family sees it, they quickly #{verb2}. Soon, the device becomes #{adjective}, and the family decides to put it back where they found it."

    assert madlib == expected_madlib
  end

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
end

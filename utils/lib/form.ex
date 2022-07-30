defmodule Utils.Form do
  def comparison_operators_result do
    [
      %{label: "20 < 8", answers: ["false"]},
      %{label: "10 > 5", answers: ["true"]},
      %{label: "9 >= 3", answers: ["true"]},
      %{label: "11 == 10.9", answers: ["false"]},
      %{label: "11 === 10.9", answers: ["false"]},
      %{label: "4 === 4.0", answers: ["false"]},
      %{label: "4 == 4.0", answers: ["true"]},
      %{label: "4 <= 4.0", answers: ["true"]},
      %{label: "4 < 4.2", answers: ["true"]},
      %{label: "2 < 3 and 3 >= 3", answers: ["true"]}
    ]
  end

  def comparison_operators do
    [
      %{label: "7 __ 8", answers: ["<", "<="]},
      %{label: "8 __ 7", answers: [">", ">="]},
      %{label: "7 __ 8 and 7 __ 7", answers: ["<="]},
      %{label: "2 __ 1 and 4 __ 4", answers: [">="]},
      %{label: "20 __ 3 and 15 __ 3", answers: [">"]},
      %{label: "1 __ 10 and 5 __ 6", answers: ["<"]},
      %{
        label: "9 __ 9 and <b>not</b> 10 __ 10.0",
        answers: ["==="]
      },
      %{label: "8 __ 8.0 and 9 __ 9.0", answers: ["=="]}
    ]
  end

  def boolean_diagram1 do
    [%{label: "operator", answers: ["or"]}]
  end

  def boolean_diagram2 do
    [%{label: "operator", answers: ["and"]}]
  end

  def boolean_diagram3 do
    [%{label: "operator", answers: ["not"]}]
  end

  def boolean_fill_in_the_blank do
    [
      %{label: "not ____ and true === false", answers: ["true"]},
      %{label: "true ____ false === true", answers: ["or"]},
      %{label: "not true ____ true === true", answers: ["or"]},
      %{label: "not false ____ true === true", answers: ["and"]},
      %{label: "not (true and false) ____ false === true", answers: ["or"]},
      %{label: "not (true or false) or not (not ____ and true) === true", answers: ["false"]},
      %{label: "____ false and true === true", answers: ["not"]},
      %{label: "false or ____ true === false", answers: ["not"]}
    ]
  end

  def lists_vs_tuples do
    options = [
      "",
      "O(n)",
      "O(n*)",
      "O(1)",
      "O(n1)",
      "O(n1 + n2)"
    ]

    [
      %{label: "Concatenating two lists", answers: ["O(n1)"], options: options},
      %{label: "Inserting an element in tuple", answers: ["O(n)"], options: options},
      %{label: "Deleting an element in a list", answers: ["O(n*)"], options: options},
      %{label: "Prepending an element in a list", answers: ["O(1)"], options: options},
      %{label: "Updating an element in a list", answers: ["O(n*)"], options: options},
      %{label: "Concatenating two tuples", answers: ["O(n1 + n1)"], options: options},
      %{label: "Inserting an element in list", answers: ["O(n*)"], options: options},
      %{label: "Updating an element in tuple", answers: ["O(n)"], options: options},
      %{label: "Deleting an element in a tuple", answers: ["O(n)"], options: options},
      %{label: "Finding the length of a tuple", answers: ["O(1)"], options: options},
      %{label: "Feleting an element in a list", answers: ["O(n*)"], options: options},
      %{label: "Finding the length of a list", answers: ["O(n)"], options: options},
      %{label: "Finding the length of a list", answers: ["O(n)"]}
    ]
  end
end

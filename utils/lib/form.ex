defmodule Utils.Form do

  def comparison_operators do
    [
      %{label: "7 __ 8", answers: ["<"]},
      %{label: "8 __ 7", answers: [">"]},
      %{
        label: "8 __ 8 and 9 __ 9 and <b>not</b> 10 __ 10.0",
        answers: ["==="]
      },
      %{label: "8 __ 8.0 and 0 __ 9.0", answers: ["=="]},
      %{label: "8 __ 7 and 7 __ 7", answers: [">="]},
      %{label: "7 __ 8 and 7 __ 7", answers: ["<="]}
    ]
  end

  def boolean_diagram1 do
    [%{label: "operator", answers: ["or"]}]
  end

  def boolean_diagram2 do
    %{label: "operator", answers: ["and"]}
  end

  def boolean_diagram2 do
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
      %{label: "concatenating two lists", answers: ["O(n1)"], options: options},
      %{label: "inserting an element in tuple", answers: ["O(n)"], options: options},
      %{label: "deleting an element in a list", answers: ["O(n*)"], options: options},
      %{label: "prepending an element in a list", answers: ["O(1)"], options: options},
      %{label: "updating an element in a list", answers: ["O(n*)"], options: options},
      %{label: "concatenating two tuples", answers: ["O(n1 + n1)"], options: options},
      %{label: "inserting an element in list", answers: ["O(n*)"], options: options},
      %{label: "updating an element in tuple", answers: ["O(n)"], options: options},
      %{label: "deleting an element in a tuple", answers: ["O(n)"], options: options},
      %{label: "finding the length of a tuple", answers: ["O(1)"], options: options},
      %{label: "deleting an element in a list", answers: ["O(n*)"], options: options},
      %{label: "finding the length of a list", answers: ["O(n)"], options: options},
      %{label: "finding the length of a list", answers: ["O(n)"]}
    ]
  end
end

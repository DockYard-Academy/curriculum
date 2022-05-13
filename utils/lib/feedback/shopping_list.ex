defmodule Utils.Feedback.ShoppingList do
  use Utils.Feedback.Assertion

  feedback :shopping_list do
    shopping_list = get_answers()
    list = [] ++ ["grapes", "walnuts", "apples"]
    list = list ++ ["blueberries", "chocolate", "pizza"]
    list = list -- ["grapes", "walnuts"]
    list = list ++ ["banana", "banana", "banana"]

    assert is_list(shopping_list) == true, "Ensure shopping_list is still a list."

    assert Enum.sort(list) == Enum.sort(shopping_list),
           "Ensure your shopping list has all of the expected items"

    assert shopping_list == list, "Ensure you add and remove items in the expected order"
  end

  feedback :shopping_list_with_quantities do
    shopping_list = get_answers()
    list = [] ++ [milk: 1, eggs: 12]
    list = list ++ [bars_of_butter: 2, candies: 10]
    list = list -- [bars_of_butter: 2]
    list = list -- [candies: 10]
    list = list ++ [candies: 5]

    assert is_list(shopping_list) == true, "Ensure shopping_list is still a list."

    assert Enum.sort(shopping_list) == Enum.sort(shopping_list),
           "Ensure your shopping list has all of the expected items"

    assert shopping_list == list, "Ensure you add and remove items in the expected order"
  end

  def shopping_list do
    shopping_list = [] ++ ["grapes", "walnuts", "apples"]
    shopping_list = shopping_list ++ ["blueberries", "chocolate", "pizza"]
    shopping_list = shopping_list -- ["grapes", "walnuts"]
    shopping_list = shopping_list ++ ["banana", "banana", "banana"]
    shopping_list
  end

  def shopping_list_with_quantities do
    list = [] ++ [milk: 1, eggs: 12]
    list = list ++ [bars_of_butter: 2, candies: 10]
    list = list -- [bars_of_butter: 2]
    list = list -- [candies: 10]
    list = list ++ [candies: 5]
    list
  end
end

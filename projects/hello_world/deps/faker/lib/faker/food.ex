defmodule Faker.Food do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating food data.
  """

  @doc """
  Returns a random complete dish.

  ## Examples

      iex> Faker.Food.dish()
      "Vegetable Soup"
      iex> Faker.Food.dish()
      "Fish and chips"
      iex> Faker.Food.dish()
      "Pork belly buns"
      iex> Faker.Food.dish()
      "Pasta Carbonara"
  """
  @spec dish() :: String.t()
  localize(:dish)

  @doc """
  Returns a random description.

  ## Examples

      iex> Faker.Food.description()
      "Two buttermilk waffles, topped with whipped cream and maple syrup, a side of two eggs served any style, and your choice of smoked bacon or smoked ham."
      iex> Faker.Food.description()
      "28-day aged 300g USDA Certified Prime Ribeye, rosemary-thyme garlic butter, with choice of two sides."
      iex> Faker.Food.description()
      "Breaded fried chicken with waffles, and a side of maple syrup."
      iex> Faker.Food.description()
      "Creamy mascarpone cheese and custard layered between espresso and rum soaked house-made ladyfingers, topped with Valrhona cocoa powder."
  """
  @spec description() :: String.t()
  localize(:description)

  @doc """
  Returns a random ingredient.

  ## Examples

      iex> Faker.Food.ingredient()
      "Tomatoes"
      iex> Faker.Food.ingredient()
      "Albacore Tuna"
      iex> Faker.Food.ingredient()
      "Potatoes"
      iex> Faker.Food.ingredient()
      "Tinned"
  """
  @spec ingredient() :: String.t()
  localize(:ingredient)

  @doc """
  Returns a random spicy ingredient.

  ## Examples

      iex> Faker.Food.spice()
      "Garlic Salt"
      iex> Faker.Food.spice()
      "Ras-el-Hanout"
      iex> Faker.Food.spice()
      "Curry Hot"
      iex> Faker.Food.spice()
      "Peppercorns Mixed"
  """
  @spec spice() :: String.t()
  localize(:spice)

  @doc """
  Returns a random measurement.

  ## Examples

      iex> Faker.Food.measurement()
      "teaspoon"
      iex> Faker.Food.measurement()
      "gallon"
      iex> Faker.Food.measurement()
      "pint"
      iex> Faker.Food.measurement()
      "cup"
  """
  @spec measurement() :: String.t()
  localize(:measurement)

  @doc """
  Returns a random measurement size.

  ## Examples

      iex> Faker.Food.measurement_size()
      "1/4"
      iex> Faker.Food.measurement_size()
      "3"
      iex> Faker.Food.measurement_size()
      "1"
      iex> Faker.Food.measurement_size()
      "1/2"
  """
  @spec measurement_size() :: String.t()
  localize(:measurement_size)

  @doc """
  Returns a random metric measurement.

  ## Examples

      iex> Faker.Food.metric_measurement()
      "centiliter"
      iex> Faker.Food.metric_measurement()
      "deciliter"
      iex> Faker.Food.metric_measurement()
      "liter"
      iex> Faker.Food.metric_measurement()
      "milliliter"
  """
  @spec metric_measurement() :: String.t()
  localize(:metric_measurement)

  @doc """
  Returns a type of sushi.

  ## Examples

      iex> Faker.Food.sushi()
      "Whitespotted conger"
      iex> Faker.Food.sushi()
      "Japanese horse mackerel"
      iex> Faker.Food.sushi()
      "Salmon"
      iex> Faker.Food.sushi()
      "Octopus"
  """
  @spec sushi() :: String.t()
  localize(:sushi)
end

defmodule Faker.Pizza do
  import Faker, only: [sampler: 2]

  alias Faker.Util

  @moduledoc """
  Functions for generating Pizza related data in English.
  """

  @doc """
  Returns a list with a number of pizzas.

  If an integer is provided, exactly that number of pizzas will be returned.
  If a range is provided, the number will be in the range.
  If no range or integer is specified it defaults to 2..5

  ## Examples

      iex> Faker.Pizza.pizzas()
      [
        "14\\" Greek Maltija",
        "Large with Reindeer, Buffalo Chicken, Egg, Chorizo, and Clam",
        "9\\" Capricciosa",
        "9\\" Sicilian Style Frutti di mare"
      ]
      iex> Faker.Pizza.pizzas(2..3)
      [
        "12\\" Fajita",
        "Medium Fajita"
      ]
      iex> Faker.Pizza.pizzas(3..4)
      [
        "Large Gluten-Free Corn with Oysters, Bacon, and Steak",
        "10\\" Flatbread Grilled Vegetarian",
        "30\\" Thai Chicken",
        "Small with Sauerkraut"
      ]
      iex> Faker.Pizza.pizzas(5)
      [
        "Large Quattro Formaggio",
        "Small Sweet Potato Crust with Mackerel, Jalapeños, Smoked Mozzarella, and Smoked Salmon",
        "30\\" with Pickled Ginger, Meatballs, Goat Cheese, Prosciutto, and Pineapple",
        "9\\" Detroit-style with Steak",
        "Family with Clam, Cherry Tomatoes, Salmon, and Chicken"
      ]
  """
  @spec pizzas(Range.t()) :: list(String.t())
  def pizzas(range \\ 2..5)

  def pizzas(first..last) do
    pizzas(Faker.random_between(first, last))
  end

  @spec pizzas(integer) :: list(String.t())
  def pizzas(num) do
    stream = Stream.repeatedly(&pizza/0)
    Enum.take(stream, num)
  end

  @doc """
  Returns a pizza

  ## Examples

      iex> Faker.Pizza.pizza()
      "16\\" with Fior di latte"
      iex> Faker.Pizza.pizza()
      "Medium New York Style with Clam and Reindeer"
      iex> Faker.Pizza.pizza()
      "9\\" Supreme"
      iex> Faker.Pizza.pizza()
      "16\\" Shrimp Club"
  """
  @spec pizza() :: String.t()
  def pizza, do: pizza(Faker.random_between(1, 30))
  defp pizza(n) when n <= 5, do: "#{size_or_inches()} with #{toppings_sentence(n)}"

  defp pizza(n) when n <= 10,
    do: "#{size_or_inches()} #{style()} with #{toppings_sentence(n - 5)}"

  defp pizza(n) when n <= 15, do: "#{size_or_inches()} #{style()} #{combo()}"
  defp pizza(_n), do: "#{size_or_inches()} #{combo()}"

  @doc """
  Returns a list with a number of toppings.

  If an integer is provided, exactly that number of toppings will be returned.
  If a range is provided, the number will be in the range.
  If no range or integer is specified it defaults to 2..5

  ## Examples

      iex> Faker.Pizza.toppings()
      ["Pesto Sauce", "Fior di latte", "Broccoli", "Banana Peppers"]
      iex> Faker.Pizza.toppings(4)
      ["Clam", "Reindeer", "Buffalo Chicken", "Egg"]
      iex> Faker.Pizza.toppings(2..3)
      ["Sausage", "Green Peas"]
      iex> Faker.Pizza.toppings(2..3)
      ["Shellfish", "Smoked Salmon"]
  """
  @spec toppings(Range.t()) :: list(String.t())
  def toppings(range \\ 2..5)

  def toppings(first..last) do
    toppings(Faker.random_between(first, last))
  end

  @spec toppings(integer) :: list(String.t())
  def toppings(num) do
    stream = Stream.repeatedly(&topping/0)
    Enum.take(stream, num)
  end

  defp toppings_sentence(num) do
    num |> toppings() |> Util.to_sentence()
  end

  @doc """
  Returns a random cheese, sauce, meat or vegetarian topping

  ## Examples

      iex> Faker.Pizza.topping()
      "Black Olives"
      iex> Faker.Pizza.topping()
      "Meatballs"
      iex> Faker.Pizza.topping()
      "Asiago"
      iex> Faker.Pizza.topping()
      "Philly Steak"
  """
  @spec topping() :: String.t()
  def topping, do: topping(Faker.random_between(0, 7))
  defp topping(0), do: cheese()
  defp topping(1), do: sauce()
  defp topping(count) when count <= 5, do: meat()
  defp topping(_count), do: vegetable()

  @doc """
  Returns a Pizza Restaurant string

  ## Examples

      iex> Faker.Pizza.company()
      "Papa Plastique"
      iex> Faker.Pizza.company()
      "Chicago Deep Dish"
      iex> Faker.Pizza.company()
      "Pizza Joe’s"
      iex> Faker.Pizza.company()
      "CosaNostra Pizza"
  """
  @spec company() :: String.t()
  sampler(:company, [
    "New York Style Pizza Co",
    "Chicago Deep Dish",
    "Pizza the Hutt",
    "Mystic Pizza",
    "Bob's Pizza-Burgers",
    "Only Cheese Pizzas",
    "California Style Pizzas",
    "Thin Crust or Bust",
    "Family Bros. Pizza",
    "Pizza Planet",
    "Polmieri Pizzeria",
    "Cheese E. Sneezers",
    "Mona Pizza",
    "J. Maggio's Pizza",
    "Pizza De Roma",
    "Dinosaur Pizza",
    "Pizza Potamus",
    "Pizza Forest",
    "Pizza This..",
    "Little Nero's Pizza",
    "Freddy Fazbear's Pizza",
    "The Pizza Hole",
    "Bloaty’s Pizza Hog",
    "Guidio’s Pizza Palace",
    "CosaNostra Pizza",
    "Gamer Pizzas",
    "Jubilee Pizza",
    "Maria’s Pasta and Pizza",
    "Nemo’s Pizza",
    "Paisanos",
    "Papa Plastique",
    "Pete’s Pizza",
    "Pizza Clown",
    "Pizza Face Pizza",
    "Pizza on a Stick",
    "Pizza Joe’s",
    "Pizza Pig-Out",
    "Pizza Shack",
    "Ron’s Pizza Hovel",
    "Sid’s Pizza Parlor"
  ])

  @doc """
  Returns a pizza style

  ## Examples

      iex> Faker.Pizza.style()
      "Pizza Frittata"
      iex> Faker.Pizza.style()
      "Gluten-Free Corn"
      iex> Faker.Pizza.style()
      "Detroit-style"
      iex> Faker.Pizza.style()
      "Stuffed Crust"
  """
  @spec style() :: String.t()
  sampler(:style, [
    "Wood Fired",
    "Thick Crust",
    "Thin Crust",
    "New York Style",
    "Deep Dish",
    "Stuffed Crust",
    "Detroit-style",
    "Kosher",
    "Gluten-Free Quinoa",
    "Flatbread",
    "Sweet Potato Crust",
    "Grilled",
    "New Haven Style",
    "Greek",
    "Sicilian Style",
    "Pizza Rustica",
    "Tomato Pie",
    "Pizza Bread",
    "Neapolitan",
    "Deep Fried Pizza",
    "Gluten-Free Corn",
    "Pizza Frittata",
    "Hand Tossed",
    "Multigrain",
    "Whole Wheat",
    "Fugazza",
    "Spooning Pizza"
  ])

  @doc """
  Returns a sauce string

  ## Examples

      iex> Faker.Pizza.sauce()
      "Spicy Tomato Sauce"
      iex> Faker.Pizza.sauce()
      "Hummus"
      iex> Faker.Pizza.sauce()
      "Pesto Sauce"
      iex> Faker.Pizza.sauce()
      "Hummus"
  """
  @spec sauce() :: String.t()
  sampler(:sauce, [
    "Soy Miso Sauce",
    "Masala Sauce",
    "Classic Tomato Sauce",
    "Spicy Tomato Sauce",
    "Clam Sauce",
    "Bechamel (White) Sauce",
    "Pesto Sauce",
    "BBQ Sauce",
    "Salsa",
    "Passata Sauce",
    "Chipolte Sauce",
    "Mango Sauce",
    "Siracha Sauce",
    "Buffalo Sauce",
    "Tomato Garlic Sauce",
    "Butter Chicken Sauce",
    "Olive Oil",
    "Hummus",
    "White Garlic Sauce",
    "Marinara Sauce",
    "Tapenade",
    "Romesco Sauce",
    "Chimichurri Sauce",
    "Gravy",
    "Aioli",
    "Hoisin Sauce",
    "Chili Sauce",
    "Sweet Chili Sauce",
    "Gremolata",
    "Mustard",
    "Curry",
    "Alfredo Sauce",
    "Zaatar"
  ])

  @doc """
  Returns a cheese string

  ## Examples

      iex> Faker.Pizza.cheese()
      "Mozzarella"
      iex> Faker.Pizza.cheese()
      "Marscapone"
      iex> Faker.Pizza.cheese()
      "Blue (Bleu) Cheese"
      iex> Faker.Pizza.cheese()
      "Smoked Mozzarella"
  """
  @spec cheese() :: String.t()
  sampler(:cheese, [
    "Mozzarella",
    "Cheddar",
    "Feta",
    "Secret Cheese Blend",
    "4 Cheese Blend",
    "Buffalo Mozzarella",
    "Asiago",
    "Romano",
    "Provolone",
    "Emmental",
    "Ricotta",
    "Marscapone",
    "Swiss",
    "Parmesan",
    "Smoked Mozzarella",
    "Blue (Bleu) Cheese",
    "Soy Cheese",
    "Lactose Free Cheese",
    "Whole Milk Mozzarella",
    "Burrata",
    "Goat Cheese",
    "Cashew Cheese",
    "Fior di latte",
    "Paneer",
    "Cheese Curds",
    "Gouda",
    "Fontina",
    "Gorgonzola",
    "Queso Fresco",
    "Crème fraîche"
  ])

  @doc """
  Returns a meat string

  ## Examples

      iex> Faker.Pizza.meat()
      "Buffalo Chicken"
      iex> Faker.Pizza.meat()
      "Meatballs"
      iex> Faker.Pizza.meat()
      "Chicken"
      iex> Faker.Pizza.meat()
      "Meatballs"
  """
  @spec meat() :: String.t()
  sampler(:meat, [
    "Anchovies",
    "Bacon",
    "Pulled Pork",
    "Buffalo Chicken",
    "Canadian Bacon",
    "Capicola",
    "Chicken",
    "Chorizo",
    "Clam",
    "Duck",
    "Eel",
    "Egg",
    "Gyro",
    "Ham",
    "Hamburger",
    "Hot Dogs",
    "Mackerel",
    "Meatballs",
    "Mutton",
    "Pepperoni",
    "Philly Steak",
    "Prosciutto",
    "Reindeer",
    "Salami",
    "Salmon",
    "Sausage",
    "Scallops",
    "Shellfish",
    "Shrimps",
    "Smoked Salmon",
    "Squid",
    "Steak",
    "Venison"
  ])

  @doc """
  Returns a vegetable string

  ## Examples

      iex> Faker.Pizza.vegetable()
      "Mango"
      iex> Faker.Pizza.vegetable()
      "Black Olives"
      iex> Faker.Pizza.vegetable()
      "Green Olives"
      iex> Faker.Pizza.vegetable()
      "Sauerkraut"
  """
  @spec vegetable() :: String.t()
  sampler(:vegetable, [
    "Artichoke Hearts",
    "Arugula",
    "Banana",
    "Banana Peppers",
    "Basil",
    "Black Olives",
    "Broccoli",
    "Capers",
    "Caramelised Onions",
    "Cherry Tomatoes",
    "Coconut",
    "Eggplant",
    "Garlic",
    "Green Olives",
    "Green Peas",
    "Green Peppers",
    "Habanero Peppers",
    "Jalapeños",
    "Mango",
    "Mushrooms",
    "Onions",
    "Oysters",
    "Peperoncini",
    "Pickled Ginger",
    "Pineapple",
    "Potatoes",
    "Red Onion",
    "Red Peppers",
    "Sauerkraut",
    "Spinach",
    "Sun-Dried Tomatoes",
    "Sweet Corn",
    "Sweet Potato",
    "Zucchini"
  ])

  @doc """
  Returns a combo string

  ## Examples

      iex> Faker.Pizza.combo()
      "Breakfast"
      iex> Faker.Pizza.combo()
      "Caprese"
      iex> Faker.Pizza.combo()
      "Mockba"
      iex> Faker.Pizza.combo()
      "Poutine"
  """
  @spec combo() :: String.t()
  sampler(:combo, [
    "Africana",
    "All Dressed",
    "Bacon Cheeseburger ",
    "BBQ Chicken",
    "Bianca ",
    "Bolognese",
    "Breakfast",
    "Buffalo Chicken",
    "Canadian",
    "Caprese",
    "Capricciosa",
    "Capricciosa ",
    "Cheese",
    "Chicken Pesto",
    "Ciao-ciao",
    "Curry Banana",
    "Double Dutch",
    "Fajita",
    "Fig and Goat Cheese",
    "Four Seasons",
    "Frutti di mare",
    "Funghi",
    "Grandma",
    "Greek",
    "Grilled Vegetarian",
    "Hawaiian",
    "Hot & Spicy",
    "Italian Deli",
    "Kebab",
    "Loaded",
    "Maltija",
    "Margherita",
    "Meat Feast",
    "Meat Lovers",
    "Meatball ",
    "Mockba",
    "Onion & Gorgonzola",
    "Pepperoni & Mushroom",
    "Perogie",
    "Pesto Chicken",
    "Poutine",
    "Prociutto Arugala",
    "Pugliese",
    "Quattro Formaggi",
    "Quattro Formaggio",
    "Quattro stagioni",
    "Romana",
    "Shrimp Club",
    "Smoked Salmon & Goat Cheese",
    "Supreme",
    "Taco",
    "Thai Chicken",
    "Vegetarian Lovers",
    "Vegetariana",
    "Veggie Korma",
    "Viennese"
  ])

  @doc """
  Returns a random size or inches

  ## Examples

      iex> Faker.Pizza.size_or_inches()
      "Family"
      iex> Faker.Pizza.size_or_inches()
      "14\\""
      iex> Faker.Pizza.size_or_inches()
      "Personal"
      iex> Faker.Pizza.size_or_inches()
      "Medium"
  """
  @spec size_or_inches() :: String.t()
  def size_or_inches, do: size_or_inches(Faker.random_between(0, 1))
  defp size_or_inches(0), do: size()
  defp size_or_inches(1), do: inches()

  @doc """
  Returns a size string

  ## Examples

      iex> Faker.Pizza.size()
      "Personal"
      iex> Faker.Pizza.size()
      "Family"
      iex> Faker.Pizza.size()
      "Large"
      iex> Faker.Pizza.size()
      "Medium"
  """
  @spec size() :: String.t()
  sampler(:size, ["Personal", "Small", "Medium", "Large", "Extra-Large", "Family"])

  @doc """
  Returns an inches string

  ## Examples

      iex> Faker.Pizza.inches()
      "9\\""
      iex> Faker.Pizza.inches()
      "10\\""
      iex> Faker.Pizza.inches()
      "16\\""
      iex> Faker.Pizza.inches()
      "14\\""
  """
  @spec inches() :: String.t()
  sampler(:inches, ["9\"", "10\"", "11\"", "12\"", "14\"", "16\"", "18\"", "20\"", "26\"", "30\""])
end

defmodule Utils.Factory do
  def name do
    Faker.Person.name()
  end

  def string do
    Faker.String.base64()
  end

  def integer(range \\ 0..100) do
    Enum.random(range)
  end

  def integers(range \\ 0..10) do
    Enum.map(range, fn _ -> integer() end)
  end

  def item_type do
    Enum.random([
      "sword",
      "halberd",
      "crossbow",
      "hammer",
      "mace",
      "longsword",
      "shortsword",
      "longbow"
    ])
  end

  def item_effect do
    Enum.random([
      "protection",
      "healing",
      "speed",
      "power",
      "jump"
    ])
  end

  def item_style do
    Enum.random(["holy", "dark", "heroic", "crude", "mundane", "lavish"])
  end

  def item(override \\ %{}) do
    Map.merge(
      %{
        type: item_type(),
        effect: item_effect(),
        style: item_style(),
        size: integer(1..10),
        level: integer(1..100)
      },
      override
    )
  end
end

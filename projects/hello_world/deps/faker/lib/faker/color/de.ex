defmodule Faker.Color.De do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for color data in German
  """

  @doc """
  Returns a random German color name

  ## Examples

      iex> Faker.Color.De.name()
      "Rot"
      iex> Faker.Color.De.name()
      "Grün"
      iex> Faker.Color.De.name()
      "Braun"
      iex> Faker.Color.De.name()
      "Rosa"
  """
  @spec name() :: String.t()
  sampler(:name, [
    "Rot",
    "Grün",
    "Schwarz",
    "Blau",
    "Rosa",
    "Braun",
    "Orange",
    "Gelb",
    "Lila",
    "Weiß"
  ])

  @doc """
  Returns a random english fancy color name

  ## Examples

      iex> Faker.Color.De.fancy_name()
      "Flieder"
      iex> Faker.Color.De.fancy_name()
      "Feldgrau"
      iex> Faker.Color.De.fancy_name()
      "Gelbgrün"
      iex> Faker.Color.De.fancy_name()
      "Rotbraun"
  """
  @spec fancy_name() :: String.t()
  sampler(:fancy_name, [
    "Flieder",
    "Feldgrau",
    "Gelbgrün",
    "Kuchiba",
    "Rotbraun",
    "Tannengrün",
    "Weinrot",
    "Zementgrau"
  ])
end

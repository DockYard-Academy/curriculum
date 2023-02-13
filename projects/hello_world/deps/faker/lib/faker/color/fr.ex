defmodule Faker.Color.Fr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for color data in French
  """

  @doc """
  Returns a random french color name

  ## Examples

      iex> Faker.Color.Fr.name()
      "Rouge"
      iex> Faker.Color.Fr.name()
      "Vert"
      iex> Faker.Color.Fr.name()
      "Marron"
      iex> Faker.Color.Fr.name()
      "Rose"
  """
  @spec name() :: String.t()
  sampler(:name, [
    "Rouge",
    "Vert",
    "Noir",
    "Bleu",
    "Rose",
    "Marron",
    "Orange",
    "Jaune",
    "Violet",
    "Blanc"
  ])
end

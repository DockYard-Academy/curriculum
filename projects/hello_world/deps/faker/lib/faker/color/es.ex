defmodule Faker.Color.Es do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for color data in Spanish
  """

  @doc """
  Returns a random spanish color name

  ## Examples

      iex> Faker.Color.Es.name()
      "Rojo"
      iex> Faker.Color.Es.name()
      "Verde"
      iex> Faker.Color.Es.name()
      "Marrón"
      iex> Faker.Color.Es.name()
      "Rosa"
  """
  @spec name() :: String.t()
  sampler(:name, [
    "Rojo",
    "Verde",
    "Negro",
    "Azul",
    "Rosa",
    "Marrón",
    "Laranja",
    "Amarillo",
    "Morado",
    "Blanco"
  ])
end

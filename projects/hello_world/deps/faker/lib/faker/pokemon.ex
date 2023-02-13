defmodule Faker.Pokemon do
  import Faker, only: [localize: 1]

  @moduledoc """
  Function for generating Pokemon
  """

  @doc """
  Returns a random Pokemon name

  ## Examples

      iex> Faker.Pokemon.name()
      "Fraxure"
      iex> Faker.Pokemon.name()
      "Shellos"
      iex> Faker.Pokemon.name()
      "Ambipom"
      iex> Faker.Pokemon.name()
      "Forretress"
  """
  @spec name() :: String.t()
  localize(:name)

  @doc """
  Returns a random Pokemon location

  ## Examples

      iex> Faker.Pokemon.location()
      "Vaniville Town"
      iex> Faker.Pokemon.location()
      "Slateport City"
      iex> Faker.Pokemon.location()
      "Shalour City"
      iex> Faker.Pokemon.location()
      "Solaceon Town"
  """
  @spec location() :: String.t()
  localize(:location)
end

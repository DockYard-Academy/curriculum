defmodule Faker.Team do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating team related data
  """

  @doc """
  Returns a string of the form [state] [creature]

  ## Examples

      iex> Faker.Team.creature()
      "prophets"
      iex> Faker.Team.creature()
      "cats"
      iex> Faker.Team.creature()
      "enchanters"
      iex> Faker.Team.creature()
      "banshees"
  """
  @spec creature() :: String.t()
  localize(:creature)

  @doc """
  Returns a random creature name

  ## Examples

      iex> Faker.Team.name()
      "Hawaii cats"
      iex> Faker.Team.name()
      "Oklahoma banshees"
      iex> Faker.Team.name()
      "Texas elves"
      iex> Faker.Team.name()
      "Iowa fishes"
  """
  @spec name() :: String.t()
  localize(:name)
end

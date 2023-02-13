defmodule Faker.Industry do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating Industry related data
  Reference https://en.wikipedia.org/wiki/Industry_Classification_Benchmark
  """

  @doc """
  Returns a Industry name string

  ## Examples

      iex> Faker.Industry.industry
      "Oil & Gas"
      iex> Faker.Industry.industry
      "Basic Materials"
      iex> Faker.Industry.industry
      "Consumer Services"
      iex> Faker.Industry.industry
      "Health Care"
  """
  @spec industry() :: String.t()
  localize(:industry)

  @doc """
  Returns a Super Sector name string

  ## Examples

      iex> Faker.Industry.super_sector
      "Automobiles & Parts"
      iex> Faker.Industry.super_sector
      "Banks"
      iex> Faker.Industry.super_sector
      "Automobiles & Parts"
      iex> Faker.Industry.super_sector
      "Health Care"
  """
  @spec super_sector() :: String.t()
  localize(:super_sector)

  @doc """
  Returns a Sector name string

  ## Examples

      iex> Faker.Industry.sector
      "Food & Drug Retailers"
      iex> Faker.Industry.sector
      "Banks"
      iex> Faker.Industry.sector
      "Software & Computer Services"
      iex> Faker.Industry.sector
      "Media"
  """
  @spec sector() :: String.t()
  localize(:sector)

  @doc """
  Returns a Sub Sector name string

  ## Examples

      iex> Faker.Industry.sub_sector()
      "Electrical Components & Equipment"
      iex> Faker.Industry.sub_sector()
      "Publishing"
      iex> Faker.Industry.sub_sector()
      "Alternative Electricity"
      iex> Faker.Industry.sub_sector()
      "Forestry"
  """
  @spec sub_sector() :: String.t()
  localize(:sub_sector)
end

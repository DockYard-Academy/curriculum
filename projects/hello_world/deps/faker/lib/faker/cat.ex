defmodule Faker.Cat do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating Cat names, breeds, and registries
  """

  @doc """
  Return a random Cat name

  ## Examples

      iex> Faker.Cat.name()
      "Daisy"
      iex> Faker.Cat.name()
      "Lily"
      iex> Faker.Cat.name()
      "Felix"
      iex> Faker.Cat.name()
      "Max"
  """
  @spec name() :: String.t()
  localize(:name)

  @doc """
  Return a random Cat breed

  ## Examples

      iex> Faker.Cat.breed()
      "Mekong Bobtail"
      iex> Faker.Cat.breed()
      "Suphalak"
      iex> Faker.Cat.breed()
      "Russian White, Black and Tabby"
      iex> Faker.Cat.breed()
      "Asian Semi-longhair"
  """
  @spec breed() :: String.t()
  localize(:breed)

  @doc """
  Return a random Cat registry

  ## Examples

      iex> Faker.Cat.registry()
      "Cat Aficionado Association"
      iex> Faker.Cat.registry()
      "Fédération Internationale Féline"
      iex> Faker.Cat.registry()
      "Fédération Internationale Féline"
      iex> Faker.Cat.registry()
      "Fédération Internationale Féline"
  """
  @spec registry() :: String.t()
  localize(:registry)
end

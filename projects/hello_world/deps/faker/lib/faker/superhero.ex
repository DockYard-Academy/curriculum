defmodule Faker.Superhero do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating Superhero data
  """

  @doc """
  Returns a random Superhero name

  ## Examples

      iex> Faker.Superhero.name()
      "Red Beyonder the Hunter"
      iex> Faker.Superhero.name()
      "Penance Strike"
      iex> Faker.Superhero.name()
      "Sage"
      iex> Faker.Superhero.name()
      "Giant Aqua I"
  """
  @spec name() :: String.t()
  localize(:name)

  @doc """
  Returns a random Superhero name prefix

  ## Examples

      iex> Faker.Superhero.prefix()
      "The"
      iex> Faker.Superhero.prefix()
      "Red"
      iex> Faker.Superhero.prefix()
      "The"
      iex> Faker.Superhero.prefix()
      "Captain"
  """
  @spec prefix() :: String.t()
  localize(:prefix)

  @doc """
  Returns a random Superhero name suffix

  ## Examples

      iex> Faker.Superhero.suffix()
      "Strange"
      iex> Faker.Superhero.suffix()
      "Claw"
      iex> Faker.Superhero.suffix()
      "the Hunter"
      iex> Faker.Superhero.suffix()
      "the Hunter"
  """
  @spec suffix() :: String.t()
  localize(:suffix)

  @doc """
  Returns a random Superhero descriptor

  ## Examples

      iex> Faker.Superhero.descriptor()
      "Ronin"
      iex> Faker.Superhero.descriptor()
      "Azrael"
      iex> Faker.Superhero.descriptor()
      "Beyonder"
      iex> Faker.Superhero.descriptor()
      "Phantom"
  """
  @spec descriptor() :: String.t()
  localize(:descriptor)

  @doc """
  Returns a random Superhero power

  ## Examples

      iex> Faker.Superhero.power()
      "Death Touch"
      iex> Faker.Superhero.power()
      "Shapeshifting"
      iex> Faker.Superhero.power()
      "Gliding"
      iex> Faker.Superhero.power()
      "Illusions"
  """
  @spec power() :: String.t()
  localize(:power)
end

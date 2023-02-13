defmodule Faker.Person do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating names for a person.
  """

  @doc """
  Returns a random complete name

  ## Examples

      iex> Faker.Person.name()
      "Mrs. Abe Rolfson MD"
      iex> Faker.Person.name()
      "Conor Padberg"
      iex> Faker.Person.name()
      "Mr. Bianka Ryan"
      iex> Faker.Person.name()
      "Ally Rau MD"
  """
  @spec name() :: String.t()
  localize(:name)

  @doc """
  Returns a random first name

  ## Examples

      iex> Faker.Person.first_name()
      "Joany"
      iex> Faker.Person.first_name()
      "Elizabeth"
      iex> Faker.Person.first_name()
      "Abe"
      iex> Faker.Person.first_name()
      "Ozella"
  """
  @spec first_name() :: String.t()
  localize(:first_name)

  @doc """
  Returns a random last name

  ## Examples

      iex> Faker.Person.last_name()
      "Blick"
      iex> Faker.Person.last_name()
      "Hayes"
      iex> Faker.Person.last_name()
      "Schumm"
      iex> Faker.Person.last_name()
      "Rolfson"
  """
  @spec last_name() :: String.t()
  localize(:last_name)

  @doc """
  Returns a random name related title

  ## Examples

      iex> Faker.Person.title()
      "Dynamic Identity Administrator"
      iex> Faker.Person.title()
      "Product Communications Technician"
      iex> Faker.Person.title()
      "Legacy Accountability Architect"
      iex> Faker.Person.title()
      "Customer Data Representative"
  """
  @spec title() :: String.t()
  localize(:title)

  @doc """
  Returns a random name related suffix

  ## Examples

      iex> Faker.Person.suffix()
      "II"
      iex> Faker.Person.suffix()
      "V"
      iex> Faker.Person.suffix()
      "V"
      iex> Faker.Person.suffix()
      "V"
  """
  @spec suffix() :: String.t()
  localize(:suffix)

  @doc """
  Returns a random name related prefix

  ## Examples

      iex> Faker.Person.prefix()
      "Mr."
      iex> Faker.Person.prefix()
      "Mrs."
      iex> Faker.Person.prefix()
      "Mr."
      iex> Faker.Person.prefix()
      "Dr."
  """
  @spec prefix() :: String.t()
  localize(:prefix)
end

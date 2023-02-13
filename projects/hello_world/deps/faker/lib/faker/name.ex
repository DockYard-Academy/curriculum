defmodule Faker.Name do
  alias Faker.Person

  @moduledoc """
  Deprecated. Faker.Name will be removed in 1.0.0. Please use Faker.Person instead.
  """

  @doc """
  Returns a random complete name

  ## Examples

      iex> Faker.Name.name()
      "Mrs. Abe Rolfson MD"
      iex> Faker.Name.name()
      "Conor Padberg"
      iex> Faker.Name.name()
      "Mr. Bianka Ryan"
      iex> Faker.Name.name()
      "Ally Rau MD"
  """
  @deprecated "Use Faker.Person.name/0 instead."
  @spec name() :: String.t()
  def name, do: Person.name()

  @doc """
  Returns a random first name

  ## Examples

      iex> Faker.Name.first_name()
      "Joany"
      iex> Faker.Name.first_name()
      "Elizabeth"
      iex> Faker.Name.first_name()
      "Abe"
      iex> Faker.Name.first_name()
      "Ozella"
  """
  @deprecated "Use Faker.Person.first_name/0 instead."
  @spec first_name() :: String.t()
  def first_name, do: Person.first_name()

  @doc """
  Returns a random last name

  ## Examples

      iex> Faker.Name.last_name()
      "Blick"
      iex> Faker.Name.last_name()
      "Hayes"
      iex> Faker.Name.last_name()
      "Schumm"
      iex> Faker.Name.last_name()
      "Rolfson"
  """
  @deprecated "Use Faker.Person.last_name/0 instead."
  @spec last_name() :: String.t()
  def last_name, do: Person.last_name()

  @doc """
  Returns a random name related title

  ## Examples

      iex> Faker.Name.title()
      "Dynamic Identity Administrator"
      iex> Faker.Name.title()
      "Product Communications Technician"
      iex> Faker.Name.title()
      "Legacy Accountability Architect"
      iex> Faker.Name.title()
      "Customer Data Representative"
  """
  @deprecated "Use Faker.Person.title/0 instead."
  @spec title() :: String.t()
  def title, do: Person.title()

  @doc """
  Returns a random name related suffix

  ## Examples

      iex> Faker.Name.suffix()
      "II"
      iex> Faker.Name.suffix()
      "V"
      iex> Faker.Name.suffix()
      "V"
      iex> Faker.Name.suffix()
      "V"
  """
  @deprecated "Use Faker.Person.suffix/0 instead."
  @spec suffix() :: String.t()
  def suffix, do: Person.suffix()

  @doc """
  Returns a random name related prefix

  ## Examples

      iex> Faker.Name.prefix()
      "Mr."
      iex> Faker.Name.prefix()
      "Mrs."
      iex> Faker.Name.prefix()
      "Mr."
      iex> Faker.Name.prefix()
      "Dr."
  """
  @deprecated "Use Faker.Person.prefix/0 instead."
  @spec prefix() :: String.t()
  def prefix, do: Person.prefix()
end

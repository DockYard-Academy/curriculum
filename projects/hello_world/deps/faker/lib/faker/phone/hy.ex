defmodule Faker.Phone.Hy do
  import Faker, only: [samplerp: 2]

  @moduledoc """
  Functions for generating phone related data in Armenian
  """

  @doc """
  Returns a random phone number.

  ## Examples

      iex> Faker.Phone.Hy.number()
      "10.542646"
      iex> Faker.Phone.Hy.number()
      "83-297052"
      iex> Faker.Phone.Hy.number()
      "(70) 203032"
      iex> Faker.Phone.Hy.number()
      "(733) 76033"
  """
  @spec number() :: String.t()
  def number do
    if Faker.random_between(0, 1) == 0 do
      landline_number()
    else
      cell_number()
    end
  end

  samplerp(:landline_number_format, [
    "###-#####",
    "(###) #####",
    "###.#####",
    "10-######",
    "(10) ######",
    "10.######"
  ])

  @doc """
  Returns a random landline phone number.

  ## Examples

      iex> Faker.Phone.Hy.landline_number()
      "154-26461"
      iex> Faker.Phone.Hy.landline_number()
      "832-97052"
      iex> Faker.Phone.Hy.landline_number()
      "(570) 20303"
      iex> Faker.Phone.Hy.landline_number()
      "097.33760"
  """
  @spec landline_number() :: String.t()
  def landline_number do
    Faker.format(landline_number_format())
  end

  samplerp(:cell_number_format, [
    "##-######",
    "(##) ######",
    "##.######"
  ])

  @doc """
  Returns a random cell phone number.

  ## Examples

      iex> Faker.Phone.Hy.cell_number()
      "15-426461"
      iex> Faker.Phone.Hy.cell_number()
      "83-297052"
      iex> Faker.Phone.Hy.cell_number()
      "(57) 020303"
      iex> Faker.Phone.Hy.cell_number()
      "09.733760"
  """
  @spec cell_number() :: String.t()
  def cell_number do
    Faker.format(cell_number_format())
  end
end

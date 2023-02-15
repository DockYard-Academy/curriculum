defmodule Faker.Phone.PtPt do
  import Faker, only: [samplerp: 2]

  @moduledoc """
  Functions for generating phone related data for portugal location
  """

  @doc """
  Returns a random phone number.

  ## Examples

      iex> Faker.Phone.PtPt.number()
      "929999999"
      iex> Faker.Phone.PtPt.number()
      "919999999"
      iex> Faker.Phone.PtPt.number()
      "234999999"
      iex> Faker.Phone.PtPt.number()
      "939999999"
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
    "2########",
    "3########"
  ])

  @doc """
  Returns a random landline phone number

  ## Examples

      iex> Faker.Phone.PtPt.landline_number()
      "299999999"
      iex> Faker.Phone.PtPt.landline_number()
      "299999998"
      iex> Faker.Phone.PtPt.landline_number()
      "399999999"
      iex> Faker.Phone.PtPt.landline_number()
      "399999998"
  """

  @spec landline_number() :: String.t()
  def landline_number do
    Faker.format(landline_number_format())
  end

  samplerp(:cell_number_format, [
    "91#######",
    "92#######",
    "93#######",
    "96#######"
  ])

  @doc """
  Returns a random cell phone number

  ## Examples

      iex> Faker.Phone.PtPt.cell_number()
      "919999999"
      iex> Faker.Phone.PtPt.cell_number()
      "929999999"
      iex> Faker.Phone.PtPt.cell_number()
      "939999999"
      iex> Faker.Phone.PtPt.cell_number()
      "969999999"
  """

  @spec cell_number() :: String.t()
  def cell_number do
    Faker.format(cell_number_format())
  end
end

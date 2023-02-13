defmodule Faker.Gov.Us do
  @moduledoc """
  Generating US Taxpayer Identification numbers
  """

  @doc """
  Returns a random US Social Security number

  ## Examples

      iex> Faker.Gov.Us.ssn
      "838-84-5749"
      iex> Faker.Gov.Us.ssn
      "719-41-8674"
      iex> Faker.Gov.Us.ssn
      "213-54-3766"
      iex> Faker.Gov.Us.ssn
      "379-09-6851"
  """
  @spec ssn() :: String.t()
  def ssn do
    "#{ssn_area()}-#{ssn_group()}-#{ssn_serial()}"
  end

  defp ssn_area do
    case "#{Faker.random_between(1, 899)}" do
      "666" -> "667"
      n -> n |> String.pad_leading(3, "0")
    end
  end

  defp ssn_group, do: "#{Faker.random_between(1, 99)}" |> String.pad_leading(2, "0")
  defp ssn_serial, do: "#{Faker.random_between(1, 9999)}" |> String.pad_leading(4, "0")

  @doc """
  Returns a random Employer Identification Number

  ## Examples

      iex> Faker.Gov.Us.ein
      "04-0389586"
      iex> Faker.Gov.Us.ein
      "07-8027034"
      iex> Faker.Gov.Us.ein
      "41-6859447"
      iex> Faker.Gov.Us.ein
      "83-6106581"
  """
  @spec ein() :: String.t()
  def ein do
    "#{ein_campus()}-#{ein_serial()}"
  end

  defp ein_campus, do: "#{Faker.random_between(1, 99)}" |> String.pad_leading(2, "0")
  defp ein_serial, do: "#{Faker.random_between(1, 9_999_999)}" |> String.pad_leading(7, "0")
end

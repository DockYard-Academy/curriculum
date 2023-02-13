defmodule Faker.Beer do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating Beer related data
  """

  @doc """
  Returns a Beer brand string

  ## Examples

      iex> Faker.Beer.brand()
      "Paulaner"
      iex> Faker.Beer.brand()
      "Pabst Blue Ribbon"
      iex> Faker.Beer.brand()
      "Kirin Inchiban"
      iex> Faker.Beer.brand()
      "Birra Moretti"
  """
  @spec brand() :: String.t()
  localize(:brand)

  @doc """
  Returns a Beer name string

  ## Examples

      iex> Faker.Beer.name()
      "Duvel"
      iex> Faker.Beer.name()
      "Founders Kentucky Breakfast"
      iex> Faker.Beer.name()
      "Yeti Imperial Stout"
      iex> Faker.Beer.name()
      "Stone Imperial Russian Stout"
  """
  @spec name() :: String.t()
  localize(:name)

  @doc """
  Returns a Hop name string

  ## Examples

      iex> Faker.Beer.hop()
      "Eroica"
      iex> Faker.Beer.hop()
      "Bullion"
      iex> Faker.Beer.hop()
      "Mt. Rainier"
      iex> Faker.Beer.hop()
      "Citra"
  """
  @spec hop() :: String.t()
  localize(:hop)

  @doc """
  Returns a Yeast name string

  ## Examples

      iex> Faker.Beer.yeast()
      "2206 - Bavarian Lager"
      iex> Faker.Beer.yeast()
      "3763 - Roeselare Ale Blend"
      iex> Faker.Beer.yeast()
      "3711 - French Saison"
      iex> Faker.Beer.yeast()
      "3944 - Belgian Witbier"
  """
  @spec yeast() :: String.t()
  localize(:yeast)

  @doc """
  Returns a Malt name string

  ## Examples

      iex> Faker.Beer.malt()
      "Carapils"
      iex> Faker.Beer.malt()
      "Pale"
      iex> Faker.Beer.malt()
      "Rye malt"
      iex> Faker.Beer.malt()
      "Munich"
  """
  @spec malt() :: String.t()
  localize(:malt)

  @doc """
  Returns a Style name string

  ## Examples

      iex> Faker.Beer.style()
      "Stout"
      iex> Faker.Beer.style()
      "European Amber Lager"
      iex> Faker.Beer.style()
      "Strong Ale"
      iex> Faker.Beer.style()
      "German Wheat And Rye Beer"
  """
  @spec style() :: String.t()
  localize(:style)

  @doc """
  Returns an IBU(International Bitterness Unit) for a beer

  ## Examples

      iex> Faker.Beer.ibu()
      "59 IBU"
      iex> Faker.Beer.ibu()
      "10 IBU"
      iex> Faker.Beer.ibu()
      "56 IBU"
      iex> Faker.Beer.ibu()
      "85 IBU"
  """
  @spec ibu :: String.t()
  def ibu do
    "#{Faker.random_between(5, 120)} IBU"
  end

  @doc """
  Returns an alcohol percentage for a beer

  ## Examples

      iex> Faker.Beer.alcohol()
      "10.1%"
      iex> Faker.Beer.alcohol()
      "35.4%"
      iex> Faker.Beer.alcohol()
      "92.6%"
      iex> Faker.Beer.alcohol()
      "64.6%"
  """
  @spec alcohol :: String.t()
  def alcohol do
    random_float() <> "%"
  end

  @doc """
  Returns a blg for a beer

  ## Examples

      iex> Faker.Beer.blg()
      "10.1°Blg"
      iex> Faker.Beer.blg()
      "35.4°Blg"
      iex> Faker.Beer.blg()
      "92.6°Blg"
      iex> Faker.Beer.blg()
      "64.6°Blg"
  """
  @spec blg :: String.t()
  def blg do
    random_float() <> "°Blg"
  end

  defp random_float do
    "#{Faker.random_between(0, 99)}.#{Faker.random_between(0, 9)}"
  end
end

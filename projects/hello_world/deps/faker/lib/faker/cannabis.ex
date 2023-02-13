defmodule Faker.Cannabis do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating Cannabis related data
  """

  @doc """
  Returns a Cannabis strain string

  ## Examples

      iex> Faker.Cannabis.strain()
      "Critical Kush"
      iex> Faker.Cannabis.strain()
      "Blue Dream"
      iex> Faker.Cannabis.strain()
      "Mr. Nice Guy"
      iex> Faker.Cannabis.strain()
      "Gorilla Glue"
  """
  @spec strain() :: String.t()
  localize(:strain)

  @doc """
  Returns a Cannabis cannabinoid string

  ## Examples

      iex> Faker.Cannabis.cannabinoid()
      "Cannabinol"
      iex> Faker.Cannabis.cannabinoid()
      "Cannabigerolic Acid"
      iex> Faker.Cannabis.cannabinoid()
      "Cannabinolic Acid"
      iex> Faker.Cannabis.cannabinoid()
      "Cannabicyclol"
  """
  @spec cannabinoid() :: String.t()
  localize(:cannabinoid)

  @doc """
  Returns a Cannabis cannabinoid abbreviation string

  ## Examples

      iex> Faker.Cannabis.cannabinoid_abbreviation()
      "THCa"
      iex> Faker.Cannabis.cannabinoid_abbreviation()
      "THCv"
      iex> Faker.Cannabis.cannabinoid_abbreviation()
      "CBC"
      iex> Faker.Cannabis.cannabinoid_abbreviation()
      "CBG"
  """
  @spec cannabinoid_abbreviation() :: String.t()
  localize(:cannabinoid_abbreviation)

  @doc """
  Returns a Cannabis terpene string

  ## Examples

      iex> Faker.Cannabis.terpene()
      "Camphor"
      iex> Faker.Cannabis.terpene()
      "Camphene"
      iex> Faker.Cannabis.terpene()
      "α Pinene"
      iex> Faker.Cannabis.terpene()
      "Sabinene"
  """
  @spec terpene() :: String.t()
  localize(:terpene)

  @doc """
  Returns a Cannabis medical use string

  ## Examples

      iex> Faker.Cannabis.medical_use()
      "analgesic"
      iex> Faker.Cannabis.medical_use()
      "anti-cancer"
      iex> Faker.Cannabis.medical_use()
      "anti-cancer"
      iex> Faker.Cannabis.medical_use()
      "anti-fungal"
  """
  @spec medical_use() :: String.t()
  localize(:medical_use)

  @doc """
  Returns a Cannabis health benefit string

  ## Examples

      iex> Faker.Cannabis.health_benefit()
      "relieves pain"
      iex> Faker.Cannabis.health_benefit()
      "inhibits cell growth in tumors/cancer cells"
      iex> Faker.Cannabis.health_benefit()
      "inhibits cell growth in tumors/cancer cells"
      iex> Faker.Cannabis.health_benefit()
      "treats fungal infection"
  """
  @spec health_benefit() :: String.t()
  localize(:health_benefit)

  @doc """
  Returns a Cannabis category string

  ## Examples

      iex> Faker.Cannabis.category()
      "flower"
      iex> Faker.Cannabis.category()
      "medical"
      iex> Faker.Cannabis.category()
      "seeds & clones"
      iex> Faker.Cannabis.category()
      "live resin"
  """
  @spec category() :: String.t()
  localize(:category)

  @doc """
  Returns a Cannabis type string

  ## Examples

      iex> Faker.Cannabis.type()
      "hybrid"
      iex> Faker.Cannabis.type()
      "sativa"
      iex> Faker.Cannabis.type()
      "hybrid"
      iex> Faker.Cannabis.type()
      "sativa"
  """
  @spec type() :: String.t()
  localize(:type)

  @doc """
  Returns a Cannabis buzzword string

  ## Examples

      iex> Faker.Cannabis.buzzword()
      "toke"
      iex> Faker.Cannabis.buzzword()
      "cbd"
      iex> Faker.Cannabis.buzzword()
      "stoned"
      iex> Faker.Cannabis.buzzword()
      "stoned"
  """
  @spec buzzword() :: String.t()
  localize(:buzzword)

  @doc """
  Returns a Cannabis brand string

  ## Examples

      iex> Faker.Cannabis.En.brand()
      "Evolab"
      iex> Faker.Cannabis.En.brand()
      "CI Wholesale"
      iex> Faker.Cannabis.En.brand()
      "Muy"
      iex> Faker.Cannabis.En.brand()
      "Chong's Choice"
  """
  @spec brand() :: String.t()
  localize(:brand)

  @doc """
  Returns a thc percentage for a cannabis thc

  ## Examples

      iex> Faker.Cannabis.thc()
      "18.1%"
      iex> Faker.Cannabis.thc()
      "30.4%"
      iex> Faker.Cannabis.thc()
      "28.6%"
      iex> Faker.Cannabis.thc()
      "40.6%"
  """
  @spec thc :: String.t()
  def thc do
    random_float() <> "%"
  end

  defp random_float do
    "#{Faker.random_between(0, 50)}.#{Faker.random_between(0, 9)}"
  end
end

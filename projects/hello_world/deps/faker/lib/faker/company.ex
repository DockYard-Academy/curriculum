defmodule Faker.Company do
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating company names and related stuff
  """

  @doc """
  Returns a random complete business related bullshit

  ## Examples

      iex> Faker.Company.bs()
      "syndicate e-business e-business"
      iex> Faker.Company.bs()
      "scale global metrics"
      iex> Faker.Company.bs()
      "optimize scalable markets"
      iex> Faker.Company.bs()
      "implement out-of-the-box content"
  """
  @spec bs() :: String.t()
  localize(:bs)

  @doc """
  Returns a random business related bullshit

  ## Examples

      iex> Faker.Company.bullshit()
      "web-enabled"
      iex> Faker.Company.bullshit()
      "e-business"
      iex> Faker.Company.bullshit()
      "web-enabled"
      iex> Faker.Company.bullshit()
      "next-generation"
  """
  @spec bullshit() :: String.t()
  localize(:bullshit)

  @doc """
  Returns a random business related bullshit prefix

  ## Examples

      iex> Faker.Company.bullshit_prefix()
      "syndicate"
      iex> Faker.Company.bullshit_prefix()
      "visualize"
      iex> Faker.Company.bullshit_prefix()
      "incentivize"
      iex> Faker.Company.bullshit_prefix()
      "scale"
  """
  @spec bullshit_prefix() :: String.t()
  localize(:bullshit_prefix)

  @doc """
  Returns a random business related bullshit suffix

  ## Examples

      iex> Faker.Company.bullshit_suffix()
      "e-services"
      iex> Faker.Company.bullshit_suffix()
      "niches"
      iex> Faker.Company.bullshit_suffix()
      "e-business"
      iex> Faker.Company.bullshit_suffix()
      "systems"
  """
  @spec bullshit_suffix() :: String.t()
  localize(:bullshit_suffix)

  @doc """
  Returns a random business related buzzword

  ## Examples

      iex> Faker.Company.buzzword()
      "upward-trending"
      iex> Faker.Company.buzzword()
      "full-range"
      iex> Faker.Company.buzzword()
      "uniform"
      iex> Faker.Company.buzzword()
      "tertiary"
  """
  @spec buzzword() :: String.t()
  localize(:buzzword)

  @doc """
  Returns a random business related buzzword prefix

  ## Examples

      iex> Faker.Company.buzzword_prefix()
      "Configurable"
      iex> Faker.Company.buzzword_prefix()
      "Advanced"
      iex> Faker.Company.buzzword_prefix()
      "Grass-roots"
      iex> Faker.Company.buzzword_prefix()
      "Automated"
  """
  @spec buzzword_prefix() :: String.t()
  localize(:buzzword_prefix)

  @doc """
  Returns a random business related buzzword suffix

  ## Examples

      iex> Faker.Company.buzzword_suffix()
      "encoding"
      iex> Faker.Company.buzzword_suffix()
      "standardization"
      iex> Faker.Company.buzzword_suffix()
      "Graphical User Interface"
      iex> Faker.Company.buzzword_suffix()
      "product"
  """
  @spec buzzword_suffix() :: String.t()
  localize(:buzzword_suffix)

  @doc """
  Returns a random complete catch phrase

  ## Examples

      iex> Faker.Company.catch_phrase()
      "Configurable full-range Graphical User Interface"
      iex> Faker.Company.buzzword_suffix()
      "product"
      iex> Faker.Company.buzzword_suffix()
      "intranet"
      iex> Faker.Company.buzzword_suffix()
      "pricing structure"
  """
  @spec catch_phrase() :: String.t()
  localize(:catch_phrase)

  @doc """
  Returns complete company name

  ## Examples

      iex> Faker.Company.name()
      "Hayes Inc"
      iex> Faker.Company.name()
      "Sipes, Wehner and Hane"
      iex> Faker.Company.name()
      "Schiller, Rogahn and Hartmann"
      iex> Faker.Company.name()
      "Murphy-Metz"
  """
  @spec name() :: String.t()
  localize(:name)

  @doc """
  Returns a random type of business entity

  ## Examples

      iex> Faker.Company.suffix()
      "Inc"
      iex> Faker.Company.suffix()
      "and Sons"
      iex> Faker.Company.suffix()
      "Inc"
      iex> Faker.Company.suffix()
      "Ltd"
  """
  @spec suffix() :: String.t()
  localize(:suffix)
end

defmodule Faker.Internet.Es do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Generating internet related data in Spanish
  """

  @doc """
  Returns a random free email service name

  ## Examples

      iex> Faker.Internet.Es.free_email_service()
      "gmail.com"
      iex> Faker.Internet.Es.free_email_service()
      "hotmail.com"
      iex> Faker.Internet.Es.free_email_service()
      "gmail.com"
      iex> Faker.Internet.Es.free_email_service()
      "hotmail.com"
  """
  @spec free_email_service() :: String
  sampler(:free_email_service, ["gmail.com", "yahoo.com", "hotmail.com"])

  @doc """
  Returns a random domain suffix

  ## Examples

      iex> Faker.Internet.Es.domain_suffix()
      "com"
      iex> Faker.Internet.Es.domain_suffix()
      "es"
      iex> Faker.Internet.Es.domain_suffix()
      "com"
      iex> Faker.Internet.Es.domain_suffix()
      "org"
  """
  @spec domain_suffix() :: String.t()
  sampler(:domain_suffix, ["com", "es", "info", "com.es", "org"])
end

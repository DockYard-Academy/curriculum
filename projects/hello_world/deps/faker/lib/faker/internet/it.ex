defmodule Faker.Internet.It do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Generating internet related data in Italian
  """

  @doc """
  Returns a random free email service name

  ## Examples

      iex> Faker.Internet.It.free_email_service()
      "virgilio.it"
      iex> Faker.Internet.It.free_email_service()
      "yahoo.it"
      iex> Faker.Internet.It.free_email_service()
      "aruba.it"
      iex> Faker.Internet.It.free_email_service()
      "gmail.com"
  """
  @spec free_email_service() :: String.t()
  sampler(:free_email_service, [
    "gmail.com",
    "yahoo.it",
    "hotmail.it",
    "aruba.it",
    "libero.it",
    "alice.it",
    "virgilio.it",
    "tin.it"
  ])

  @doc """
  Returns a random domain suffix

  ## Examples

      iex> Faker.Internet.It.domain_suffix()
      "com"
      iex> Faker.Internet.It.domain_suffix()
      "it"
      iex> Faker.Internet.It.domain_suffix()
      "com"
      iex> Faker.Internet.It.domain_suffix()
      "biz"
  """
  @spec domain_suffix() :: String.t()
  sampler(:domain_suffix, ["com", "it", "info", "org", "biz"])
end

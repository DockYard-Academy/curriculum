defmodule Faker.Internet.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Generating internet related data in Brazilian Portuguese
  """

  @doc """
  Returns a random free email service name

  ## Examples

      iex> Faker.Internet.PtBr.free_email_service()
      "gmail.com"
      iex> Faker.Internet.PtBr.free_email_service()
      "yahoo.com"
      iex> Faker.Internet.PtBr.free_email_service()
      "gmail.com"
      iex> Faker.Internet.PtBr.free_email_service()
      "bol.com.br"
  """
  @spec free_email_service() :: String
  sampler(:free_email_service, ["gmail.com", "yahoo.com", "hotmail.com", "live.com", "bol.com.br"])

  @doc """
  Returns a random domain suffix

  ## Examples

      iex> Faker.Internet.PtBr.domain_suffix()
      "br"
      iex> Faker.Internet.PtBr.domain_suffix()
      "org"
      iex> Faker.Internet.PtBr.domain_suffix()
      "name"
      iex> Faker.Internet.PtBr.domain_suffix()
      "info"
  """
  @spec domain_suffix() :: String.t()
  sampler(:domain_suffix, ["br", "biz", "info", "name", "net", "org"])
end

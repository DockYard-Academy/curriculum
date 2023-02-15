defmodule Faker.Internet do
  alias Faker.Lorem
  alias Faker.Person.En, as: Person
  alias Faker.Util

  import Faker.Util, only: [pick: 1]
  import Faker, only: [localize: 1]

  @moduledoc """
  Functions for generating internet related data
  """

  @doc """
  Returns a complete random domain name

  ## Examples

      iex> Faker.Internet.domain_name()
      "blick.org"
      iex> Faker.Internet.domain_name()
      "schumm.info"
      iex> Faker.Internet.domain_name()
      "sipes.com"
      iex> Faker.Internet.domain_name()
      "hane.info"
  """
  @spec domain_name() :: String.t()
  def domain_name do
    "#{domain_word()}.#{domain_suffix()}"
  end

  @doc """
  Returns a random domain suffix

  ## Examples

      iex> Faker.Internet.domain_suffix()
      "com"
      iex> Faker.Internet.domain_suffix()
      "org"
      iex> Faker.Internet.domain_suffix()
      "name"
      iex> Faker.Internet.domain_suffix()
      "info"
  """
  @spec domain_suffix() :: String.t()
  localize(:domain_suffix)

  @doc """
  Returns a random username

  ## Examples

      iex> Faker.Internet.user_name()
      "elizabeth2056"
      iex> Faker.Internet.user_name()
      "reese1921"
      iex> Faker.Internet.user_name()
      "aniya1972"
      iex> Faker.Internet.user_name()
      "bianka2054"
  """
  @spec user_name() :: String.t()
  def user_name, do: user_name(Faker.random_between(0, 1))

  defp user_name(0) do
    "#{remove_special_characters(Person.first_name()) |> String.replace(~s(  ), ~s()) |> String.downcase()}#{Faker.random_between(1900, 2100)}"
  end

  defp user_name(1) do
    [Person.first_name(), Person.last_name()]
    |> Stream.map(&remove_special_characters/1)
    |> Enum.map_join(Util.pick(~w(. _)), &String.replace(&1, ~s(  ), ~s()))
    |> String.downcase()
  end

  @doc """
  Returns a random domain word

  ## Examples

      iex> Faker.Internet.domain_word()
      "blick"
      iex> Faker.Internet.domain_word()
      "hayes"
      iex> Faker.Internet.domain_word()
      "schumm"
      iex> Faker.Internet.domain_word()
      "rolfson"
  """
  @spec domain_word() :: String.t()
  def domain_word do
    "#{remove_special_characters(Person.last_name()) |> String.split(["'"]) |> Enum.join() |> String.downcase()}"
  end

  @doc """
  Returns a complete email based on a domain name

  ## Examples

      iex> Faker.Internet.email()
      "elizabeth2056@rolfson.net"
      iex> Faker.Internet.email()
      "conor2058@schiller.com"
      iex> Faker.Internet.email()
      "frederique2063@metz.name"
      iex> Faker.Internet.email()
      "jana2042@price.biz"
  """
  @spec email() :: String.t()
  def email do
    "#{remove_special_characters(user_name())}@#{domain_name()}"
  end

  @doc """
  Returns a complete free email based on a free email service [gmail, yahoo, hotmail]

  ## Examples

      iex> Faker.Internet.free_email()
      "elizabeth2056@hotmail.com"
      iex> Faker.Internet.free_email()
      "trycia1982@hotmail.com"
      iex> Faker.Internet.free_email()
      "delphine_hartmann@yahoo.com"
      iex> Faker.Internet.free_email()
      "mitchel_rutherford@yahoo.com"
  """
  @spec free_email() :: String.t()
  def free_email do
    "#{remove_special_characters(user_name())}@#{free_email_service()}"
  end

  @doc """
  Returns a safe email

  ## Examples

      iex> Faker.Internet.safe_email()
      "elizabeth2056@example.net"
      iex> Faker.Internet.safe_email()
      "trycia1982@example.net"
      iex> Faker.Internet.safe_email()
      "delphine_hartmann@example.com"
      iex> Faker.Internet.safe_email()
      "mitchel_rutherford@example.com"
  """
  @spec safe_email() :: String.t()
  def safe_email do
    "#{remove_special_characters(user_name())}@example.#{Util.pick(~w(org com net))}"
  end

  @doc """
  Returns a free email service

  ## Examples

      iex> Faker.Internet.free_email_service()
      "gmail.com"
      iex> Faker.Internet.free_email_service()
      "hotmail.com"
      iex> Faker.Internet.free_email_service()
      "gmail.com"
      iex> Faker.Internet.free_email_service()
      "hotmail.com"
  """
  @spec free_email_service() :: String.t()
  localize(:free_email_service)

  @doc """
  Returns a random url

  ## Examples

      iex> Faker.Internet.url()
      "http://hayes.name"
      iex> Faker.Internet.url()
      "http://sipes.com"
      iex> Faker.Internet.url()
      "http://padberg.name"
      iex> Faker.Internet.url()
      "http://hartmann.biz"
  """
  @spec url() :: String.t()
  def url, do: url(Faker.random_between(0, 1))

  defp url(0), do: "http://#{domain_name()}"
  defp url(1), do: "https://#{domain_name()}"

  @doc """
  Returns a random image url from placekitten.com | placehold.it | dummyimage.com

  ## Examples

      iex> Faker.Internet.image_url()
      "https://placekitten.com/131/131"
      iex> Faker.Internet.image_url()
      "https://placekitten.com/554/554"
      iex> Faker.Internet.image_url()
      "https://placehold.it/936x936"
      iex> Faker.Internet.image_url()
      "https://placehold.it/541x541"
  """
  @spec image_url() :: String.t()
  def image_url, do: image_url(Faker.random_between(0, 2))

  defp image_url(0) do
    size = Faker.random_between(10, 1024)
    "https://placekitten.com/#{size}/#{size}"
  end

  defp image_url(1) do
    size = Faker.random_between(10, 1024)
    "https://placehold.it/#{size}x#{size}"
  end

  defp image_url(2) do
    size = Faker.random_between(10, 1024)
    "https://dummyimage.com/#{size}x#{size}"
  end

  @doc """
  Generates an ipv4 address

  ## Examples

      iex> Faker.Internet.ip_v4_address()
      "214.217.139.136"
      iex> Faker.Internet.ip_v4_address()
      "200.102.244.150"
      iex> Faker.Internet.ip_v4_address()
      "219.212.222.123"
      iex> Faker.Internet.ip_v4_address()
      "164.141.15.82"
  """
  @spec ip_v4_address() :: String.t()
  def ip_v4_address do
    Enum.map_join(1..4, ".", fn _part ->
      Faker.random_between(0, 255)
    end)
  end

  @doc """
  Generates an ipv6 address

  ## Examples

      iex> Faker.Internet.ip_v6_address()
      "A2D6:F5D9:BD8B:C588:0DC8:9566:43F4:B196"
      iex> Faker.Internet.ip_v6_address()
      "05DB:FAD4:88DE:397B:75A4:A98D:DF0F:1F52"
      iex> Faker.Internet.ip_v6_address()
      "6229:4EFA:2F7B:FEF9:EB07:0128:85B2:DC72"
      iex> Faker.Internet.ip_v6_address()
      "E867:34BC:715B:FB7C:7E96:AF4F:C733:A82D"
  """
  @spec ip_v6_address() :: String.t()
  def ip_v6_address do
    Enum.map_join(1..8, ":", fn _part ->
      Faker.random_between(0, 65535)
      |> Integer.to_string(16)
      |> String.pad_leading(4, ["0"])
    end)
  end

  @doc """
  Generates a mac address

  ## Examples

      iex> Faker.Internet.mac_address()
      "d6:d9:8b:88:c8:66"
      iex> Faker.Internet.mac_address()
      "f4:96:db:d4:de:7b"
      iex> Faker.Internet.mac_address()
      "a4:8d:0f:52:29:fa"
      iex> Faker.Internet.mac_address()
      "7b:f9:07:28:b2:72"
  """
  @spec mac_address() :: String.t()
  def mac_address do
    1..6
    |> Enum.map_join(":", &format_mac_address/1)
    |> String.downcase()
  end

  @doc """
  Generates a slug
  If no words are provided it will generate 2 to 5 random words
  If no glue is provided it will use one of -, _ or .

  ## Examples

      iex> Faker.Internet.slug()
      "sint-deleniti-consequatur-ut"
      iex> Faker.Internet.slug()
      "sit_et"
      iex> Faker.Internet.slug(["foo", "bar"])
      "foo-bar"
      iex> Faker.Internet.slug(["foo", "bar"], ["."])
      "foo.bar"
  """
  @spec slug() :: String.t()
  def slug do
    slug(Lorem.words(2..5))
  end

  @spec slug([String.t()]) :: String.t()
  def slug(words) do
    slug(words, ["-", "_", "."])
  end

  @spec slug([String.t()], [String.t()]) :: String.t()
  def slug(words, glue) do
    words
    |> Enum.take_random(length(words))
    |> Enum.join(pick(glue))
    |> String.downcase()
  end

  defp format_mac_address(_part) do
    Faker.random_between(0, 255)
    |> Integer.to_string(16)
    |> String.pad_leading(2, ["0"])
  end

  defp remove_special_characters(string) do
    special_characters_pattern = :binary.compile_pattern(["'", "\""])
    String.replace(string, special_characters_pattern, "")
  end
end

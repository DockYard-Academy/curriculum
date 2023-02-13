defmodule Faker.Address do
  import Faker, only: [localize: 1]

  alias Faker.Person

  @geobase32 '0123456789bcdefghjkmnpqrstuvwxyz'

  @moduledoc """
  Functions for generating addresses.
  """

  @doc """
  Return random building number.

  ## Examples

      iex> Faker.Address.building_number()
      "15426"
      iex> Faker.Address.building_number()
      "6"
      iex> Faker.Address.building_number()
      "0832"
      iex> Faker.Address.building_number()
      "7"
  """
  @spec building_number() :: String.t()
  localize(:building_number)

  @doc """
  Return city name.

  ## Examples

      iex> Faker.Address.city()
      "Elizabeth"
      iex> Faker.Address.city()
      "Rolfson"
      iex> Faker.Address.city()
      "West Conor"
      iex> Faker.Address.city()
      "Hardy"
  """
  @spec city() :: String.t()
  localize(:city)

  @doc """
  Return city prefix.

  ## Examples

      iex> Faker.Address.city_prefix()
      "Port"
      iex> Faker.Address.city_prefix()
      "West"
      iex> Faker.Address.city_prefix()
      "North"
      iex> Faker.Address.city_prefix()
      "Lake"
  """
  @spec city_prefix() :: String.t()
  localize(:city_prefix)

  @doc """
  Return city suffix.

  ## Examples

      iex> Faker.Address.city_suffix()
      "burgh"
      iex> Faker.Address.city_suffix()
      "mouth"
      iex> Faker.Address.city_suffix()
      "burgh"
      iex> Faker.Address.city_suffix()
      "view"
  """
  @spec city_suffix() :: String.t()
  localize(:city_suffix)

  @doc """
  Return country.

  ## Examples

      iex> Faker.Address.En.country()
      "Guinea-Bissau"
      iex> Faker.Address.En.country()
      "Tuvalu"
      iex> Faker.Address.En.country()
      "Portugal"
      iex> Faker.Address.En.country()
      "United Arab Emirates"
  """
  @spec country() :: String.t()
  localize(:country)

  @doc """
  Return country code.

  ## Examples

      iex> Faker.Address.country_code()
      "IT"
      iex> Faker.Address.country_code()
      "MR"
      iex> Faker.Address.country_code()
      "GM"
      iex> Faker.Address.country_code()
      "CX"
  """
  @spec country_code() :: String.t()
  localize(:country_code)

  @doc """
  Returns a geohash.

  ## Examples

      iex> Faker.Address.geohash()
      "1kgw0"
      iex> Faker.Address.geohash()
      "575152tr612btt"
      iex> Faker.Address.geohash()
      "20kxxzd9k22m6jedp"
      iex> Faker.Address.geohash()
      "06kjmd2wtwjp2px"
  """
  @spec geohash() :: binary
  def geohash do
    bits = encode_to_bits(latitude(), longitude(), Faker.random_between(5, 25) * 5)

    to_geobase32(bits)
  end

  defp encode_to_bits(lat, lon, bits_length) do
    starting_position = bits_length - 1
    # odd bits
    lat_bits = lat_to_bits(lat, starting_position - 1)
    # even bits
    lon_bits = lon_to_bits(lon, starting_position)
    geo_bits = lat_bits + lon_bits
    <<geo_bits::size(bits_length)>>
  end

  defp to_geobase32(bits) do
    chars = for <<c::5 <- bits>>, do: Enum.fetch!(@geobase32, c)
    chars |> to_string
  end

  defp lon_to_bits(lon, position) do
    geo_to_bits(lon, position, {-180.0, 180.0})
  end

  defp lat_to_bits(lat, position) do
    geo_to_bits(lat, position, {-90.0, 90.0})
  end

  defp geo_to_bits(_, position, _) when position < 0 do
    0
  end

  defp geo_to_bits(n, position, {gmin, gmax}) do
    mid = (gmin + gmax) / 2

    if n >= mid do
      round(:math.pow(2, position)) + geo_to_bits(n, position - 2, {mid, gmax})
    else
      geo_to_bits(n, position - 2, {gmin, mid})
    end
  end

  @doc """
  Return random latitude.

  ## Examples

      iex> Faker.Address.latitude()
      -62.20459142744528
      iex> Faker.Address.latitude()
      -59.39243543011051
      iex> Faker.Address.latitude()
      15.346881460762518
      iex> Faker.Address.latitude()
      -72.94522080668256
  """
  @spec latitude() :: float
  def latitude do
    Faker.random_uniform() * 180 - 90
  end

  @doc """
  Return random longitude.

  ## Examples

      iex> Faker.Address.longitude()
      -124.40918285489056
      iex> Faker.Address.longitude()
      -118.78487086022102
      iex> Faker.Address.longitude()
      30.693762921525035
      iex> Faker.Address.longitude()
      -145.8904416133651
  """
  @spec longitude() :: float
  def longitude do
    Faker.random_uniform() * 360 - 180
  end

  @doc """
  Return random postcode.

  ## Examples

      iex> Faker.Address.postcode()
      "01542"
      iex> Faker.Address.postcode()
      "64610"
      iex> Faker.Address.postcode()
      "83297"
      iex> Faker.Address.postcode()
      "05235"
  """
  @spec postcode() :: String.t()
  defdelegate postcode, to: __MODULE__, as: :zip_code

  @doc """
  Return random secondary address.

  ## Examples

      iex> Faker.Address.secondary_address()
      "Apt. 154"
      iex> Faker.Address.secondary_address()
      "Apt. 646"
      iex> Faker.Address.secondary_address()
      "Suite 083"
      iex> Faker.Address.secondary_address()
      "Apt. 970"
  """
  @spec secondary_address() :: String.t()
  localize(:secondary_address)

  @doc """
  Return state.

  ## Examples

      iex> Faker.Address.state()
      "Hawaii"
      iex> Faker.Address.state()
      "Alaska"
      iex> Faker.Address.state()
      "Oklahoma"
      iex> Faker.Address.state()
      "California"
  """
  @spec state() :: String.t()
  localize(:state)

  @doc """
  Return state abbr.

  ## Examples

      iex> Faker.Address.state_abbr()
      "HI"
      iex> Faker.Address.state_abbr()
      "AK"
      iex> Faker.Address.state_abbr()
      "OK"
      iex> Faker.Address.state_abbr()
      "CA"
  """
  @spec state_abbr() :: String.t()
  localize(:state_abbr)

  @doc """
  Return street address.

  ## Examples

      iex> Faker.Address.street_address()
      "15426 Aniya Mews"
      iex> Faker.Address.street_address()
      "83297 Jana Spring"
      iex> Faker.Address.street_address()
      "57 Helene Mission"
      iex> Faker.Address.street_address()
      "03 Izaiah Land"
  """
  @spec street_address() :: String.t()
  def street_address do
    "#{building_number()} #{street_name()}"
  end

  @doc """
  Return `street_address/0` or if argument is `true` adds `secondary_address/0`.

  ## Examples

      iex> Faker.Address.street_address(true)
      "15426 Aniya Mews Apt. 832"
      iex> Faker.Address.street_address(true)
      "7 Jana Spring Suite 570"
      iex> Faker.Address.street_address(true)
      "030 Kozey Knoll Suite 733"
      iex> Faker.Address.street_address(true)
      "603 Homenick Shore Suite 981"
  """
  @spec street_address(true | any) :: String.t()
  def street_address(true), do: street_address() <> " " <> secondary_address()
  def street_address(_), do: street_address()

  @doc """
  Return street name.

  ## Examples

      iex> Faker.Address.street_name()
      "Elizabeth Freeway"
      iex> Faker.Address.street_name()
      "Reese Plaza"
      iex> Faker.Address.street_name()
      "Aniya Mews"
      iex> Faker.Address.street_name()
      "Bianka Heights"
  """
  @spec street_name() :: String.t()
  def street_name do
    street_name(Faker.random_between(0, 1))
  end

  defp street_name(0), do: "#{Person.first_name()} #{street_suffix()}"
  defp street_name(1), do: "#{Person.last_name()} #{street_suffix()}"

  @doc """
  Return street suffix.

  ## Examples

      iex> Faker.Address.street_suffix()
      "View"
      iex> Faker.Address.street_suffix()
      "Locks"
      iex> Faker.Address.street_suffix()
      "Freeway"
      iex> Faker.Address.street_suffix()
      "Lodge"
  """
  @spec street_suffix() :: String.t()
  localize(:street_suffix)

  @doc """
  Return time zone.

  ## Examples

      iex> Faker.Address.time_zone()
      "Europe/Istanbul"
      iex> Faker.Address.time_zone()
      "Europe/Copenhagen"
      iex> Faker.Address.time_zone()
      "America/Indiana/Indianapolis"
      iex> Faker.Address.time_zone()
      "America/Guyana"
  """
  @spec time_zone() :: String.t()
  localize(:time_zone)

  @doc """
  Return random postcode.

  ## Examples

      iex> Faker.Address.zip()
      "01542"
      iex> Faker.Address.zip()
      "64610"
      iex> Faker.Address.zip()
      "83297"
      iex> Faker.Address.zip()
      "05235"
  """
  @spec zip() :: String.t()
  defdelegate zip, to: __MODULE__, as: :zip_code

  @doc """
  Return random postcode.

  ## Examples

      iex> Faker.Address.zip_code()
      "01542"
      iex> Faker.Address.zip_code()
      "64610"
      iex> Faker.Address.zip_code()
      "83297"
      iex> Faker.Address.zip_code()
      "05235"
  """
  @spec zip_code() :: String.t()
  localize(:zip_code)
end

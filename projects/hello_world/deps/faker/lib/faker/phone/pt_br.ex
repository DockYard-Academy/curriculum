defmodule Faker.Phone.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Function to generate Brazilian phone numbers.
  """

  @doc """
  Returns a random phone number.

  ## Examples

      iex> Faker.Phone.PtBr.phone()
      "(75) 9 1542-6461"
      iex> Faker.Phone.PtBr.phone()
      "(75) 4329-7052"
      iex> Faker.Phone.PtBr.phone()
      "(69) 9 7020-3032"
      iex> Faker.Phone.PtBr.phone()
      "(75) 5733-7603"
  """
  @spec phone :: binary
  def phone do
    base_template_number()
    |> Faker.format()
    |> number_with_region()
  end

  @doc """
  Replace 'xx' for a random region number picked.

  ## Examples
      iex> Faker.Phone.PtBr.number_with_region("(xx) 9 1542-6461")
      "(92) 9 1542-6461"
      iex> Faker.Phone.PtBr.number_with_region("(xx) 4329-7052")
      "(31) 4329-7052"
      iex> Faker.Phone.PtBr.number_with_region("(xx) 9 7020-3032")
      "(71) 9 7020-3032"
      iex> Faker.Phone.PtBr.number_with_region("(xx) 5733-7603")
      "(71) 5733-7603"
  """
  @spec number_with_region(binary) :: binary
  def number_with_region(number) do
    region = generate_region_code()

    number
    |> String.replace("xx", region)
  end

  @doc """
  Pick a random region code from list

  ## Examples
      iex> Faker.Phone.PtBr.generate_region_code()
      "92"
      iex> Faker.Phone.PtBr.generate_region_code()
      "31"
      iex> Faker.Phone.PtBr.generate_region_code()
      "71"
      iex> Faker.Phone.PtBr.generate_region_code()
      "71"
  """
  @spec generate_region_code :: binary
  def generate_region_code do
    region_code()
    |> Integer.to_string()
  end

  sampler(:base_template_number, [
    "(xx) 9 ####-####",
    "(xx) 2###-####",
    "(xx) 3###-####",
    "(xx) 4###-####",
    "(xx) 5###-####"
  ])

  sampler(:region_code, [
    71,
    75,
    11,
    21,
    27,
    31,
    41,
    47,
    51,
    81,
    82,
    83,
    84,
    85,
    86,
    61,
    62,
    63,
    65,
    67,
    68,
    69,
    71,
    79,
    91,
    92,
    95,
    96,
    98
  ])
end

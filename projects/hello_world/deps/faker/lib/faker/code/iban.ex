defmodule Faker.Code.Iban do
  @moduledoc """
  Functions for generating IBANs (International Bank Account Numbers).

  The generated IBANs should pass validators that check the checksum, country code, format and
  length of the IBAN.

  When more precision is required, you can pass predefined components that will be included in the
  generated IBAN. The components will not be validated, but are used when calculating the checksum.

  ## Examples

      iex> Faker.Code.Iban.iban
      "GI88LRCE6SQ3CQJGP3UHAJD"
      iex> Faker.Code.Iban.iban("NL")
      "NL26VYOC3032097337"
      iex> Faker.Code.Iban.iban(["NL", "BE"])
      "NL74YRFX4598109960"
      iex> Faker.Code.Iban.iban(["NL", "BE"])
      "BE31198979502980"
  """

  @alpha ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  @numeric ~w(0 1 2 3 4 5 6 7 8 9)
  @alpha_numeric @numeric ++ @alpha

  @iso_iban_specs [
    AL: [n: 8, c: 16],
    AD: [n: 8, c: 12],
    AT: [n: 16],
    AZ: [a: 4, c: 20],
    BH: [a: 4, c: 14],
    BE: [n: 12],
    BA: [n: 16],
    BR: [n: 23, a: 1, c: 1],
    BG: [a: 4, n: 6, c: 8],
    CR: [n: 17],
    HR: [n: 17],
    CY: [n: 8, c: 16],
    CZ: [n: 20],
    DK: [n: 14],
    FO: [n: 14],
    GL: [n: 14],
    DO: [c: 4, n: 20],
    EE: [n: 16],
    FI: [n: 14],
    FR: [n: 10, c: 11, n: 2],
    GE: [a: 2, n: 16],
    DE: [n: 18],
    GI: [a: 4, c: 15],
    GR: [n: 7, c: 16],
    GT: [c: 24],
    HU: [n: 24],
    IS: [n: 22],
    IE: [a: 4, n: 14],
    IL: [n: 19],
    IT: [a: 1, n: 10, c: 12],
    KW: [a: 4, c: 22],
    KZ: [n: 3, c: 13],
    LV: [a: 4, c: 13],
    LB: [n: 4, c: 20],
    LI: [n: 5, c: 12],
    LT: [n: 16],
    LU: [n: 3, c: 13],
    MK: [n: 3, c: 10, n: 2],
    MT: [a: 4, n: 5, c: 18],
    MR: [n: 23],
    MU: [a: 4, n: 19, a: 3],
    MD: [c: 20],
    MC: [n: 10, c: 11, n: 2],
    ME: [n: 18],
    NL: [a: 4, n: 10],
    NO: [n: 11],
    PK: [a: 4, c: 16],
    PS: [a: 4, c: 21],
    PL: [n: 24],
    PT: [n: 21],
    RO: [a: 4, c: 16],
    SM: [a: 1, n: 10, c: 12],
    SA: [n: 2, c: 18],
    RS: [n: 18],
    SK: [n: 20],
    SI: [n: 15],
    ES: [n: 20],
    SE: [n: 20],
    CH: [n: 5, c: 12],
    TN: [n: 20],
    TR: [n: 5, c: 17],
    AE: [n: 19],
    GB: [a: 4, n: 14],
    VG: [a: 4, n: 16]
  ]

  @spec iban() :: binary
  @doc """
  Returns a random IBAN from a random country

  ## Examples

      iex> Faker.Code.Iban.iban
      "GI88LRCE6SQ3CQJGP3UHAJD"
      iex> Faker.Code.Iban.iban
      "BR0302030320973376033745981CB"
      iex> Faker.Code.Iban.iban
      "BE98607198979502"
      iex> Faker.Code.Iban.iban
      "PT72807856869061130164499"
  """
  def iban, do: iban(Keyword.keys(@iso_iban_specs))

  @spec iban(binary | [binary]) :: binary
  @doc """
  Returns a random IBAN for a specific country code, or a random country code from a given list of
  country codes.

  ## Examples

      iex> Faker.Code.Iban.iban("FR")
      "FR650154264610QJGP3UHAJDJ02"
      iex> Faker.Code.Iban.iban("BE")
      "BE95030320973376"
      iex> Faker.Code.Iban.iban(["NL", "BE"])
      "NL31RFXY5981099607"
      iex> Faker.Code.Iban.iban(["BE", "DE"])
      "DE57989795029807856869"
  """
  def iban(country_code_or_codes), do: iban(country_code_or_codes, [])

  @doc """
  Returns a random IBAN starting with the given components. The given components are not validated
  but are included in the checksum.

  ## Examples

      iex> Faker.Code.Iban.iban("NL", ["ABNA"])
      "NL16ABNA0154264610"
      iex> Faker.Code.Iban.iban("MC", ["FOO", "BAR"])
      "MC98FOOBAR83"
      iex> Faker.Code.Iban.iban("SM", ["A"])
      "SM86A2970523570AY38NWIVZ5XT"
      iex> Faker.Code.Iban.iban("MC", ["FOO", "BAR"])
      "MC40FOOBAR60"
  """
  @spec iban(atom | binary | [binary], [binary]) :: binary
  def iban(country_code, prefix_components) when is_binary(country_code),
    do: iban(String.to_atom(country_code), prefix_components)

  def iban(country_codes, prefix_components) when is_list(country_codes),
    do: iban(sample(country_codes), prefix_components)

  def iban(country_code, prefix_components) when is_atom(country_code) do
    spec = Keyword.fetch!(@iso_iban_specs, country_code)
    {_, spec} = Enum.split(spec, length(prefix_components))
    bban = Enum.join(prefix_components) <> random_bban(spec)
    checksum = calculate_checksum(country_code, bban)
    "#{country_code}#{checksum}#{bban}"
  end

  defp calculate_checksum(country_code, bban) do
    checksum = 98 - rem(fragment_to_number("#{bban}#{country_code}") * 100, 97)
    if checksum < 10, do: "0#{checksum}", else: "#{checksum}"
  end

  defp fragment_to_number(fragment) do
    fragment
    |> fragment_to_numeric_string()
    |> String.to_integer()
  end

  defp fragment_to_numeric_string(<<character::utf8, tail::binary>>) do
    character = IO.iodata_to_binary([character])
    "#{Enum.find_index(@alpha_numeric, &(character == &1))}#{fragment_to_numeric_string(tail)}"
  end

  defp fragment_to_numeric_string(""), do: ""

  defp random_bban([entry]), do: random_bban(entry)
  defp random_bban([entry | tail]), do: random_bban(entry) <> random_bban(tail)
  defp random_bban([]), do: ""
  defp random_bban({:n, n}), do: random_bban(n, @numeric)
  defp random_bban({:a, n}), do: random_bban(n, @alpha)
  defp random_bban({:c, n}), do: random_bban(n, @alpha_numeric)

  defp random_bban(n, type) do
    n
    |> sample_list(type)
    |> Enum.join("")
  end

  defp sample_list(n, list) do
    Enum.map(0..(n - 1), fn _ -> sample(list) end)
  end

  defp sample(list) do
    Enum.fetch!(list, Faker.random_between(0, length(list) - 1))
  end
end

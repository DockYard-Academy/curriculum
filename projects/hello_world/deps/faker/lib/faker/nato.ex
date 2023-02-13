defmodule Faker.Nato do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating NATO alphabet data
  """

  @doc """
  Returns a random letter NATO code

  ## Examples

      iex> Faker.Nato.letter_code_word()
      "ECHO"
      iex> Faker.Nato.letter_code_word()
      "LIMA"
      iex> Faker.Nato.letter_code_word()
      "ROMEO"
      iex> Faker.Nato.letter_code_word()
      "CHARLIE"
  """
  @spec letter_code_word :: String.t()
  sampler(:letter_code_word, [
    "ALPHA",
    "BRAVO",
    "CHARLIE",
    "DELTA",
    "ECHO",
    "FOXTROT",
    "GOLF",
    "HOTEL",
    "INDIA",
    "JULIETT",
    "KILO",
    "LIMA",
    "MIKE",
    "NOVEMBER",
    "OSCAR",
    "PAPA",
    "QUEBEC",
    "ROMEO",
    "SIERRA",
    "TANGO",
    "UNIFORM",
    "VICTOR",
    "WHISKEY",
    "XRAY",
    "YANKEE",
    "ZULU"
  ])

  @doc """
  Returns a random digit NATO code

  ## Examples

      iex> Faker.Nato.digit_code_word()
      "ONE"
      iex> Faker.Nato.digit_code_word()
      "TWO"
      iex> Faker.Nato.digit_code_word()
      "SIX"
      iex> Faker.Nato.digit_code_word()
      "FIVE"
  """
  @spec digit_code_word :: String.t()
  sampler(:digit_code_word, [
    "ONE",
    "TWO",
    "THREE",
    "FOUR",
    "FIVE",
    "SIX",
    "SEVEN",
    "EIGHT",
    "NINE",
    "ZERO"
  ])

  @doc """
  Returns the NATO stop code

  ## Examples

      iex> Faker.Nato.stop_code_word()
      "STOP"
  """
  @spec stop_code_word :: String.t()
  def stop_code_word, do: "STOP"

  @doc """
  Returns a random NATO call sign of the form [alpha]-[alpha]-[digit]

  ## Examples

      iex> Faker.Nato.callsign()
      "ECHO-LIMA-SIX"
      iex> Faker.Nato.callsign()
      "CHARLIE-ECHO-SEVEN"
      iex> Faker.Nato.callsign()
      "SIERRA-GOLF-TWO"
      iex> Faker.Nato.callsign()
      "INDIA-WHISKEY-FOUR"
  """
  @spec callsign() :: String.t()
  def callsign, do: format("?-?-#")

  @doc """
  Formats a string using the NATO alphabet.

  It replaces `"#"` to a random NATO digit, `"?"` to random NATO letter
  and `"."` to the stop code.

  ## Examples

      iex> Faker.Nato.format("#-?-#-.")
      "ONE-LIMA-SIX-STOP"
      iex> Faker.Nato.format("#-?-#-.")
      "FIVE-ECHO-SEVEN-STOP"
      iex> Faker.Nato.format("#-?-#-.")
      "FIVE-GOLF-TWO-STOP"
      iex> Faker.Nato.format("#-?-#-.")
      "ONE-WHISKEY-FOUR-STOP"
  """
  @spec format(String.t()) :: String.t()
  def format(str) when is_binary(str) do
    format(str, "")
  end

  defp format(<<"#"::utf8, tail::binary>>, acc) do
    format(tail, <<acc::binary, "#{digit_code_word()}">>)
  end

  defp format(<<"?"::utf8, tail::binary>>, acc) do
    format(tail, <<acc::binary, "#{letter_code_word()}">>)
  end

  defp format(<<"."::utf8, tail::binary>>, acc) do
    format(tail, <<acc::binary, "#{stop_code_word()}">>)
  end

  defp format(<<other::utf8, tail::binary>>, acc) do
    format(tail, <<acc::binary, other>>)
  end

  defp format("", acc) do
    acc
  end
end

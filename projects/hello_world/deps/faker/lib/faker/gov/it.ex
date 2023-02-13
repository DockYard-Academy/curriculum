defmodule Faker.Gov.It do
  @moduledoc """
  Functions for data created/released by the Italian government,
  like fiscal codes
  """

  require Integer

  alias Faker.Util

  @doc """
  Returns a random Italian fiscal code

  ## Examples

      iex> Faker.Gov.It.fiscal_id
      "ELRCEA64C50A918F"
      iex> Faker.Gov.It.fiscal_id
      "ZSLNKH22M34H480J"
      iex> Faker.Gov.It.fiscal_id
      "OCPCVO90M50F353I"
      iex> Faker.Gov.It.fiscal_id
      "PQYRFX94R54C681K"
  """
  @spec fiscal_id() :: binary()
  def fiscal_id do
    surname()
    |> Kernel.<>(name())
    |> Kernel.<>(birth_year())
    |> Kernel.<>(birth_month())
    |> Kernel.<>(birth_day())
    |> Kernel.<>(town_code_letter())
    |> Kernel.<>(town_code_numbers())
    |> (&Kernel.<>(&1, cin(&1))).()
  end

  defp surname do
    Util.join(3, &Util.upper_letter/0)
  end

  defp name do
    Util.join(3, &Util.upper_letter/0)
  end

  defp birth_year do
    0
    |> Faker.random_between(99)
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  defp birth_month do
    Util.pick(~w(A B C D E H L M P R S T))
  end

  defp birth_day do
    1..71
    |> Util.pick()
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end

  defp town_code_letter do
    Util.pick(~w(A B C D E F G H I L M Z))
  end

  defp town_code_numbers do
    Faker.random_between(0, 999)
    |> Integer.to_string()
    |> String.pad_leading(3, "0")
  end

  defp cin(input) do
    {left, right} =
      input
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.reduce({0, 0}, fn {letter, index}, {acc_even, acc_odd} ->
        case Integer.is_even(index) do
          true -> {acc_even + cin_even(letter), acc_odd}
          false -> {acc_even, acc_odd + cin_odd(letter)}
        end
      end)

    Enum.at(
      ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z),
      Integer.mod(left + right, 26)
    )
  end

  defp cin_even("0"), do: 0
  defp cin_even("1"), do: 1
  defp cin_even("2"), do: 2
  defp cin_even("3"), do: 3
  defp cin_even("4"), do: 4
  defp cin_even("5"), do: 5
  defp cin_even("6"), do: 6
  defp cin_even("7"), do: 7
  defp cin_even("8"), do: 8
  defp cin_even("9"), do: 9
  defp cin_even("A"), do: 0
  defp cin_even("B"), do: 1
  defp cin_even("C"), do: 2
  defp cin_even("D"), do: 3
  defp cin_even("E"), do: 4
  defp cin_even("F"), do: 5
  defp cin_even("G"), do: 6
  defp cin_even("H"), do: 7
  defp cin_even("I"), do: 8
  defp cin_even("J"), do: 9
  defp cin_even("K"), do: 10
  defp cin_even("L"), do: 11
  defp cin_even("M"), do: 12
  defp cin_even("N"), do: 13
  defp cin_even("O"), do: 14
  defp cin_even("P"), do: 15
  defp cin_even("Q"), do: 16
  defp cin_even("R"), do: 17
  defp cin_even("S"), do: 18
  defp cin_even("T"), do: 19
  defp cin_even("U"), do: 20
  defp cin_even("V"), do: 21
  defp cin_even("W"), do: 22
  defp cin_even("X"), do: 23
  defp cin_even("Y"), do: 24
  defp cin_even("Z"), do: 25

  defp cin_odd("0"), do: 1
  defp cin_odd("1"), do: 0
  defp cin_odd("2"), do: 5
  defp cin_odd("3"), do: 7
  defp cin_odd("4"), do: 9
  defp cin_odd("5"), do: 13
  defp cin_odd("6"), do: 15
  defp cin_odd("7"), do: 17
  defp cin_odd("8"), do: 19
  defp cin_odd("9"), do: 21
  defp cin_odd("A"), do: 1
  defp cin_odd("B"), do: 0
  defp cin_odd("C"), do: 5
  defp cin_odd("D"), do: 7
  defp cin_odd("E"), do: 9
  defp cin_odd("F"), do: 13
  defp cin_odd("G"), do: 15
  defp cin_odd("H"), do: 17
  defp cin_odd("I"), do: 19
  defp cin_odd("J"), do: 21
  defp cin_odd("K"), do: 2
  defp cin_odd("L"), do: 4
  defp cin_odd("M"), do: 18
  defp cin_odd("N"), do: 20
  defp cin_odd("O"), do: 11
  defp cin_odd("P"), do: 3
  defp cin_odd("Q"), do: 6
  defp cin_odd("R"), do: 8
  defp cin_odd("S"), do: 12
  defp cin_odd("T"), do: 14
  defp cin_odd("U"), do: 16
  defp cin_odd("V"), do: 10
  defp cin_odd("W"), do: 22
  defp cin_odd("X"), do: 25
  defp cin_odd("Y"), do: 24
  defp cin_odd("Z"), do: 23
end

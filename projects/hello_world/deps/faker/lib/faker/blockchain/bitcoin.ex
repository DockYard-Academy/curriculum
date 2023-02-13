defmodule Faker.Blockchain.Bitcoin do
  @moduledoc """
  Functions for generate random bitcoin addresses.
  """

  def address(format \\ :main)

  @doc """
  Return bitcoin address. If pass `:testnet` it'll generate testnet address.

  ## Examples

      iex> Faker.Blockchain.Bitcoin.address()
      "1Lb2DM8vNXubePBWV7xmRnqJp5YT3BatcQ"
      iex> Faker.Blockchain.Bitcoin.address()
      "1erV2PhPaR4ndbEvLWDD9KX8btdNJZXt5"
      iex> Faker.Blockchain.Bitcoin.address(:main)
      "1Pn5NbAbT5hZocVWKSBtmqygdVbeVoheWk"
      iex> Faker.Blockchain.Bitcoin.address(:testnet)
      "mj1Vh7G8JZxg8gBtcQic2opTxtKUCQBBc5"
  """
  @spec address(atom) :: binary
  def address(:testnet) do
    base58(<<111>> <> Faker.random_bytes(20))
  end

  def address(:main) do
    base58(<<0>> <> Faker.random_bytes(20))
  end

  defp base58(hash) do
    (hash <> :binary.part(:crypto.hash(:sha256, :crypto.hash(:sha256, hash)), {0, 4}))
    |> :binary.bin_to_list()
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {v, i} -> round(v * :math.pow(256, i)) end)
    |> Enum.sum()
    |> ret
    |> String.reverse()
    |> npad(hash)
  end

  defp npad(addr, <<0>> <> rest), do: npad("1" <> addr, rest)
  defp npad(addr, _), do: addr

  defp ret(val), do: ret(round(val), "")

  defp ret(val, acc) when val > 0 do
    ret(div(val, 58), acc <> letter(rem(val, 58)))
  end

  defp ret(_, acc), do: acc

  defp letter(val) do
    ~w(1 2 3 4 5 6 7 8 9 A B C D E F G H J K L M N P Q R S T U V W X Y Z a b c d e f g h i j k m n o p q r s t u v w x y z)
    |> Enum.at(val)
  end
end

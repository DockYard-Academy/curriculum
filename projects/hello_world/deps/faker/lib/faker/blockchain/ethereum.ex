defmodule Faker.Blockchain.Ethereum do
  @moduledoc """
  Functions for generate ethereum addresses.
  """

  @type address :: <<_::336>>
  @type signature :: <<_::1056>>

  @doc """
  Return ethereum address

  ## Examples

      iex> Faker.Blockchain.Ethereum.address()
      "0xd6d98b88c866f496dbd4de7ba48d0f5229fa7bf9"
      iex> Faker.Blockchain.Ethereum.address()
      "0x0728b27267bc5b7c964f332dc9edd02cc9f381de"
      iex> Faker.Blockchain.Ethereum.address()
      "0xf9d922a146bf85508a5f03ff18750bf363f4aef1"
      iex> Faker.Blockchain.Ethereum.address()
      "0x264e3bcc9b5c2accb99a3a4993ad56b778dc26ed"
  """
  @spec address() :: address
  def address do
    "0x" <>
      (20
       |> Faker.random_bytes()
       |> Base.encode16(case: :lower))
  end

  @doc """
  Return ethereum signature

  ## Examples

  iex> Faker.Blockchain.Ethereum.signature()
  "0xd6d98b88c866f496dbd4de7ba48d0f5229fa7bf90728b27267bc5b7c964f332dc9edd02cc9f381def9d922a146bf85508a5f03ff18750bf363f4aef1264e3bcc9b"
  iex> Faker.Blockchain.Ethereum.signature()
  "0x5c2accb99a3a4993ad56b778dc26eddb7e0c2e49c4e638e62de32933bc3525bb4594a1a378dc29f741dd703efd94dd3b6d08feaa53a9a6fb9eea6655545932347c"
  iex> Faker.Blockchain.Ethereum.signature()
  "0x7457f665824d0e4c8465665584b69644419b5dddff8974b228ed08a17a077d116aea7f26a4bf4aa5fc4841e85670392a32a0980264dc44f82f311ea7289f6b38fd"
  iex> Faker.Blockchain.Ethereum.signature()
  "0x0bce6fe7988f0f95a5e752150f018979129ef5d015ecf11dab74c42d0a51b8f7beb51374870811d45ca30920d02a913832764bac562323b4aafae9943a12de8d42"
  """
  @spec signature() :: signature
  def signature do
    "0x" <>
      (65
       |> Faker.random_bytes()
       |> Base.encode16(case: :lower))
  end
end

defmodule Faker.Bitcoin do
  @moduledoc false

  alias Faker.Blockchain.Bitcoin

  @deprecated "Use Faker.Blockchain.Bitcoin.address instead"
  def address(format \\ :main)

  def address(:testnet) do
    Bitcoin.address(:testnet)
  end

  def address(:main) do
    Bitcoin.address(:main)
  end
end

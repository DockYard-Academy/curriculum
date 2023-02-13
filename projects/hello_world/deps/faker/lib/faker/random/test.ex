defmodule Faker.Random.Test do
  @moduledoc false

  def random_between(left, right) do
    set_seed(:ets.lookup(:seed_registry, self()))
    Enum.random(left..right)
  end

  def random_bytes(total) do
    set_seed(:ets.lookup(:seed_registry, self()))

    Stream.repeatedly(fn -> Enum.random(0..255) end)
    |> Enum.take(total)
    |> IO.iodata_to_binary()
  end

  def random_uniform do
    set_seed(:ets.lookup(:seed_registry, self()))
    :rand.uniform()
  end

  defp set_seed([]) do
    :rand.seed(:exsplus, {1, 1, 1})
    :ets.insert(:seed_registry, {self(), true})
  end

  defp set_seed(_) do
  end
end

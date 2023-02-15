defmodule Faker.Random do
  @moduledoc """
  Behaviour that defines randomisation in faker.
  """

  @callback random_between(integer, integer) :: integer
  @callback random_bytes(pos_integer) :: binary
  @callback random_uniform() :: float

  defmacro __using__(_) do
    quote do
      @behaviour Faker.Random

      def random_between(left, right) do
        Enum.random(left..right)
      end

      def random_bytes(total) do
        :crypto.strong_rand_bytes(total)
      end

      def random_uniform do
        :rand.uniform()
      end

      defoverridable random_between: 2, random_bytes: 1, random_uniform: 0
    end
  end
end

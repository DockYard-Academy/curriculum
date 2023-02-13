defmodule HelloWorld do
  @moduledoc """
  Documentation for `HelloWorld`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> HelloWorld.hello()
      :world

  """
  def hello do
    # "Hello, #{HelloWorld.Name.random()}"
    "Hello, #{Faker.Person.first_name()}."
  end
end

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
    "Hello, #{Faker.Person.first_name()}."
  end
end

defmodule HelloWorld.Name do
  def random do
    Enum.random(["Matt", "Mike", "Ant"])
  end
end

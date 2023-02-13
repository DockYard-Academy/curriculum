defmodule Faker.Util.En do
  @moduledoc false

  import Faker.Util, only: [pick: 1]

  @digit ~w/0 1 2 3 4 5 6 7 8 9/
  @lowercase_alphabet ~w/a b c d e f g h i j k l m n o p q r s t u v w x y z/
  @uppercase_alphabet ~w/A B C D E F G H I J K L M N O P Q R S T U V W X Y Z/
  @alphabet @lowercase_alphabet ++ @uppercase_alphabet

  @doc """
  Get a random digit as a string; one of 0-9
  """
  @spec digit() :: binary
  def digit do
    pick(@digit)
  end

  @doc """
  Get a random alphabet character as a string; one of a-z or A-Z
  """
  @spec letter() :: binary
  def letter do
    pick(@alphabet)
  end

  @doc """
  Get a random lowercase character as a string; one of a-z
  """
  @spec lower_letter() :: binary
  def lower_letter do
    pick(@lowercase_alphabet)
  end

  @doc """
  Get a random uppercase character as a string; one of A-Z
  """
  @spec upper_letter() :: binary
  def upper_letter do
    pick(@uppercase_alphabet)
  end

  @doc """
  Converts a list to a string, with "and" before the last item. Uses an Oxford comma.
  """
  @spec to_sentence([binary]) :: binary
  def to_sentence([]), do: ""
  def to_sentence([single]), do: single
  def to_sentence([first, second]), do: "#{first} and #{second}"
  def to_sentence([first | rest]), do: Enum.join(rest, ", ") <> ", and #{first}"
end

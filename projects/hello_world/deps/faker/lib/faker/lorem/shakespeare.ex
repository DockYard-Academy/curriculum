defmodule Faker.Lorem.Shakespeare do
  import Faker, only: [localize: 1]

  @moduledoc """
  Random quotes from William Shakespeare's plays, sonnets and poems.
  """

  @doc """
  Return random quote from "The Tragedy of Hamlet, Prince of Denmark" tragedy.

  ## Examples

      iex> Faker.Lorem.Shakespeare.hamlet()
      "Brevity is the soul of wit."
      iex> Faker.Lorem.Shakespeare.hamlet()
      "And it must follow, as the night the day, thou canst not then be false to any man."
      iex> Faker.Lorem.Shakespeare.hamlet()
      "Do you think I am easier to be played on than a pipe?"
      iex> Faker.Lorem.Shakespeare.hamlet()
      "Rich gifts wax poor when givers prove unkind."
  """
  @spec hamlet() :: String.t()
  localize(:hamlet)

  @doc """
  Return random quote from "As You Like It" comedy.

  ## Examples

      iex> Faker.Lorem.Shakespeare.as_you_like_it()
      "For ever and a day."
      iex> Faker.Lorem.Shakespeare.as_you_like_it()
      "Can one desire too much of a good thing?."
      iex> Faker.Lorem.Shakespeare.as_you_like_it()
      "How bitter a thing it is to look into happiness through another man's eyes!"
      iex> Faker.Lorem.Shakespeare.as_you_like_it()
      "All the world's a stage, and all the men and women merely players. They have their exits and their entrances; And one man in his time plays many parts."
  """
  @spec as_you_like_it() :: String.t()
  localize(:as_you_like_it)

  @doc """
  Return random quote from "Richard III" play.

  ## Examples

      iex> Faker.Lorem.Shakespeare.king_richard_iii()
      "The king's name is a tower of strength."
      iex> Faker.Lorem.Shakespeare.king_richard_iii()
      "A horse! a horse! my kingdom for a horse!"
      iex> Faker.Lorem.Shakespeare.king_richard_iii()
      "So wise so young, they say, do never live long."
      iex> Faker.Lorem.Shakespeare.king_richard_iii()
      "Now is the winter of our discontent."
  """
  @spec king_richard_iii() :: String.t()
  localize(:king_richard_iii)

  @doc """
  Return random quote from "Romeo and Juliet" tragedy.

  ## Examples

      iex> Faker.Lorem.Shakespeare.romeo_and_juliet()
      "What's in a name? That which we call a rose by any other name would smell as sweet."
      iex> Faker.Lorem.Shakespeare.romeo_and_juliet()
      "For you and I are past our dancing days."
      iex> Faker.Lorem.Shakespeare.romeo_and_juliet()
      "For you and I are past our dancing days."
      iex> Faker.Lorem.Shakespeare.romeo_and_juliet()
      "For you and I are past our dancing days."
  """
  @spec romeo_and_juliet() :: String.t()
  localize(:romeo_and_juliet)
end

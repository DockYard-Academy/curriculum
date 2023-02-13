defmodule Faker.Lorem.Shakespeare.En do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Random quotes from William Shakespeare's plays, sonnets and poems in English.
  """

  @doc """
  Return random quote from "The Tragedy of Hamlet, Prince of Denmark" tragedy.

  ## Examples

      iex> Faker.Lorem.Shakespeare.En.hamlet()
      "Brevity is the soul of wit."
      iex> Faker.Lorem.Shakespeare.En.hamlet()
      "And it must follow, as the night the day, thou canst not then be false to any man."
      iex> Faker.Lorem.Shakespeare.En.hamlet()
      "Do you think I am easier to be played on than a pipe?"
      iex> Faker.Lorem.Shakespeare.En.hamlet()
      "Rich gifts wax poor when givers prove unkind."
  """
  @spec hamlet() :: String.t()
  sampler(:hamlet, [
    "To be, or not to be: that is the question.",
    "Neither a borrower nor a lender be; For loan oft loses both itself and friend, and borrowing dulls the edge of husbandry.",
    "This above all: to thine own self be true.",
    "Though this be madness, yet there is method in 't.",
    "That it should come to this!",
    "There is nothing either good or bad, but thinking makes it so.",
    "What a piece of work is man! how noble in reason! how infinite in faculty! in form and moving how express and admirable! in action how like an angel! in apprehension how like a god! the beauty of the world, the paragon of animals! .",
    "The lady doth protest too much, methinks.",
    "In my mind's eye.",
    "A little more than kin, and less than kind.",
    "The play 's the thing wherein I'll catch the conscience of the king.",
    "And it must follow, as the night the day, thou canst not then be false to any man.",
    "Brevity is the soul of wit.",
    "Doubt that the sun doth move, doubt truth to be a liar, but never doubt I love.",
    "Rich gifts wax poor when givers prove unkind.",
    "Do you think I am easier to be played on than a pipe?",
    "I will speak daggers to her, but use none.",
    "When sorrows come, they come not single spies, but in battalions."
  ])

  @doc """
  Return random quote from "As You Like It" comedy.

  ## Examples

      iex> Faker.Lorem.Shakespeare.En.as_you_like_it()
      "For ever and a day."
      iex> Faker.Lorem.Shakespeare.En.as_you_like_it()
      "Can one desire too much of a good thing?."
      iex> Faker.Lorem.Shakespeare.En.as_you_like_it()
      "How bitter a thing it is to look into happiness through another man's eyes!"
      iex> Faker.Lorem.Shakespeare.En.as_you_like_it()
      "All the world's a stage, and all the men and women merely players. They have their exits and their entrances; And one man in his time plays many parts."
  """
  @spec as_you_like_it() :: String.t()
  sampler(:as_you_like_it, [
    "All the world's a stage, and all the men and women merely players. They have their exits and their entrances; And one man in his time plays many parts.",
    "Can one desire too much of a good thing?.",
    "I like this place and willingly could waste my time in it.",
    "How bitter a thing it is to look into happiness through another man's eyes!",
    "Blow, blow, thou winter wind! Thou art not so unkind as man's ingratitude.",
    "True is it that we have seen better days.",
    "For ever and a day.",
    "The fool doth think he is wise, but the wise man knows himself to be a fool."
  ])

  @doc """
  Return random quote from "Richard III" play.

  ## Examples

      iex> Faker.Lorem.Shakespeare.En.king_richard_iii()
      "The king's name is a tower of strength."
      iex> Faker.Lorem.Shakespeare.En.king_richard_iii()
      "A horse! a horse! my kingdom for a horse!"
      iex> Faker.Lorem.Shakespeare.En.king_richard_iii()
      "So wise so young, they say, do never live long."
      iex> Faker.Lorem.Shakespeare.En.king_richard_iii()
      "Now is the winter of our discontent."
  """
  @spec king_richard_iii() :: String.t()
  sampler(:king_richard_iii, [
    "Now is the winter of our discontent.",
    "A horse! a horse! my kingdom for a horse!",
    "Conscience is but a word that cowards use, devised at first to keep the strong in awe.",
    "So wise so young, they say, do never live long.",
    "Off with his head!",
    "An honest tale speeds best, being plainly told.",
    "The king's name is a tower of strength.",
    "The world is grown so bad, that wrens make prey where eagles dare not perch."
  ])

  @doc """
  Return random quote from "Romeo and Juliet" tragedy.

  ## Examples

      iex> Faker.Lorem.Shakespeare.En.romeo_and_juliet()
      "What's in a name? That which we call a rose by any other name would smell as sweet."
      iex> Faker.Lorem.Shakespeare.En.romeo_and_juliet()
      "For you and I are past our dancing days."
      iex> Faker.Lorem.Shakespeare.En.romeo_and_juliet()
      "For you and I are past our dancing days."
      iex> Faker.Lorem.Shakespeare.En.romeo_and_juliet()
      "For you and I are past our dancing days."
  """
  @spec romeo_and_juliet() :: String.t()
  sampler(:romeo_and_juliet, [
    "O Romeo, Romeo! wherefore art thou Romeo?.",
    "It is the east, and Juliet is the sun.",
    "Good Night, Good night! Parting is such sweet sorrow, that I shall say good night till it be morrow.",
    "What's in a name? That which we call a rose by any other name would smell as sweet.",
    "Wisely and slow; they stumble that run fast.",
    "Tempt not a desperate man.",
    "For you and I are past our dancing days.",
    "O! she doth teach the torches to burn bright.",
    "It seems she hangs upon the cheek of night like a rich jewel in an Ethiope's ear.",
    "See, how she leans her cheek upon her hand! O that I were a glove upon that hand, that I might touch that cheek!.",
    "Not stepping o'er the bounds of modesty."
  ])
end

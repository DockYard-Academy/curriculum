defmodule Faker.Cat.En do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for Cat names, breeds and registries in English
  """

  @doc """
  Returns a Cat name string

  ## Examples

      iex> Faker.Cat.En.name()
      "Daisy"
      iex> Faker.Cat.En.name()
      "Lily"
      iex> Faker.Cat.En.name()
      "Felix"
      iex> Faker.Cat.En.name()
      "Max"
  """
  @spec name() :: String.t()
  sampler(:name, [
    "Alfie",
    "Angel",
    "Bella",
    "Charlie",
    "Chloe",
    "Coco",
    "Daisy",
    "Felix",
    "Jasper",
    "Lily",
    "Lucky",
    "Lucy",
    "Max",
    "Millie",
    "Milo",
    "Missy",
    "Misty",
    "Molly",
    "Oliver",
    "Oscar",
    "Poppy",
    "Sam",
    "Shadow",
    "Simba",
    "Smokey",
    "Smudge",
    "Sooty",
    "Tiger"
  ])

  @doc """
  Returns a Cat breed string

  ## Examples

      iex> Faker.Cat.En.breed()
      "Mekong Bobtail"
      iex> Faker.Cat.En.breed()
      "Suphalak"
      iex> Faker.Cat.En.breed()
      "Russian White, Black and Tabby"
      iex> Faker.Cat.En.breed()
      "Asian Semi-longhair"
  """
  @spec breed() :: String.t()
  sampler(:breed, [
    "Abyssinian",
    "Aegean",
    "American Bobtail",
    "American Curl",
    "American Shorthair",
    "American Wirehair",
    "Arabian Mau",
    "Asian",
    "Asian Semi-longhair",
    "Australian Mist",
    "Balinese",
    "Bambino",
    "Bengal",
    "Birman",
    "Bombay",
    "Brazilian Shorthair",
    "British Longhair",
    "British Semipi-longhair",
    "British Shorthair",
    "Burmese",
    "Burmilla",
    "California Spangled",
    "Chantilly-Tiffany",
    "Chartreux",
    "Chausie",
    "Cheetoh",
    "Colorpoint Shorthair",
    "Cornish Rex",
    "Cymric, or Manx Longhair",
    "Cyprus",
    "Devon Rex",
    "Donskoy, or Don Sphynx",
    "Dragon Li",
    "Dwarf cat, or Dwelf",
    "Egyptian Mau",
    "European Shorthair",
    "Exotic Shorthair",
    "Foldex Cat",
    "German Rex",
    "Havana Brown",
    "Highlander",
    "Himalayan, or Colorpoint Persian",
    "Japanese Bobtail",
    "Javanese",
    "Khao Manee",
    "Korat",
    "Korean Bobtail",
    "Korn Ja",
    "Kurilian Bobtail",
    "Kurilian Bobtail, or Kuril Islands Bobtail",
    "LaPerm",
    "Lykoi",
    "Maine Coon",
    "Manx",
    "Mekong Bobtail",
    "Minskin",
    "Munchkin",
    "Napoleon",
    "Nebelung",
    "Norwegian Forest Cat",
    "Ocicat",
    "Ojos Azules",
    "Oregon Rex",
    "Oriental Bicolor",
    "Oriental Longhair",
    "Oriental Shorthair",
    "PerFold Cat (Experimental Breed - WCF)",
    "Persian (Modern Persian Cat)",
    "Persian (Traditional Persian Cat)",
    "Peterbald",
    "Pixie-bob",
    "Raas",
    "Ragamuffin",
    "Ragdoll",
    "Russian Blue",
    "Russian White, Black and Tabby",
    "Sam Sawet",
    "Savannah",
    "Scottish Fold",
    "Selkirk Rex",
    "Serengeti",
    "Serrade petit",
    "Siamese",
    "Siberian",
    "Singapura",
    "Snowshoe",
    "Sokoke",
    "Somali",
    "Sphynx",
    "Suphalak",
    "Thai",
    "Tonkinese",
    "Toyger",
    "Turkish Angora",
    "Turkish Van",
    "Ukrainian Levkoy"
  ])

  @doc """
  Returns a cat registry string

  ## Examples

      iex> Faker.Cat.En.registry()
      "Cat Aficionado Association"
      iex> Faker.Cat.En.registry()
      "Fédération Internationale Féline"
      iex> Faker.Cat.En.registry()
      "Fédération Internationale Féline"
      iex> Faker.Cat.En.registry()
      "Fédération Internationale Féline"
  """
  @spec registry() :: String.t()
  sampler(:registry, [
    "American Cat Fanciers Association",
    "Associazione Nazionale Felina Italiana",
    "Canadian Cat Association",
    "Cat Aficionado Association",
    "Cat Fanciers' Association",
    "Emirates Feline Federation",
    "Fédération Internationale Féline",
    "Felis Britannica",
    "Governing Council of the Cat",
    "Fancy Southern Africa Cat Council",
    "The International Cat Association"
  ])
end

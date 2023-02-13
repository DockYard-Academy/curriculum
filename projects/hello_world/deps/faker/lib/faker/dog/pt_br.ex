defmodule Faker.Dog.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for Dog names, breeds and characteristics in Portuguese
  """

  @doc """
  Returns a dog name.

  ## Examples

      iex> Faker.Dog.PtBr.name()
      "Simba"
      iex> Faker.Dog.PtBr.name()
      "Max"
      iex> Faker.Dog.PtBr.name()
      "Malu"
      iex> Faker.Dog.PtBr.name()
      "Mike"
  """
  @spec name() :: String.t()
  sampler(:name, [
    "Amora",
    "Belinha",
    "Bela",
    "Bidu",
    "Billy",
    "Bob",
    "Boris",
    "Bruce",
    "Buddy",
    "Cacau",
    "Chanel",
    "Chico",
    "Cindy",
    "Fiona",
    "Fred",
    "Frederico",
    "Frida",
    "Iracema",
    "Jack",
    "Jade",
    "Kiara",
    "Lara",
    "Lili",
    "Lilica",
    "Lola",
    "Lua",
    "Luke",
    "Luna",
    "Malu",
    "Marley",
    "Max",
    "Maya",
    "Meg",
    "Mike",
    "Nick",
    "Nina",
    "Ozzy",
    "Pandora",
    "Pingo",
    "Princesa",
    "Scooby",
    "Simba",
    "Sofia",
    "Theo",
    "Thor",
    "Tobias",
    "Toddy",
    "Zeca",
    "Zeus"
  ])

  @doc """
  Returns a dog breed.

  ## Examples

      iex> Faker.Dog.PtBr.breed()
      "Boxer"
      iex> Faker.Dog.PtBr.breed()
      "Schnauzer"
      iex> Faker.Dog.PtBr.breed()
      "Lhasa apso"
      iex> Faker.Dog.PtBr.breed()
      "Fila brasileiro"
  """
  @spec breed() :: String.t()
  sampler(:breed, [
    "Akita",
    "Basset hound",
    "Beagle",
    "Bichon frisé",
    "Boiadeiro australiano",
    "Border collie",
    "Boston terrier",
    "Boxer",
    "Buldogue francês",
    "Buldogue inglês",
    "Bull terrier",
    "Cane corso",
    "Cavalier king charles spaniel",
    "Chihuahua",
    "Chow chow",
    "Cocker spaniel inglês",
    "Dachshund",
    "Dálmata",
    "Doberman",
    "Dogo argentino",
    "Dogue alemão",
    "Fila brasileiro",
    "Golden retriever",
    "Husky siberiano",
    "Jack russell terrier",
    "Labrador retriever",
    "Lhasa apso",
    "Lulu da pomerânia",
    "Maltês",
    "Mastiff inglês",
    "Mastim tibetano",
    "Pastor alemão",
    "Pastor australiano",
    "Pastor de Shetland",
    "Pequinês",
    "Pinscher",
    "Pit bull",
    "Poodle",
    "Pug",
    "Rottweiler",
    "Schnauzer",
    "Shar-pei",
    "Shiba",
    "Shih tzu",
    "Staffordshire bull terrier",
    "Weimaraner",
    "Yorkshire"
  ])

  @doc """
  Returns a characteristic of a dog.

  ## Examples

      iex> Faker.Dog.PtBr.characteristic()
      "Atlético, protetor e amável"
      iex> Faker.Dog.PtBr.characteristic()
      "Independente, reservado e inteligente"
      iex> Faker.Dog.PtBr.characteristic()
      "Amigável, trabalhador e extrovertido"
      iex> Faker.Dog.PtBr.characteristic()
      "Calmo, leal e orgulhoso"
  """
  @spec characteristic() :: String.t()
  sampler(:characteristic, [
    "Alegre, carinhoso e cheio de vida",
    "Alegre, companheiro e aventureiro",
    "Amigável, inteligente e vivaz",
    "Amigável, trabalhador e extrovertido",
    "Amoroso, temperamental e companheiro",
    "Animado, inteligente e cheio de personalidade",
    "Atlético, protetor e amável",
    "Brincalhão, energético e esperto",
    "Calmo, leal e orgulhoso",
    "Carinhoso, brincalhão e encantador",
    "Carinhoso, leal e brincalhão",
    "Charmoso, animado e atrevido",
    "Companheiro, alegre e afetuoso",
    "Corajoso, animado e inteligente",
    "Destemido, carinhoso e cheio de energia",
    "Esperto, confiante e independente",
    "Gentil, brincalhão e afetuoso",
    "Independente, reservado e inteligente",
    "Inteligente, brincalhão e leal",
    "Leal, amigo e brincalhão",
    "Orgulhoso, ativo e inteligente",
    "Paciente, teimoso e charmoso",
    "Protetor, leal e inteligente",
    "Travesso, brincalhão e leal"
  ])
end

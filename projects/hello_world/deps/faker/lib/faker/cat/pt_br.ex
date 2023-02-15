defmodule Faker.Cat.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for Cat names and breeds in Brazilian Portuguese
  """

  @doc """
  Returns a Cat famele name string

  ## Examples

      iex> Faker.Cat.PtBr.female_name()
      "Samy"
      iex> Faker.Cat.PtBr.female_name()
      "Linda"
      iex> Faker.Cat.PtBr.female_name()
      "Úrsula"
      iex> Faker.Cat.PtBr.female_name()
      "Florinda"
  """
  @spec female_name() :: String.t()
  sampler(:female_name, [
    "Amber",
    "Amelie",
    "Amora",
    "Amy",
    "Ariel",
    "Babi",
    "Barbie",
    "Bombom",
    "Cacau",
    "Charlotte",
    "Chiquinha",
    "Cindy",
    "Cristal",
    "Dalila",
    "Dama",
    "Dora",
    "Dori",
    "Estrela",
    "Felícia",
    "Fibi",
    "Filipa",
    "Filomena",
    "Filó",
    "Fiona",
    "Florinda",
    "Florisbela",
    "Fofuxa",
    "Frida",
    "Gaia",
    "Gertrudes",
    "Gina",
    "Hazel",
    "Jabuticaba",
    "Jade",
    "Jasmin",
    "Kaila",
    "Kibana",
    "Kim",
    "Kindy",
    "Lila",
    "Lili",
    "Linda",
    "Lizi",
    "Lola",
    "Lolita",
    "Lua",
    "Lulu",
    "Luna",
    "Luzi",
    "Madonna",
    "Mafalda",
    "Magali",
    "Malu",
    "Mel",
    "Merida",
    "Mia",
    "Mica",
    "Mimi",
    "Moana",
    "Moli",
    "Nala",
    "Nanny",
    "Nairóbi",
    "Nikita",
    "Nina",
    "Pandora",
    "Paçoca",
    "Pipoca",
    "Pituca",
    "Safira",
    "Samy",
    "Sandi",
    "Selena",
    "Soneca",
    "Tina",
    "Úrsula",
    "Vanellope",
    "Wendy",
    "Xica",
    "Zoe"
  ])

  @doc """
  Returns a Cat male name string

  ## Examples

      iex> Faker.Cat.PtBr.male_name()
      "Soneca"
      iex> Faker.Cat.PtBr.male_name()
      "Loui"
      iex> Faker.Cat.PtBr.male_name()
      "Ton"
      iex> Faker.Cat.PtBr.male_name()
      "Dante"
  """
  @spec male_name() :: String.t()
  sampler(
    :male_name,
    [
      "Aladim",
      "Algodão",
      "Apolo",
      "Amendoim",
      "Amendupã",
      "Aristóteles",
      "Bambi",
      "Banguela",
      "Bartolomeu",
      "Batman",
      "Bigode",
      "Biscoito",
      "Bob",
      "Bolota",
      "Bombom",
      "Boris",
      "Boyle",
      "Brutus",
      "Cadu",
      "Calvin",
      "Chewie",
      "Chico",
      "Clemente",
      "Clovis",
      "Dante",
      "Elvis",
      "Fidélix",
      "Frajola",
      "Fred",
      "Freud",
      "Félix",
      "Galeão",
      "Garfield",
      "Genóvio",
      "Gepeto",
      "Holt",
      "Homer",
      "Joca",
      "Joey",
      "Juca",
      "Justin",
      "Loui",
      "Malvin",
      "Merlin",
      "Mingau",
      "Naruto",
      "Nemo",
      "Nicolau",
      "Nilo",
      "Nino",
      "Olaf",
      "Oliver",
      "Oreo",
      "Oliver",
      "Peralta",
      "Peter",
      "Picasso",
      "Pingo",
      "Pipoca",
      "Pirulito",
      "Platão",
      "Pluma",
      "Pomposo",
      "Pongo",
      "Romeu",
      "Ross",
      "Ruffus",
      "Russo",
      "Simba",
      "Singer",
      "Soneca",
      "Spike",
      "Tenente",
      "Thor",
      "Tommy",
      "Ton",
      "Tonico",
      "Tufão",
      "Venon",
      "Yoda"
    ]
  )

  @doc """
  Returns a Cat breed string

  ## Examples

      iex> Faker.Cat.PtBr.breed()
      "Angorá Turco"
      iex> Faker.Cat.PtBr.breed()
      "Azul Russo"
      iex> Faker.Cat.PtBr.breed()
      "Pelo Curto Brasileiro"
      iex> Faker.Cat.PtBr.breed()
      "Pelo Curto Americano"
  """
  @spec breed() :: String.t()
  sampler(:breed, [
    "Angorá Turco",
    "Azul Russo",
    "Bombaim",
    "Himalaio",
    "Pelo Curto Americano",
    "Pelo Curto Brasileiro",
    "Pelo Curto Europeu",
    "Persa",
    "Siamês",
    "Vira-lata"
  ])
end

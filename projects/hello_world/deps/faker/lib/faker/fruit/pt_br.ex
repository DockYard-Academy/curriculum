defmodule Faker.Fruit.PtBr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for fruit data in Brazilian Portuguese.
  """

  @doc """
  Returns a fruit.

  ## Examples

      iex> Faker.Fruit.PtBr.fruit
      "Fruta-do-conde"
      iex> Faker.Fruit.PtBr.fruit
      "Bergamota"
      iex> Faker.Fruit.PtBr.fruit
      "Quixaba"
      iex> Faker.Fruit.PtBr.fruit
      "Amora"
  """
  @spec fruit() :: String.t()
  sampler(:fruit, [
    "Abacaxi",
    "Ananá",
    "Amora",
    "Açaí",
    "Abacate",
    "Acerola",
    "Ameixa",
    "Ackee",
    "Araticum",
    "Araçá",
    "Banana",
    "Bergamota",
    "Baru",
    "Bacuri",
    "Bacuripari",
    "Babaçu",
    "Butiá",
    "Coco",
    "Cereja",
    "Caju",
    "Caqui",
    "Carambola",
    "Cupuaçu",
    "Ciriguela",
    "Cacau",
    "Damasco",
    "Dendê",
    "Esfregadinha",
    "Escropari",
    "Framboesa",
    "Fruta-do-conde",
    "Figo",
    "Feijoa",
    "Fruta-pão",
    "Goiaba",
    "Graviola",
    "Groselha",
    "Guaraná",
    "Guabiroba",
    "Hilocéreo",
    "Imbu",
    "Jenipapo",
    "Jabuticaba",
    "Jaca",
    "Jambo",
    "Jamelão",
    "Jatobá",
    "Kiwi",
    "Limão",
    "Laranja",
    "Lima",
    "Mamão",
    "Maçã",
    "Manga",
    "Morango",
    "Mertilo",
    "Maracujá",
    "Melão",
    "Melancia",
    "Mexirica",
    "Necatarina",
    "Noz-pecã",
    "Pera",
    "Pêssego",
    "Pitanga",
    "Pitaia",
    "Pitomba",
    "Pequi",
    "Quina",
    "Quixaba",
    "Romã",
    "Seriguela",
    "Tangerina",
    "Tâmara",
    "Tucumã",
    "Uva",
    "Xixá",
    "Zimbro"
  ])
end

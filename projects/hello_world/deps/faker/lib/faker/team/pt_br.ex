defmodule Faker.Team.PtBr do
  import Faker, only: [sampler: 2]
  alias Faker.Address

  @moduledoc """
  Functions for generating team related data in Brazilian Portuguese
  """

  @doc """
  Returns a string of the form [state] [creature]

  ## Examples

      iex> Faker.Team.PtBr.name()
      "corujas de Alaska"
      iex> Faker.Team.PtBr.name()
      "vampiros de California"
      iex> Faker.Team.PtBr.name()
      "pássaros de Kentucky"
      iex> Faker.Team.PtBr.name()
      "vixens de Kentucky"
  """
  @spec name() :: String.t()
  def name, do: "#{creature()} de #{Address.state()}"

  @doc """
  Returns a random creature name

  ## Examples

      iex> Faker.Team.PtBr.creature()
      "corujas"
      iex> Faker.Team.PtBr.creature()
      "ovelha"
      iex> Faker.Team.PtBr.creature()
      "vampiros"
      iex> Faker.Team.PtBr.creature()
      "macacos"
  """
  @spec creature() :: String.t()
  sampler(:creature, [
    "formigas",
    "morcegos",
    "ursos",
    "abelhas",
    "pássaros",
    "gatos pretos",
    "búfalo",
    "gatos",
    "gado",
    "galinhas",
    "corvos",
    "cachorros",
    "golfinhos",
    "dragões",
    "patos",
    "elefantes",
    "elfos",
    "peixes",
    "raposas",
    "sapos",
    "gansos",
    "fantasmas",
    "gnomos",
    "cabras",
    "gansos",
    "cavalos",
    "cangurus",
    "leões",
    "macacos",
    "oráculos",
    "corujas",
    "bois",
    "pinguins",
    "pessoas",
    "porcos",
    "profetas",
    "coelhos",
    "ovelha",
    "filhos",
    "feiticeiros",
    "aranhas",
    "espíritos",
    "tigres",
    "vampiros",
    "vixens",
    "warlocks",
    "lobisomens",
    "baleias",
    "bruxas",
    "lobos",
    "zebras",
    "zumbis"
  ])
end

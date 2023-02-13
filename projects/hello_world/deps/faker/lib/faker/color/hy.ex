defmodule Faker.Color.Hy do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating color data in Armenian
  """

  @doc """
  Returns a random color name.

  ## Examples

      iex> Faker.Color.Hy.name()
      "մոխրագույն"
      iex> Faker.Color.Hy.name()
      "կանաչ"
      iex> Faker.Color.Hy.name()
      "երկնագույն"
      iex> Faker.Color.Hy.name()
      "մանուշակագույն"
  """
  @spec name() :: String.t()
  sampler(:name, [
    "կարմիր",
    "կանաչ",
    "կապույտ",
    "դեղին",
    "մանուշակագույն",
    "շագանակագույն",
    "սպիտակ",
    "սև",
    "նարնջագույն",
    "վարդագույն",
    "մոխրագույն",
    "մանուշակագույն",
    "փիրուզագույն",
    "մուգ մանուշակագույն",
    "դեղնավարդագույն",
    "երկնագույն",
    "դեղնականաչ",
    "թուխ",
    "ոսկեգույն",
    "դարչնագույն"
  ])
end

defmodule Faker.Aws.PtPt do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating AWS information in Portuguese of Portugal
  """

  @doc """
  Returns a random region name available on AWS

  ## Examples

      iex> Faker.Aws.PtPt.region_name()
      "Asia Pacifico (Tóquio)"
      iex> Faker.Aws.PtPt.region_name()
      "EUA Este (Ohio)"
      iex> Faker.Aws.PtPt.region_name()
      "Europa (Milão)"
      iex> Faker.Aws.PtPt.region_name()
      "Africa (Cape Town)"
  """
  @spec region_name() :: String.t()
  sampler(:region_name, [
    "EUA Este (Virginia do Norte)",
    "EUA Este (Ohio)",
    "EUA Oeste (California do Norte)",
    "EUA Oeste (Oregon)",
    "Africa (Cape Town)",
    "Asia Pacifico (Hong Kong)",
    "Asia Pacifico (Mumbai)",
    "Asia Pacifico (Seoul)",
    "Asia Pacifico (Singapura)",
    "Asia Pacifico (Sydney)",
    "Asia Pacifico (Tóquio)",
    "Canada (Central)",
    "Europa (Frankfurt)",
    "Europa (Irlanda)",
    "Europa (Londres)",
    "Europa (Milão)",
    "Europa (Paris)",
    "Europa (Estocolmo)",
    "Médio Oriente (Bahrain)",
    "América do Sul (São Paulo)"
  ])
end

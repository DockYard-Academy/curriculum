defmodule Faker.Aws.Fr do
  import Faker, only: [sampler: 2]

  @moduledoc """
  Functions for generating AWS information in French
  """

  @doc """
  Returns a random region name available on AWS in French

  ## Examples
  iex> Faker.Aws.Fr.region_name()
  "Asie Pacifique (Tokyo)"
  iex> Faker.Aws.Fr.region_name()
  "USA Est (Ohio)"
  iex> Faker.Aws.Fr.region_name()
  "Europe (Milan)"
  iex> Faker.Aws.Fr.region_name()
  "Afrique (Le Cap)"
  """
  @spec region_name() :: String.t()
  sampler(:region_name, [
    "USA Est (Virginie du Nord)",
    "USA Est (Ohio)",
    "USA Ouest (Californie du Nord)",
    "USA Ouest (Oregon)",
    "Afrique (Le Cap)",
    "Asie Pacifique (Hong Kong)",
    "Asie Pacifique (Mumbai)",
    "Asie Pacifique (Seoul)",
    "Asie Pacifique (Singapore)",
    "Asie Pacifique (Sydney)",
    "Asie Pacifique (Tokyo)",
    "Canada (Central)",
    "Europe (Frankfurt)",
    "Europe (Ireland)",
    "Europe (London)",
    "Europe (Milan)",
    "Europe (Paris)",
    "Europe (Stockholm)",
    "Moyen-Orient (Bahreïn)",
    "Amérique du Sud (São Paulo)"
  ])
end

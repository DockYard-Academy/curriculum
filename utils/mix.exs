defmodule Utils.MixProject do
  use Mix.Project

  def project do
    [
      app: :utils,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Utils.Application, []}
    ]
  end
game = %{team1_name: "Team Team", team2_name: "Exersport", round1: %{team1: 10, team2: 20}, round2: %{team1: 30, team2: 10}, round3: %{team1: 25, team2: 30}}
  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", runtime: false, only: [:dev, :test]},
      {:livebook_formatter, "~> 0.1.2", runtime: false},
      {:jason, "~> 1.4"}
    ]
  end
end

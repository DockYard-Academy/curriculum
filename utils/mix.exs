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

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:kino, github: "livebook-dev/kino", override: true},
      {:livebook, "~> 0.6.3", runtime: false},
      {:poison, "~> 5.0"},
      {:kino_lab, "~> 0.1.0-dev", github: "jonatanklosko/kino_lab"},
      {:vega_lite, "~> 0.1.4"},
      {:kino_vega_lite, "~> 0.1.1"},
      {:benchee, "~> 0.1"},
      {:ecto, "~> 3.7"},
      {:math, "~> 0.7.0"},
      {:faker, "~> 0.17.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end
end

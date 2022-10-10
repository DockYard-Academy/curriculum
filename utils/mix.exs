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
      {:kino, "~> 0.6.2"},
      {:vega_lite, "~> 0.1.6"},
      {:kino_vega_lite, "~> 0.1.3"},
      {:faker, "~> 0.17.0"},
      {:earmark_parser, "~> 1.4", only: [:dev, :test]},
      {:credo, "~> 1.6", runtime: false, only: [:dev, :test]},
      {:livebook, "~> 0.7", runtime: false, only: [:dev, :test]},
      {:poison, "~> 5.0", only: [:dev, :test]}
      # poison needed for livebook
    ]
  end
end

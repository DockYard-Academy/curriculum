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
      {:credo, "~> 1.6", runtime: false, only: [:dev, :test]},
      {:livebook, "~> 0.7", runtime: false, only: [:dev, :test]},
      # poison needed for livebook
      {:poison, "~> 5.0", only: [:dev, :test]}
    ]
  end
end

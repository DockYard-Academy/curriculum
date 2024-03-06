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

  defp deps do
    [
      {:credo, "~> 1.7", runtime: false, only: [:dev, :test]},
      {:livebook_formatter, "~> 0.1.2", runtime: false},
      {:livebook, "~> 0.12.1"},
      {:jason, "~> 1.4"}
    ]
  end
end

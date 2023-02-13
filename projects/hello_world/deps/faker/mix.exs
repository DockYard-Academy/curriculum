defmodule Faker.Mixfile do
  use Mix.Project

  @source_url "https://github.com/elixirs/faker"
  @version "0.17.0"

  def project do
    [
      app: :faker,
      version: @version,
      elixir: "~> 1.6",
      description: "Faker is a pure Elixir library for generating fake data.",
      package: package(),
      name: "Faker",
      deps: deps(),
      docs: docs(),
      dialyzer: [
        flags: [
          :error_handling,
          :race_conditions,
          :underspecs
        ]
      ]
    ]
  end

  def application do
    [
      applications: [:crypto],
      env: env()
    ]
  end

  defp env do
    [
      locale: :en,
      country: nil,
      random_module: Faker.Random.Elixir
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:earmark, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["CHANGELOG.md", "README.md"],
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      source_url: @source_url,
      source_ref: "v#{@version}"
    ]
  end

  defp package do
    %{
      maintainers: ["Anthony Smith", "Igor Kapkov", "Toby Hinloopen", "Vitor Oliveira"],
      files: ["lib", "mix.exs", "mix.lock", "README.md", "LICENSE", "CHANGELOG.md"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    }
  end
end

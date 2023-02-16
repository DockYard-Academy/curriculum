defmodule Mix.Tasks.Bc.Autolink do
  @moduledoc """
  Autolink backtick function like `Enum.map/2` to HexDocs, like
  [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2).
  """

  @shortdoc "Autolink Elixir functions to HexDocs."

  use Mix.Task

  alias Utils.Notebooks

  @libraries [
    "Kino",
    "ExUnit",
    "Benchee",
    "IEx",
    "Mix",
    "Poison",
    "HTTPoison",
    "Timex",
    "Ecto",
    "Phoenix"
  ]

  @impl Mix.Task
  def run(_) do
    Notebooks.all_livebooks()
    |> Enum.map(fn file_name ->
      file = File.read!(file_name)
      livebook_link_regex = ~r/\`([A-Z]\w+)\`|\`(\w+)\.(\w+!*\?*)\/([1-9])\`/

      file =
        Regex.replace(livebook_link_regex, file, fn
          full, module, "", "", "" ->
            if is_documented_module?(module) do
              doc_link = doc_link_from_module(module)

              "[#{module}](https://hexdocs.pm/#{doc_link}/#{module}.html)"
            else
              full
            end

          full, _, module, function, arity ->
            if is_documented_module?(module) do
              doc_link = doc_link_from_module(module)

              "[#{module}.#{function}/#{arity}](https://hexdocs.pm/#{doc_link}/#{module}.html##{function}/#{arity})"
            else
              full
            end
        end)

      File.write!(file_name, file)
    end)
  end

  defp doc_link_from_module(module) do
    cond do
      module == "IEx" ->
        "iex"

      module == "HTTPoison" ->
        "httpoison"

      module in @libraries ->
        Regex.scan(~r/[A-Z][a-z]+/, module)
        |> Enum.map(fn [word] -> String.downcase(word) end)
        |> Enum.join("_")

      true ->
        "elixir"
    end
  end

  defp is_documented_module?(module) do
    case Code.ensure_compiled(String.to_atom("Elixir.#{module}")) do
      {:module, _} -> true
      _ -> module in @libraries
    end
  end
end

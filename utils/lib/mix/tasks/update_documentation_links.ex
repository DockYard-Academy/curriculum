defmodule Mix.Tasks.UpdateDocumentationLinks do
  @moduledoc "Replace backtick links such as `Enum.map/2` with links to documentation such as: [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)"
  alias Utils.Notebooks

  use Mix.Task
  @libraries ["Kino", "ExUnit", "Benchee", "IEx", "Mix", "Poison", "HTTPoison"]

  @impl Mix.Task
  def run(_) do
    Notebooks.all_livebooks()
    |> Enum.map(fn file_name ->
      file = File.read!(file_name)

      file =
        Regex.replace(~r/\`([A-Z]\w+)\`|\`(\w+)\.(\w+!*)\/([1-9])\`/, file, fn
          full, "Math", _, _, _ ->
            full

          full, _, "Math", _, _ ->
            full

          full, module, "", "", "" ->
            if Code.ensure_compiled?(String.to_atom("Elixir.#{module}")) or module in @libraries do
              doc_link = doc_link_from_module(module)

              "[#{module}](https://hexdocs.pm/#{doc_link}/#{module}.html)"
            else
              full
            end

          full, _, module, function, arity ->
            IO.inspect(function)
            if Code.ensure_compiled?(String.to_atom("Elixir.#{module}")) or module in @libraries do
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
        doc_link =
          Regex.scan(~r/[A-Z][a-z]+/, module)
          |> Enum.map(fn [word] -> String.downcase(word) end)
          |> Enum.join("_")

      true ->
        "elixir"
    end
  end
end

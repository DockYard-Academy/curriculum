defmodule Mix.Tasks.FormatNotebooks do
  @moduledoc "Format Livebook notebooks."
  @shortdoc @moduledoc

  use Mix.Task

  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    IO.puts("Running: mix format_notebooks")

    Notebooks.all_notebooks()
    |> Enum.each(fn notebook ->
      notebook
      |> Notebooks.load!()
      |> Notebooks.link_to_docs()
      |> Notebooks.format_headings()
      |> Notebooks.livebook_formatter()
      |> Notebooks.save()
    end)
  end
end

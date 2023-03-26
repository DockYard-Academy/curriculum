defmodule Mix.Tasks.AddFooter do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task
  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    IO.puts("Running: mix add_footer")
    Notebooks.outline_notebooks()
    |> Enum.each(fn notebook ->
      Notebooks.load(notebook)
      |> Notebooks.commit_your_progress_section()
      |> Notebooks.navigation_section()
      |> Notebooks.save()
    end)
  end
end

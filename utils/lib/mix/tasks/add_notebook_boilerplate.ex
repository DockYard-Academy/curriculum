defmodule Mix.Tasks.AddNotebookBoilerplate do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task
  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    IO.puts("Running: mix add_notebook_boilerplate")

    Notebooks.outline_notebooks()
    |> Enum.each(fn notebook ->
      notebook
      |> Notebooks.load!()
      # as we no longer have setup sections this is not needed.
      |> Notebooks.remove_setup_section()
      |> Notebooks.header_navigation_section()
      |> Notebooks.commit_your_progress_section()
      |> Notebooks.footer_navigation_section()
      |> Notebooks.save()
    end)
  end
end

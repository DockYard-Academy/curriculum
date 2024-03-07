defmodule Mix.Tasks.AllTasks do
  @moduledoc "Run all Mix tasks."
  @shortdoc @moduledoc

  use Mix.Task

  @requirements [
    "compile --force",
    "format",
    "spell_check"
  ]

  alias Utils.Notebooks.Tasks
  alias Utils.Notebooks.Notebook

  @impl true
  def run(args) do
    IO.puts("Running: mix build_notebook_release")

    root_notebook =
      args
      |> Enum.fetch!(0)
      |> then(fn x -> [full_path: x] end)
      |> Notebook.new!()
      |> Notebook.load_outline_notebooks()

    root_notebook
    |> Tasks.add_notebook_boilerplate()
    |> Tasks.update_deps()
    |> Tasks.update_readme_outline()
    |> Tasks.set_release_links()
    |> Tasks.save_release()

    IO.puts("Finished All Tasks")
  end
end

defmodule Mix.Tasks.AllTasks do
  @moduledoc "Run all Mix tasks."
  @shortdoc @moduledoc

  use Mix.Task

  @requirements [
    "deprecate_unused_files",
    "add_notebook_boilerplate",
    "format_notebooks",
    "update_readme_outline"
  ]

  @impl true
  def run(_) do
    # runs tasks in requirements, then prints:
    IO.puts("Finished All Tasks")
  end
end

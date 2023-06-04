defmodule Mix.Tasks.AllTasks do
  @moduledoc "Run all Mix tasks."
  @shortdoc @moduledoc

  use Mix.Task

  @requirements [
    "compile --force",
    "add_notebook_boilerplate",
    "update_deps",
    "format_notebooks",
    "update_readme_outline",
    "deprecate_unused_files",
    "format",
    "spell_check"
  ]

  @impl true
  def run(_) do
    # runs tasks in requirements, then prints:
    IO.puts("Finished All Tasks")
  end
end

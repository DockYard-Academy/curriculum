defmodule Mix.Tasks.Bc do
  @moduledoc "List all Beta Curriculum Mix tasks."
  @shortdoc @moduledoc

  use Mix.Task

  @impl true
  def run(_) do
    # Tasks are built with the assumption of run order based on the file name.
    # For example, the add_git_section task must run before the add_navigation script
    tasks =
      :code.all_available()
      |> Enum.filter(&task?/1)
      |> Enum.map(&shortdoc/1)
      |> List.keysort(0)

    max =
      Enum.reduce(tasks, 0, fn {task, _}, acc ->
        max(String.length(task), acc)
      end)

    for {task, shortdoc} <- tasks do
      msg = "mix #{String.pad_trailing(task, max)} # #{shortdoc}"
      Mix.shell().info(msg)
      Mix.Task.run(task)
    end

    # Spelling Check
    System.cmd("codespell", ["--skip=./utils/deps/*,./.git/*,./utils/lib/assets/*", "-w"],
      cd: "../"
    )
  end

  defp task?({name, _, _}) do
    String.starts_with?(to_string(name), "Elixir.Mix.Tasks.Bc.")
  end

  defp shortdoc({name, _, _}) do
    mod = List.to_atom(name)
    {Mix.Task.task_name(mod), Mix.Task.shortdoc(mod)}
  end
end

defmodule Mix.Tasks.UpdateDeps do
  @moduledoc "Format Livebook notebooks."
  @shortdoc @moduledoc

  use Mix.Task

  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    IO.puts("Running: mix update_deps")

    Notebooks.all_notebooks()
    |> Enum.each(fn notebook ->
      notebook
      |> Notebooks.load!()
      |> Notebooks.update_dependencies()
      |> Notebooks.save()
    end)
  end
end

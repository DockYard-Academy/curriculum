defmodule Mix.Tasks.DeprecateUnusedFiles do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task
  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    Notebooks.unused_notebooks()
    |> Enum.each(fn notebook ->
      Notebooks.deprecate(notebook)
    end)
  end
end

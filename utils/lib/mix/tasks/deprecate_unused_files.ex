defmodule Mix.Tasks.Bc.DeprecateUnusedFiles do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    outline = File.read!("../start.livemd")

    all_paths = Path.wildcard("../*/*.livemd")
    ignored_paths = Path.wildcard("../*/_*.livemd")
    deprecated_paths = Path.wildcard("../*/deprecated*.livemd")

    outline_paths =
      Regex.scan(~r/\[[^\]]+\]\(([^\)]+\.livemd)\)/, outline)
      |> Enum.map(fn [_, file_name] ->
        Path.join("../", file_name)
      end)

    remaining_paths = all_paths -- ignored_paths
    remaining_paths = remaining_paths -- deprecated_paths
    remaining_paths = remaining_paths -- outline_paths

    Enum.each(remaining_paths, fn path ->
      basename = Path.basename(path)
      dirname = Path.dirname(path)

      deprecated_path = Path.join(dirname, "deprecated_" <> basename)
      File.cp!(path, deprecated_path)
      File.rm!(path)
    end)
  end
end

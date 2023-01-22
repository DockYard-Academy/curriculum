defmodule Mix.Tasks.Bc.AddNavigation do
  @moduledoc "Add Previous/Next navigation link to reading pages."
  @shortdoc @moduledoc

  use Mix.Task
  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    outline = File.read!("../start.livemd")
    navigation_blocks = Notebooks.navigation_blocks(outline)

    Regex.scan(~r/reading\/\w+.livemd|exercises\/\w+.livemd/, outline)
    |> List.flatten()
    |> Enum.each(fn file_name ->
      path = Path.join("../", file_name)
      file = File.read!(path)
      file_with_navigation_removed = Regex.replace(~r/\#\# Up Next(.|\n)+/, file, "")
      File.write!(path, file_with_navigation_removed)
      content = Notebooks.navigation(navigation_blocks, file_name)
      File.write!(path, "\n#{content}", [:append])
    end)
  end
end

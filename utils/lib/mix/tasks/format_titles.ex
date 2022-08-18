defmodule Mix.Tasks.FormatTitles do
  @moduledoc "The format titles mix task: `mix help format_titles`"
  @shortdoc "Formats Live Markdown Heading Titles"

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    base_path = Path.expand("../")

    livemd_files = Path.wildcard(base_path <> "*.livemd")

    Enum.each(livemd_files, fn file_name ->
      file = File.read!(file_name)

      updated_file =
        Regex.replace(~r/(\#\#\s)(.+)/, file, fn _, heading_tag, heading ->
          capitalized_heading =
            String.split(heading)
            |> Enum.map(&String.capitalize/1)
            |> Enum.join(" ")

          heading_tag <> capitalized_heading
        end)

      # File.write!(file_name, updated_file)
    end)
  end
end

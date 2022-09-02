defmodule Mix.Tasks.UpdateReadmeOutline do
  @moduledoc "The update readme outline mix task: `mix help update_readme_outline`"
  @shortdoc "Updates the README with course outline from start.livemd file"

  use Mix.Task

  @root_path Path.expand("../")
  @readme_path Path.join([@root_path, "README.md"])
  @course_outline_path Path.join([@root_path, "start.livemd"])
  @outline_start_comment "<!-- course-outline-start -->"
  @outline_end_comment "<!-- course-outline-end -->"
  @h2_regex ~r/^##\s/
  @h3_regex ~r/^###\s/

  def split_readme do
    content =
      @readme_path
      |> File.read!()

    beginning_content =
      content
      |> String.split(@outline_start_comment, trim: true)
      |> List.first()

    ending_content =
      content
      |> String.split(@outline_end_comment, trim: true)
      |> List.last()

    %{
      beginning: beginning_content <> @outline_start_comment <> "\n",
      ending: "\n" <> @outline_end_comment <> ending_content
    }
  end

  def get_course_outline do
    @course_outline_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(fn line ->
      (Regex.match?(@h2_regex, line) && String.contains?(String.downcase(line), "week")) ||
        Regex.match?(@h3_regex, line)
    end)
    |> Enum.map_join("\n", fn line ->
      if Regex.match?(@h2_regex, line) do
        "\n" <> line <> "\n"
      else
        Regex.replace(@h3_regex, line, "")
      end
    end)
  end

  def run(_args) do
    %{beginning: beginning, ending: ending} = split_readme()
    course_outline = get_course_outline()
    updated_readme = beginning <> course_outline <> ending
    File.write!(@readme_path, updated_readme)
  end
end

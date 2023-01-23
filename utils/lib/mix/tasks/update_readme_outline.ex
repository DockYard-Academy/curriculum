defmodule Mix.Tasks.Bc.UpdateReadmeOutline do
  @moduledoc "Update outline for README.md."
  @shortdoc @moduledoc

  use Mix.Task

  @root_path Path.expand("../")
  @readme_path Path.join([@root_path, "README.md"])
  @course_outline_path Path.join([@root_path, "start.livemd"])
  @outline_start_comment "<!-- course-outline-start -->"
  @outline_end_comment "<!-- course-outline-end -->"
  @ignored_sections ["## Overview", "### Welcome"]

  def run(_args) do
    course_outline = File.read!(@course_outline_path)
    readme = File.read!(@readme_path)
    [start, _outline, finish] = split_on_outline(readme)
    simplified_outline = sections(course_outline)

    File.write!(
      @readme_path,
      start <>
        @outline_start_comment <> "\n" <> simplified_outline <> @outline_end_comment <> finish
    )
  end

  @spec split_on_outline(String.t()) :: [String.t()]
  def split_on_outline(content) do
    String.split(content, ~r/(<!-- course-outline-start -->)|(<!-- course-outline-end -->)/,
      trim: true
    )
  end

  @spec sections(String.t()) :: String.t()
  def sections(outline) do
    Regex.scan(~r/(\#{2,3})(.+)/, outline)
    |> Enum.reject(fn [full, _, _] -> full in @ignored_sections end)
    |> Enum.map(fn
      [full, "##", _heading] -> full <> "\n"
      [_, "###", subheading] -> "*#{subheading}\n"
    end)
    |> Enum.join()
  end
end

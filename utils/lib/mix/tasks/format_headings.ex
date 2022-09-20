defmodule Mix.Tasks.Bc.FormatHeadings do
  @moduledoc "Format headings of Livebook notebooks."
  @shortdoc @moduledoc

  alias Utils.Notebooks

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)

      updated_file =
        Regex.replace(~r/(\#\#\s)(.+)/, file, fn _, heading_tag, heading ->
          heading_tag <> Notebooks.to_title_case(heading)
        end)

      File.write!(file_name, updated_file)
    end)
  end
end

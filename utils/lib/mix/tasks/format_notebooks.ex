defmodule Mix.Tasks.FormatNotebooks do
  @moduledoc "Formats Live Markdown Headings. Run: MIX_ENV=test mix format_notebooks"
  @shortdoc "Formats Live Markdown Notebooks According To Livebook Specification"
  alias Utils.Notebooks

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)
      # loading the file in livebook adds a newline, so we add it when we format
      # to avoid changing the file every time a student opens a .livemd file.
      new_file = Livebook.LiveMarkdown.MarkdownHelpers.reformat(file) <> "\n"
      File.write!(file_name, new_file)
    end)
  end
end

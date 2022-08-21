defmodule Mix.Tasks.FormatNotebooks do
  @moduledoc "Formats Live Markdown Headings. Run: mix format_notebooks"
  @shortdoc "Formats Live Markdown Notebooks According To Livebook Specification"
  alias Utils.Notebooks

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)
      new_file = Livebook.LiveMarkdown.MarkdownHelpers.reformat(file)
      File.write!(file_name, new_file)
    end)
  end
end

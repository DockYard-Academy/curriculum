defmodule Mix.Tasks.Bc.FormatNotebooks do
  @moduledoc "Format Livebook notebooks."
  @shortdoc @moduledoc

  use Mix.Task

  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)

      # loading the file in livebook adds a newline, so we add it when we format
      # to avoid changing the file every time a student opens a .livemd file.
      File.write(file_name, LivebookFormatter.reformat(file))
    end)
  end
end

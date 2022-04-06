defmodule Journal do
  @moduledoc """
  Documentation for `Journal`.
  """
  @default_folder "test_entries"
  @template_folder "templates"
  require Logger

  def main(["search" | args]) do
    options = [switches: [folder: :string]]
    {opts, args, _} = OptionParser.parse(args, options)

    folder = Keyword.get(opts, :folder, @default_folder)

    search_text = Enum.at(args, 0)
    files = File.ls!(folder)

    files |> filter_by_search(search_text) |> Logger.info()
  end

  def main(args) do
    options = [switches: [folder: :string, file: :string, title: :string, template: :string]]
    {opts, _, _} = OptionParser.parse(args, options)
    maybe_create_dir(opts)
    create_journal(opts)
  end

  def filter_by_search(files, search_text) do
    if search_text do
      Enum.filter(files, fn each -> String.contains?(each, search_text) end)
    else
      files
    end
  end

  def maybe_create_dir(opts) do
    folder = Keyword.get(opts, :folder, @default_folder)

    unless File.dir?(folder) do
      File.mkdir!(folder)
    end
  end

  def create_journal(opts) do
    if File.exists?(file_path(opts)) do
      Logger.warning(
        "Error, daily journal already exists. Open #{file_path(opts)} to see todays journal."
      )
    else
      File.write!(file_path(opts), journal_content(opts))
    end
  end

  @doc ~S"""
  Generates the file path.

  ## Examples

    iex> Journal.file_path([file: "file_name"])
    "test_entries/file_name.md"
  """
  def file_path(opts) do
    folder = Keyword.get(opts, :folder, @default_folder)
    "#{folder}/#{file_name(opts)}"
  end

  @doc ~S"""
  Generates journal content based on the default daily content,
  Or a template.

  ## Examples

    iex> Journal.journal_content([title: "My Title"])
    "# My Title"
  """
  def journal_content(opts) do
    template_content(opts) || default_content(opts)
  end

  defp default_content(opts) do
    "# #{title(opts)}"
  end

  defp template_content(opts) do
    template = Keyword.get(opts, :template)

    if template do
      content = File.read!("#{@template_folder}/#{template}.md")
      String.replace(content, "{DATE}", date()) |> String.replace("{TITLE}", title(opts))
    end
  end

  @doc ~S"""
  Generate the file name without extension.

  ## Examples

    iex> Journal.title([title: "my_example"])
    "my_example"
  """
  def title(opts) do
    Keyword.get(opts, :title, date())
  end

  def date do
    Calendar.strftime(Date.utc_today(), "%y-%m-%d")
  end

  @doc ~S"""
  Generate the file name with .md extension.

  ## Examples

    iex> Journal.file_name([file: "my_example"])
    "my_example.md"
  """
  def file_name(opts) do
    Keyword.get(opts, :file, date()) <> ".md"
  end
end

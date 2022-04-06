defmodule Journal do
  @moduledoc """
  Documentation for `Journal`.
  """
  @default_folder "test_entries"
  @template_folder "templates"
  require Logger

  def main(["search" | args]) do
    options = [switches: [folder: :string, tags: :string]]
    {opts, args, _} = OptionParser.parse(args, options)

    folder = Keyword.get(opts, :folder, @default_folder)
    tags = Keyword.get(opts, :tags)

    search = Enum.at(args, 0)
    files = File.ls!(folder)

    files |> filter_by_search(search) |> Logger.info()
  end

  def main(args) do
    options = [switches: [folder: :string, title: :string, template: :string, tags: :string]]
    {opts, _, _} = OptionParser.parse(args, options)
    maybe_create_dir(opts)
    create_journal(opts)
  end

  def filter_by_search(files, search) do
    if search do
      Enum.filter(files, fn each -> String.contains?(each, search) end)
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

  def file_path(opts) do
    folder = Keyword.get(opts, :folder, @default_folder)
    "#{folder}/#{file_name(opts)}"
  end

  def journal_content(opts) do
    template = Keyword.get(opts, :template)
    tags = Keyword.get(opts, :tags)

    body =
      if template do
        File.read!("#{@template_folder}/#{template}.md")
      else
        "# #{title(opts)}"
      end

    if tags do
      tag_list = String.split(tags, ",") |> Enum.join(" ")
      head = "---\ntags: ~w(#{tag_list})\n---"
      head <> body
    else
      body
    end
  end

  def title(opts) do
    Keyword.get(opts, :title, Calendar.strftime(Date.utc_today(), "%y-%m-%d"))
  end

  def file_name(opts) do
    title(opts) <> ".md"
  end
end

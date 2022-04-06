defmodule JournalTest do
  use ExUnit.Case
  doctest Journal

  import ExUnit.CaptureLog
  require Logger

  @folder "test_entries"
  @date Calendar.strftime(Date.utc_today(), "%y-%m-%d")
  @file_name @date <> ".md"
  @file_path "#{@folder}/#{@file_name}"
  @file_content "# #{@date}"
  @switched_folder "switched_folder"
  @template_file "templates/example_template.md"
  @template_name "example_template"

  setup do
    on_exit(fn -> File.rm_rf(@folder) end)
    on_exit(fn -> File.rm_rf(@switched_folder) end)
    on_exit(fn -> File.rm_rf(@template_file) end)
  end

  def create_test_template(template_content \\ "# Example Template\n my example template") do
    File.mkdir("templates")
    File.write!(@template_file, template_content)
    template_content
  end

  test "main/1 creates a daily journal" do
    Journal.main([])
    assert {:ok, content} = File.read(@file_path)
    assert content == @file_content
  end

  test "main/1 create daily journal twice prints error" do
    Journal.main([])

    assert capture_log(fn ->
             Journal.main([])
           end) =~
             "Error, daily journal already exists. Open #{@file_path} to see todays journal."
  end

  test "main/1 creates a daily journal with the --folder switch" do
    Journal.main(["--folder", @switched_folder])
    title = Calendar.strftime(Date.utc_today(), "%y-%m-%d")
    file_name = title <> ".md"
    assert {:ok, content} = File.read("#{@switched_folder}/#{file_name}")
    assert content == "# #{title}"
  end

  test "main/1 creates a daily journal with the --file switch" do
    Journal.main(["--file", "file_name"])
    file_name = "file_name.md"
    assert {:ok, content} = File.read("#{@folder}/#{file_name}")
    assert content == "# #{@date}"
  end

  test "main/1 creates a daily journal with the --title switch" do
    Journal.main(["--title", "example_title"])
    assert {:ok, content} = File.read(@file_path)
    assert content == "# example_title"
  end

  test "main/1 creates a template journal with the --template switch" do
    template_content = create_test_template()

    Journal.main(["--template", "example_template"])

    assert {:ok, content} = File.read(@file_path)
    assert content == template_content
  end

  test "main/1 creates a journal with the --title, --template, --file, and --folder switch" do
    template_content = create_test_template()

    Journal.main([
      "--title",
      "example_title",
      "--template",
      @template_name,
      "--folder",
      @switched_folder,
      "--file",
      "file_name"
    ])

    assert {:ok, content} = File.read("#{@switched_folder}/file_name.md")
    assert content == template_content
  end

  test "main/1 creates a journal with the --template switch with custom values" do
    create_test_template("# {TITLE}\nCreated on {DATE}")

    Journal.main([
      "--title",
      "example_title",
      "--template",
      @template_name
    ])

    file_name = "example_title.md"
    assert {:ok, content} = File.read(@file_path)
    assert content == "# example_title\nCreated on #{@date}"
  end

  test "main/1 search command finds files including the search text" do
    Journal.main(["--file", "example"])
    Journal.main(["--file", "non-matching"])

    log = capture_log(fn -> Journal.main(["search", "example"]) end)

    assert log =~ "example.md"
    refute log =~ "non-matching.md"
  end

  test "main/1 search command finds all files when no search text provided" do
    Journal.main(["--file", "example"])

    assert capture_log(fn ->
             Journal.main(["search"])
           end) =~
             "example.md"
  end
end

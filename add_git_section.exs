defmodule AddGitSection do
  @ignore_reading_files [
    "code_editors.livemd",
    "command_line.livemd",
    "git.livemd",
    "livebook.livemd"
  ]
  @ignore_exercise_files [
    "command_line_family_tree.livemd",
    "github_collab.livemd",
    "github_engineering_journal.livemd",
    "livebook_recovery.livemd"
  ]

  defp get_paths do
    base_path = File.cwd!()

    reading_files =
      Path.wildcard(base_path <> "/reading/*.livemd")
      |> Enum.filter(fn path ->
        Path.basename(path) not in @ignore_reading_files
      end)

    exercise_files =
      Path.wildcard(base_path <> "/exercises/*.livemd")
      |> Enum.filter(fn path ->
        Path.basename(path) not in @ignore_exercise_files
      end)

    %{reading: reading_files, exercise: exercise_files}
  end

  defp commit_snippet(commit_message \\ "") do
    """

    ## Commit Your Progress

    Run the following in your command line from the project folder to track and save your progress in a Git commit.

    ```
    $ git add .
    $ git commit -m "#{commit_message}"
    ```
    """
  end

  defp add_git_section_to_file(path, commit_message) do
    file = File.open!(path, [:append])
    IO.binwrite(file, commit_snippet(commit_message))
    File.close(file)
  end

  defp spaced_filename(path) do
    Path.basename(path) |> String.slice(0..-8) |> String.replace("_", " ")
  end

  def run do
    %{reading: reading, exercise: exercise} = get_paths()

    Enum.map(reading, fn path ->
      add_git_section_to_file(path, "finish #{spaced_filename(path)} section")
    end)

    Enum.map(exercise, fn path ->
      add_git_section_to_file(path, "finish #{spaced_filename(path)} exercise")
    end)
  end
end

AddGitSection.run()

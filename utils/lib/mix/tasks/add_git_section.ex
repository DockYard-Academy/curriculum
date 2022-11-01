defmodule Mix.Tasks.Bc.AddGitSection do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task

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

  @impl Mix.Task
  def run(_) do
    %{reading: reading, exercise: exercise} = get_paths()

    Enum.each(reading, fn path ->
      add_git_section_to_file(path, "finish #{spaced_filename(path)} section")
    end)

    Enum.each(exercise, fn path ->
      add_git_section_to_file(path, "finish #{spaced_filename(path)} exercise")
    end)
  end

  defp get_paths do
    base_path = Path.expand("../")

    reading_files =
      Path.wildcard(base_path <> "/reading/*.livemd")
      |> Enum.filter(fn path ->
        Path.basename(path) not in @ignore_reading_files && !deprecated_file?(path)
      end)

    exercise_files =
      Path.wildcard(base_path <> "/exercises/*.livemd")
      |> Enum.filter(fn path ->
        Path.basename(path) not in @ignore_exercise_files && !deprecated_file?(path)
      end)

    %{reading: reading_files, exercise: exercise_files}
  end

  defp commit_snippet(exercise_name, commit_message) do
    """

    ## Commit Your Progress

    Run the following in your command line from the beta_curriculum folder to track and save your progress in a Git commit.
    Ensure that you do not already have undesired or unrelated changes by running `git status` or by checking the source control tab in Visual Studio Code.

    ```
    $ git checkout main
    $ git checkout -b exercise-#{exercise_name}
    $ git add .
    $ git commit -m "#{commit_message}"
    $ git push origin exercise-#{exercise_name}
    ```

    Then create a pull request to your `main` branch and notify your teacher by including `@BrooklinJazz` in your PR description to get feedback.
    """
  end

  defp deprecated_file?(path) do
    String.contains?(path, "DEPRECATED")
  end

  defp add_git_section_to_file(path, commit_message) do
    file = File.read!(path)

    if String.contains?(file, "## Commit Your") do
      new_file =
        Regex.replace(
          # Commit Your Progress are always at the end for now.
          # If this changed, we could use a negative lookahead instead.
          ~r/\n\#\# Commit Your(.|\n)+/,
          file,
          commit_snippet(exercise_name(path), commit_message)
        )

      File.write!(path, new_file)
    else
      File.write!(path, commit_snippet(path, commit_message), [:append])
    end
  end

  defp exercise_name(path) do
    Path.basename(path) |> String.slice(0..-8)
  end

  defp spaced_filename(path) do
    Path.basename(path) |> String.slice(0..-8) |> String.replace("_", " ")
  end
end

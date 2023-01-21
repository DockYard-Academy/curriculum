defmodule Mix.Tasks.Bc.AddGitSection do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    base_path = Path.expand("../")
    reading = Path.wildcard(base_path <> "/reading/*.livemd")
    exercises = Path.wildcard(base_path <> "/exercises/*.livemd")

    Enum.each(reading, fn path ->
      add_git_section_to_file(path, :reading)
    end)

    Enum.each(exercises, fn path ->
      add_git_section_to_file(path, :exercise)
    end)
  end

  defp commit_snippet(file_name, type) do
    """

    ## Mark As Completed

    <!-- livebook:{"attrs":{"source":"[_, file_name] = Regex.run(~r/([^\\\\\\\\\/]+).livemd/, __ENV__.file)\\nprogress_path = __DIR__ <> \\"/../student_progress.json\\"\\nexisting_progress = File.read!(progress_path) |> Jason.decode!()\\n\\ndefault = Map.get(existing_progress, file_name, false)\\n\\nform =\\n  Kino.Control.form(\\n    [\\n      completed: input = Kino.Input.checkbox(\\"Mark As Completed\\", default: default)\\n    ],\\n    report_changes: true\\n  )\\n\\nTask.async(fn ->\\n  for %{data: %{completed: completed}} <- Kino.Control.stream(form) do\\n    File.write!(progress_path, Jason.encode!(Map.put(existing_progress, file_name, completed)))\\n  end\\nend)\\n\\nform","title":"Track Your Progress"},"chunks":null,"kind":"Elixir.HiddenCell","livebook_object":"smart_cell"} -->

    ```elixir
    [_, file_name] = Regex.run(~r/([^\\\\\\\\\/]+).livemd/, __ENV__.file)
    progress_path = __DIR__ <> "/../student_progress.json"
    existing_progress = File.read!(progress_path) |> Jason.decode!()

    default = Map.get(existing_progress, file_name <> \"_#{type}\", false)

    form =
      Kino.Control.form(
        [
          completed: input = Kino.Input.checkbox("Mark As Completed", default: default)
        ],
        report_changes: true
      )

    Task.async(fn ->
      for %{data: %{completed: completed}} <- Kino.Control.stream(form) do
        File.write!(progress_path, Jason.encode!(Map.put(existing_progress, file_name, completed)))
      end
    end)

    form
    ```

    ## Commit Your Progress

    Run the following in your command line from the curriculum folder to track and save your progress in a Git commit.
    Ensure that you do not already have undesired or unrelated changes by running `git status` or by checking the source control tab in Visual Studio Code.

    ```
    $ git checkout solutions
    $ git checkout -b #{String.replace(file_name, "_", "-")}-#{type}
    $ git add .
    $ git commit -m "finish #{String.replace(file_name, "_", " ")} #{type}"
    $ git push origin #{String.replace(file_name, "_", "-")}-#{type}
    ```

    Create a pull request from your `#{String.replace(file_name, "_", "-")}-#{type}` branch to your `solutions` branch.
    Please do not create a pull request to the DockYard Academy repository as this will spam our PR tracker.

    **DockYard Academy Students Only:**

    Notify your teacher by including `@BrooklinJazz` in your PR description to get feedback.
    You (or your teacher) may merge your PR into your solutions branch after review.

    If you are interested in joining the next academy cohort, [sign up here](https://academy.dockyard.com/) to receive more news when it is available.
    """
  end

  defp deprecated_file?(path) do
    String.contains?(path, "DEPRECATED")
  end

  defp add_git_section_to_file(path, type) do
    file = File.read!(path)

    if String.contains?(file, "## Mark As Complete") do
      new_file =
        Regex.replace(
          # Commit Your Progress are always at the end for now.
          # If this changed, we could use a negative lookahead instead.
          ~r/\n\#\# Mark As Complete(.|\n)+/,
          file,
          commit_snippet(Path.basename(path, ".livemd"), type)
        )

      File.write!(path, new_file)
    else
      File.write!(path, commit_snippet(path, type), [:append])
    end
  end
end

defmodule Mix.Tasks.Bc.AddGitSection do
  @moduledoc "Add Git section to selected pages."
  @shortdoc @moduledoc

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    outline = File.read!("../start.livemd")

    Regex.scan(~r/(reading|exercise)s*\/([^\/]+).livemd/, outline)
    |> Enum.each(fn [basename, type, file_name] ->
      add_git_section_to_file(Path.join("../", basename), file_name, type)
    end)
  end

  defp commit_snippet(file_name, type) do
    """

    ## Mark As Completed

    <!-- livebook:{"attrs":{"source":"file_name = Path.basename(Regex.replace(~r/#.+/, __ENV__.file, \\"\\"), \\".livemd\\")\\n\\nsave_name =\\n  case Path.basename(__DIR__) do\\n    \\"reading\\" -> \\"#{file_name}_reading\\"\\n    \\"exercises\\" -> \\"#{file_name}_exercise\\"\\n  end\\n\\nprogress_path = __DIR__ <> \\"/../progress.json\\"\\nexisting_progress = File.read!(progress_path) |> Jason.decode!()\\n\\ndefault = Map.get(existing_progress, save_name, false)\\n\\nform =\\n  Kino.Control.form(\\n    [\\n      completed: input = Kino.Input.checkbox(\\"Mark As Completed\\", default: default)\\n    ],\\n    report_changes: true\\n  )\\n\\nTask.async(fn ->\\n  for %{data: %{completed: completed}} <- Kino.Control.stream(form) do\\n    File.write!(\\n      progress_path,\\n      Jason.encode!(Map.put(existing_progress, save_name, completed), pretty: true)\\n    )\\n  end\\nend)\\n\\nform","title":"Track Your Progress"},"chunks":null,"kind":"Elixir.HiddenCell","livebook_object":"smart_cell"} -->

    ```elixir
    file_name = Path.basename(Regex.replace(~r/#.+/, __ENV__.file, ""), ".livemd")

    save_name =
      case Path.basename(__DIR__) do
        "reading" -> "#{file_name}_reading"
        "exercises" -> "#{file_name}_exercise"
      end

    progress_path = __DIR__ <> "/../progress.json"
    existing_progress = File.read!(progress_path) |> Jason.decode!()

    default = Map.get(existing_progress, save_name, false)

    form =
      Kino.Control.form(
        [
          completed: input = Kino.Input.checkbox("Mark As Completed", default: default)
        ],
        report_changes: true
      )

    Task.async(fn ->
      for %{data: %{completed: completed}} <- Kino.Control.stream(form) do
        File.write!(
          progress_path,
          Jason.encode!(Map.put(existing_progress, save_name, completed), pretty: true)
        )
      end
    end)

    form
    ```

    ## Commit Your Progress

    Run the following in your command line from the curriculum folder to track and save your progress in a Git commit.
    Ensure that you do not already have undesired or unrelated changes by running `git status` or by checking the source control tab in Visual Studio Code.

    ```
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

  defp add_git_section_to_file(path, file_name, type) do
    file = File.read!(path)
    file_with_section_removed = Regex.replace(~r/\n\#\# Mark As Complete(.|\n)+/, file, "")
    File.write!(path, file_with_section_removed)
    File.write!(path, commit_snippet(file_name, type), [:append])
  end
end

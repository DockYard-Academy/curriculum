defmodule Mix.Tasks.Stats do
  @moduledoc "Display the stats such as the number of lessons and exercises in the course."
  @shortdoc @moduledoc

  use Mix.Task
  alias Utils.Notebooks

  @impl Mix.Task
  def run(_) do
    IO.puts("""
    Retrieving Stats...
    ===============================================
    """)

    lessons = Notebooks.lessons() |> Enum.count()
    exercises = Notebooks.exercises() |> Enum.count()
    unused = Notebooks.unused_notebooks() |> Enum.count()
    word_count = Notebooks.word_count()

    avg_count = round(word_count / (lessons + exercises))

    IO.puts("""
    Lessons:            #{lessons}
    Exercises:          #{exercises}
    Unused:             #{unused}
    Total Word Count:   #{word_count}
    Avg Word Count:     #{avg_count}
    """)
  end
end

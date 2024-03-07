defmodule Utils.Notebooks.Tasks do
  alias Utils.Notebooks.Notebook.Navigation
  alias Utils.Notebooks.Notebook

  @doc """
  Add Git section to selected pages
  """
  def add_notebook_boilerplate(root_notebook) do
    IO.puts("Running: mix add_notebook_boilerplate")

    root_notebook.outline_notebooks
    |> Enum.map(fn notebook ->
      notebook
      |> Notebook.remove_setup_section()
      |> Navigation.header_navigation_section(root_notebook.outline_notebooks)
      |> Notebook.commit_your_progress_section()
      |> Navigation.footer_navigation_section(root_notebook.outline_notebooks)
    end)
    |> then(fn outline_notebooks ->
      %Notebook{root_notebook | outline_notebooks: outline_notebooks}
    end)
  end

  def set_release_links(root_notebook) do
    IO.puts("Running: mix set_release_links")

    %Notebook{
      root_notebook
      | outline_notebooks:
          Enum.map(root_notebook.outline_notebooks, &Notebook.set_release_links/1)
    }
    |> Notebook.set_release_links()
  end

  def format_notebooks(root_notebook) do
    IO.puts("Running: mix format_notebooks")

    do_format = fn notebook ->
      notebook
      |> Notebook.link_to_docs()
      |> Notebook.format_headings()
      |> Notebook.format()
    end

    root_notebook.outline_notebooks
    |> Enum.map(do_format)
    |> then(fn outline_notebooks ->
      root_notebook
      |> do_format.()
      |> struct(outline_notebooks: outline_notebooks)
    end)
  end

  def update_deps(root_notebook) do
    IO.puts("Running: mix update_deps")

    root_notebook.outline_notebooks
    |> Enum.map(&Notebook.update_dependencies/1)
    |> then(fn outline_notebooks ->
      root_notebook
      |> Notebook.update_dependencies()
      |> struct(outline_notebooks: outline_notebooks)
    end)
  end

  def stats(root_notebook) do
    IO.puts("""
    Retrieving Stats...
    ===============================================
    """)

    lessons = root_notebook |> Notebook.lessons() |> Enum.count()
    exercises = root_notebook |> Notebook.exercises() |> Enum.count()
    word_count = root_notebook |> Notebook.word_count()

    avg_count = round(word_count / (lessons + exercises))

    IO.puts("""
    Lessons:            #{lessons}
    Exercises:          #{exercises}
    Total Word Count:   #{word_count}
    Avg Word Count:     #{avg_count}
    """)
  end

  @readme_path "livebooks/README.md"
  @ignored_sections ["## Overview", "### Welcome"]

  def update_readme_outline(root_notebook) do
    IO.puts("Running: mix update_readme_outline")

    readme = File.read!(@readme_path)
    outline = root_notebook.content

    content =
      Regex.replace(
        ~r/<!-- course-outline-start -->(?:.|\n)*<!-- course-outline-end -->/,
        readme,
        """
        <!-- course-outline-start -->
        #{outline_snippet(outline)}
        <!-- course-outline-end -->
        """
      )

    File.write!(@readme_path, content)

    root_notebook
  end

  def outline_snippet(outline) do
    Regex.scan(~r/(\#{2,3})(.+)/, outline)
    |> Enum.reject(fn [full, _, _] -> full in @ignored_sections end)
    |> Enum.map(fn
      [full, "##", _heading] -> full <> "\n"
      [_, "###", subheading] -> "*#{subheading}\n"
    end)
    |> Enum.join()
  end

  def save_release(root_notebook) do
    [root_notebook | root_notebook.outline_notebooks]
    |> Enum.each(&Notebook.save_release/1)
  end
end

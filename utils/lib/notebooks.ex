defmodule Utils.Notebooks do
  alias Utils.Notebooks.Notebook
  @minor_words ["and", "the", "in", "to", "of"]

  @outline_notebooks Regex.scan(
                       ~r/(?:reading|exercises)\/[^\/]+.livemd/,
                       File.read!("../start.livemd")
                     )
                     |> Enum.with_index()
                     |> Enum.map(fn {[path], index} ->
                       Notebook.new(%{
                         relative_path: Path.join("../", path),
                         index: index
                       })
                     end)

  def all_notebooks do
    ["../start.livemd" | Path.wildcard("../*/*.livemd")]
    |> Enum.map(fn relative_path ->
      Notebook.new(%{relative_path: relative_path})
    end)
  end

  def outline_notebooks do
    @outline_notebooks
  end

  def stream_lines(file_names, function) do
    arity = :erlang.fun_info(function)[:arity]

    Stream.each(file_names, fn file_name ->
      file_name
      |> File.stream!([], :line)
      |> Stream.with_index()
      |> Stream.map(fn {line, index} ->
        line_number = index + 1

        case arity do
          1 -> function.(line)
          2 -> function.(line, file_name)
          3 -> function.(line, file_name, line_number)
        end
      end)
      |> Stream.run()
    end)
    |> Stream.run()
  end

  def livebook_formatter(notebook) do
    formatted_content = LivebookFormatter.reformat(notebook.content)
    %Notebook{notebook | content: formatted_content}
  end

  def all_livebooks do
    reading() ++ exercises() ++ ["../start.livemd"]
  end

  def reading do
    fetch_livebooks("../reading/")
  end

  def exercises do
    fetch_livebooks("../exercises/")
    |> Enum.reject(&(Path.basename(&1) in exercises_exceptions()))
  end

  def exercises_exceptions do
    ["_template.livemd"]
  end

  defp fetch_livebooks(path) do
    File.ls!(path)
    |> Stream.filter(&String.ends_with?(&1, ".livemd"))
    |> Enum.map(&(path <> &1))
    |> Enum.reject(fn file_name -> String.contains?(String.downcase(file_name), "deprecated") end)
  end

  @doc """
  Capitalize first letter of string without downcasing rest of string.

    ## Examples

      iex> Utils.Notebooks.capitalize_first("hello")
      "Hello"

      iex> Utils.Notebooks.capitalize_first("genServer")
      "GenServer"
  """
  def capitalize_first(str) do
    {first, rest} = String.split_at(str, 1)
    String.capitalize(first) <> rest
  end

  @doc """
  Convert string to title case downcasing minor words and capitalizing first letter of major words.

    ## Examples

    iex> Utils.Notebooks.to_title_case("bottles of soda")
    "Bottles of Soda"

    iex> Utils.Notebooks.to_title_case("my_function/1")
    "my_function/1"

    iex> Utils.Notebooks.to_title_case(":atom")
    ":atom"

    iex> Utils.Notebooks.to_title_case("Bottles Of Soda")
    "Bottles of Soda"
  """
  def to_title_case(str) do
    String.split(str)
    |> Enum.with_index()
    |> Enum.map(fn
      {word, index} ->
        cond do
          String.contains?(word, "/") ->
            word

          index == 0 ->
            capitalize_first(word)

          String.downcase(word) in @minor_words ->
            String.downcase(word)

          true ->
            capitalize_first(word)
        end
    end)
    |> Enum.join(" ")
  end

  def navigation_blocks(outline) do
    files =
      Regex.scan(~r/\[([^\]]+)\]\((\w+\/[^\)]+\.livemd)\)/, outline)
      |> Enum.map(fn [_, lesson_name, file_name] ->
        {file_name, "[#{lesson_name}](../#{file_name})"}
      end)

    Enum.reduce(Enum.with_index(files), %{}, fn {{file_name, _}, index}, acc ->
      prev = index > 0 && Enum.at(files, index - 1)
      next = Enum.at(files, index + 1)

      Map.put(acc, file_name, %{
        prev: (prev && elem(prev, 1)) || "-",
        next: (next && elem(next, 1)) || "-"
      })
    end)
  end

  def load(notebook) do
    content = File.read!(notebook.relative_path)
    %Notebook{notebook | content: content}
  end

  def save(notebook) do
    File.write(notebook.relative_path, notebook.content)
  end

  def format_headings(notebook) do
    formatted_content = Regex.replace(~r/^#+.+$/m, notebook.content, &title_case/1)

    %Notebook{notebook | content: formatted_content}
  end

  def title_case(heading) do
    String.split(heading)
    |> Enum.map(&:string.titlecase/1)
    |> Enum.join(" ")
  end

  def remove_setup_section(notebook) do
    cleared_content =
      Regex.replace(
        ~r/## Setup\n(\n|.)+##/U,
        notebook.content,
        "##"
      )

    %Notebook{notebook | content: cleared_content}
  end

  def commit_your_progress_section(notebook) do
    # adds section to the end of the file.
    top_of_footer_expression = ~r/(## (:?Mark As Completed|Commit Your Progress)(\n|.)+)/

    cleared_content =
      Regex.replace(
        top_of_footer_expression,
        notebook.content,
        ""
      )

    content = cleared_content <> commit_your_progress_snippet(notebook)

    %Notebook{notebook | content: content}
  end

  def header_navigation_section(notebook) do
    content =
      Regex.replace(
        ~r/## (:?Up Next|Navigation)\n(\n|.)+(?=##)/U,
        notebook.content,
        navigation_snippet(notebook)
      )

    %Notebook{notebook | content: content}
  end

  def footer_navigation_section(notebook) do
    cleared_content =
      Regex.replace(
        ~r/## (:?Up Next|Navigation)(\n|.(?!#))+\z/,
        notebook.content,
        ""
      )

    content = cleared_content <> navigation_snippet(notebook)

    %Notebook{notebook | content: content}
  end

  def navigation_snippet(notebook) do
    prev_notebook = prev(notebook)
    next_notebook = next(notebook)

    prev_name = (prev_notebook && prev_notebook.title) || ""
    prev_relative_path = (prev_notebook && prev_notebook.relative_path) || ""
    next_name = (next_notebook && next_notebook.title) || ""
    next_relative_path = (next_notebook && next_notebook.relative_path) || ""

    # indenting results in Livebook misformatting the code.
    """
    ## Navigation

    <div style="display: flex; align-items: center; width: 100%; justify-content: space-between; font-size: 1rem; color: #61758a; background-color: #f0f5f9; height: 4rem; padding: 0 1rem; border-radius: 1rem;">
    <div style="display: flex;">
    <i class="ri-home-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="../start.livemd">Home</a>
    </div>
    <div style="display: flex;">
    <i class="ri-bug-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="https://github.com/DockYard-Academy/curriculum/issues/new?assignees=&labels=&template=issue.md&title=#{notebook.title}">Report An Issue</a>
    </div>
    <div style="display: flex;">
    <i #{unless prev_notebook, do: "style=\"display: none;\" "}class="ri-arrow-left-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="#{prev_relative_path}">#{prev_name}</a>
    </div>
    <div style="display: flex;">
    <a style="display: flex; color: #61758a; margin-right: 1rem;" href="#{next_relative_path}">#{next_name}</a>
    <i #{unless next_notebook, do: "style=\"display: none;\" "}class="ri-arrow-right-fill"></i>
    </div>
    </div>
    """
  end

  def prev(%{index: 0}), do: nil

  def prev(notebook) do
    Enum.at(outline_notebooks(), notebook.index - 1)
  end

  def next(notebook) when length(@outline_notebooks) == notebook.index + 1, do: nil

  def next(notebook) do
    Enum.at(outline_notebooks(), notebook.index + 1)
  end

  def commit_your_progress_snippet(notebook) do
    """
    ## Commit Your Progress

    DockYard Academy now recommends you use the latest [Release](https://github.com/DockYard-Academy/curriculum/releases) rather than forking or cloning our repository.

    Run `git status` to ensure there are no undesirable changes.
    Then run the following in your command line from the `curriculum` folder to commit your progress.
    ```
    $ git add .
    $ git commit -m "finish #{notebook.title} #{notebook.type}"
    $ git push
    ```

    We're proud to offer our open-source curriculum free of charge for anyone to learn from at their own pace.

    We also offer a paid course where you can learn from an instructor alongside a cohort of your peers.
    [Apply to the DockYard Academy June-August 2023 Cohort Now](https://docs.google.com/forms/d/1RwqHc1wUoY0jS440sBJHHl3gyQlw2xhz2Dt1ZbRaXEc/edit?ts=641e1aachttps://academy.dockyard.com/).
    """
  end
end

defmodule Utils.Notebooks do
  @moduledoc """
  Documentation for the Notebooks module.

  The Notebooks module contains functions for working with curriculum .livemd notebooks as Notebook structs.
  """
  alias Utils.Notebooks.Notebook
  require Logger

  @outline_relative_paths Regex.scan(
                            ~r/(?:reading|exercises)\/[^\/]+.livemd/,
                            File.read!("../start.livemd")
                          )
                          |> Enum.map(fn name -> Path.join("../", name) end)

  @outline_notebooks @outline_relative_paths
                     |> Enum.with_index()
                     |> Enum.map(fn {relative_path, index} ->
                       Notebook.new!(%{
                         relative_path: relative_path,
                         index: index
                       })
                     end)

  @unused_notebooks Path.wildcard("../*/*.livemd")
                    |> Kernel.--(@outline_relative_paths)
                    |> Enum.map(fn relative_path ->
                      Notebook.new!(%{relative_path: relative_path})
                    end)

  @all_notebooks [
    Notebook.new!(%{relative_path: "../start.livemd"}) | @unused_notebooks ++ @outline_notebooks
  ]

  @lessons Enum.filter(@outline_notebooks, fn each -> each.type == :reading end)

  @exercises Enum.filter(@outline_notebooks, fn each -> each.type == :exercise end)

  @number_of_notebooks length(@outline_notebooks)
  @notebook_boilerplate_word_count 245

  @notebook_dependencies [
    {:kino, "0.9"},
    {:benchee, "1.1"},
    {:poison, "5.0.0"},
    {:httpoison, "2.1.0"},
    {:finch, "0.16.0"},
    {:timex, "3.7.11"},
    {:ecto, "3.9.5"},
    {:jason, "1.4"},
    {:faker, "0.17.0"},
    {:vega_lite, "0.1.6"},
    {:kino_vega_lite, "0.1.8"},
    {:hackney, "1.18"},
    {:oban, "2.14"},
    {:kino_db, "0.2.1"},
    {:postgrex, "0.16.5"},
    {:poolboy, "1.5"}
    # dependencies without versions are not included
    # {:youtube, github: "brooklinjazz/youtube"},
    # {:hidden_cell, github: "brooklinjazz/hidden_cell"}
    # {:visual, github: "brooklinjazz/visual"},
    # {:smart_animation, github: "brooklinjazz/smart_animation"}
  ]

  @documented_libraries [
    Kino,
    ExUnit,
    Benchee,
    IEx,
    Mix,
    Poison,
    HTTPoison,
    Finch,
    Timex,
    Ecto,
    Phoenix.HTML,
    Phoenix,
    Credo,
    Dialyzer
  ]

  def all_notebooks, do: @all_notebooks
  def lessons, do: @lessons
  def exercises, do: @exercises
  def outline_notebooks, do: @outline_notebooks
  def unused_notebooks, do: @unused_notebooks
  def documented_libraries, do: @documented_libraries
  def notebook_dependencies, do: @notebook_dependencies

  def word_count do
    Enum.reduce(@outline_notebooks, 0, fn each, acc ->
      each = load!(each)

      count = String.split(each.content, " ") |> Enum.count()
      acc + count - @notebook_boilerplate_word_count
    end)
  end

  def livebook_formatter(notebook) do
    formatted_content = LivebookFormatter.reformat(notebook.content)
    %Notebook{notebook | content: formatted_content}
  end

  def deprecate(notebook) do
    case notebook.name do
      "deprecated_" <> _ ->
        :ignored

      "_template" <> _ ->
        :ignored

      _ ->
        deprecated_name =
          Path.join([
            Path.dirname(notebook.relative_path),
            "deprecated_" <> Path.basename(notebook.relative_path)
          ])

        File.rename(notebook.relative_path, deprecated_name)
        deprecated_name
    end
  end

  def update_dependencies(notebook) do
    content =
      Enum.reduce(notebook_dependencies(), notebook.content, fn {dependency, version}, acc ->
        Regex.replace(~r/#{dependency}, \"~> .+\"/, acc, "#{dependency}, \"~> #{version}\"")
      end)

    %Notebook{notebook | content: content}
  end

  def load!(notebook) do
    case File.read(notebook.relative_path) do
      {:ok, content} ->
        %Notebook{notebook | content: content}

      {:error, _} ->
        raise """
        #{notebook.relative_path} does not exist.
        Try running mix compile --force in the #{Mix.env()} environment to ensure the notebook has been compiled.
        """
    end
  end

  def save(notebook) do
    File.write(notebook.relative_path, notebook.content)
  end

  def link_to_docs(notebook) do
    %Notebook{
      notebook
      | content:
          notebook.content
          |> library_docs()
          |> built_in_module_docs()
    }
  end

  def format_headings(notebook) do
    # format first line
    formatted_content =
      String.replace(notebook.content, ~r/^.+/, &title_case/1)
      # format sub headings
      |> String.replace(~r/^\#{2,}+.+$/m, &title_case/1)

    %Notebook{notebook | content: formatted_content}
  end

  def title_case(heading) do
    String.split(heading)
    |> Enum.map_join(" ", fn
      "cURL" -> "cURL"
      word -> :string.titlecase(word)
    end)
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
    We will accept applications for the June-August 2023 cohort soon.
    """
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
    <i #{if prev_notebook == %{}, do: "style=\"display: none;\" "}class="ri-arrow-left-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="#{Map.get(prev_notebook, :relative_path, "")}">#{Map.get(prev_notebook, :title, "")}</a>
    </div>
    <div style="display: flex;">
    <a style="display: flex; color: #61758a; margin-right: 1rem;" href="#{Map.get(next_notebook, :relative_path, "")}">#{Map.get(next_notebook, :title, "")}</a>
    <i #{if next_notebook == %{}, do: "style=\"display: none;\" "}class="ri-arrow-right-fill"></i>
    </div>
    </div>
    """
  end

  defp prev(%{index: 0}), do: %{}

  defp prev(notebook) do
    Enum.at(outline_notebooks(), notebook.index - 1)
  end

  defp next(notebook) when @number_of_notebooks == notebook.index + 1, do: %{}

  defp next(notebook) do
    Enum.at(outline_notebooks(), notebook.index + 1)
  end

  defp built_in_module_docs(content) do
    Regex.replace(~r/`(\w+)`/, content, fn full, module_name ->
      module = String.to_atom("Elixir." <> module_name)

      if Code.ensure_loaded?(module) do
        "[#{module_name}](https://hexdocs.pm/elixir/#{module_name}.html)"
      else
        full
      end
    end)
  end

  defp library_docs(content) do
    Enum.reduce(
      @documented_libraries,
      content,
      fn module, acc ->
        "Elixir." <> module_name = to_string(module)

        content =
          Regex.replace(~r/`#{module_name}`/, acc, fn _ ->
            case module_name do
              "Dialyzer" ->
                "[Dialyzer](https://hexdocs.pm/dialyxir/readme.html)"

              _ ->
                "[#{module_name}](https://hexdocs.pm/#{module_url(module_name)}/#{module_name}.html)"
            end
          end)

        module_regex = ~r/
          \`                                   # backtick
          (#{module_name}(?:\.[A-Z]+[a-z]*)*)  # module name
          \.                                   # period
          (\w+)                                # function
          \/                                   # slash
          (\d)                                 # arity
          \`                                   # backtick
          /x

        Regex.replace(module_regex, content, fn _match, nested_module, function, arity ->
          "[#{nested_module}.#{function}/#{arity}](https://hexdocs.pm/#{module_url(module_name)}/#{nested_module}.html##{function}/#{arity})"
        end)
      end
    )
  end

  def module_url(module_name) do
    case module_name do
      "Phoenix.HTML" ->
        "phoenix_html"

      _ ->
        Regex.scan(~r/[A-Z]+[a-z]+/, module_name)
        |> List.flatten()
        |> Enum.map_join("_", &String.downcase/1)
    end
  end
end

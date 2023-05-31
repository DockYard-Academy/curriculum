defmodule Utils.NotebooksTest do
  use ExUnit.Case, async: false
  alias Utils.Notebooks
  alias Utils.Notebooks.Notebook
  doctest Utils.Notebooks

  test "commit_your_progress_snippet/1" do
    notebook = %Notebook{title: "My Notebook", type: :reading}

    assert Notebooks.commit_your_progress_snippet(notebook) == """
           ## Commit Your Progress

           DockYard Academy now recommends you use the latest [Release](https://github.com/DockYard-Academy/curriculum/releases) rather than forking or cloning our repository.

           Run `git status` to ensure there are no undesirable changes.
           Then run the following in your command line from the `curriculum` folder to commit your progress.
           ```
           $ git add .
           $ git commit -m "finish My Notebook reading"
           $ git push
           ```

           We're proud to offer our open-source curriculum free of charge for anyone to learn from at their own pace.

           We also offer a paid course where you can learn from an instructor alongside a cohort of your peers.
           We will accept applications for the June-August 2023 cohort soon.
           """
  end

  test "deprecate/1" do
    file_path = "../reading/unused_example.livemd"
    deprecated_file_path = "../reading/deprecated_unused_example.livemd"
    File.write(file_path, "## Title")

    Notebooks.deprecate(%Notebook{relative_path: file_path})

    assert File.exists?(deprecated_file_path)
    refute File.exists?(file_path)

    on_exit(fn ->
      File.rm(deprecated_file_path)
      File.rm(file_path)
    end)
  end

  test "format_headings/1" do
    notebook = %Notebook{
      content: """
      # my awesome heading is great

      ## capitalize minors words like and the in to of
      ### but do capitalize other words
      #### and the first word no matter what
      """
    }

    assert %Notebook{
             content: """
             # My Awesome Heading Is Great

             ## Capitalize Minors Words Like And The In To Of
             ### But Do Capitalize Other Words
             #### And The First Word No Matter What
             """
           } = Notebooks.format_headings(notebook)
  end

  test "link_to_docs/1" do
    notebook = %Notebook{
      content: """
      `ExUnit`
      `Kino`
      `Benchee`
      `IEx`
      `Mix`
      `Poison`
      `HTTPoison`
      `Finch`
      `Timex`
      `Ecto`
      `Phoenix`
      `ExUnit.run/1`
      `Phoenix.Flash.get_flash/2`
      `Phoenix.HTML.Form.checkbox/3`
      `GenServer`
      `Credo`
      `Dialyzer`
      `Ignore`
      `Ignore This`
      """
    }

    assert Notebooks.link_to_docs(notebook).content == """
           [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html)
           [Kino](https://hexdocs.pm/kino/Kino.html)
           [Benchee](https://hexdocs.pm/benchee/Benchee.html)
           [IEx](https://hexdocs.pm/iex/IEx.html)
           [Mix](https://hexdocs.pm/mix/Mix.html)
           [Poison](https://hexdocs.pm/poison/Poison.html)
           [HTTPoison](https://hexdocs.pm/httpoison/HTTPoison.html)
           [Finch](https://hexdocs.pm/finch/Finch.html)
           [Timex](https://hexdocs.pm/timex/Timex.html)
           [Ecto](https://hexdocs.pm/ecto/Ecto.html)
           [Phoenix](https://hexdocs.pm/phoenix/Phoenix.html)
           [ExUnit.run/1](https://hexdocs.pm/ex_unit/ExUnit.html#run/1)
           [Phoenix.Flash.get_flash/2](https://hexdocs.pm/phoenix/Phoenix.Flash.html#get_flash/2)
           [Phoenix.HTML.Form.checkbox/3](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#checkbox/3)
           [GenServer](https://hexdocs.pm/elixir/GenServer.html)
           [Credo](https://hexdocs.pm/credo/Credo.html)
           [Dialyzer](https://hexdocs.pm/dialyxir/readme.html)
           `Ignore`
           `Ignore This`
           """
  end

  test "load!/1 loads the notebook content" do
    File.write!("test.livemd", "some content")

    notebook = %Notebook{relative_path: "test.livemd"}
    assert %Notebook{content: nil} = notebook
    assert %Notebook{content: "some content"} = Notebooks.load!(notebook)

    on_exit(fn ->
      File.rm!("test.livemd")
    end)
  end

  test "load!/1 raises a useful message if it cannot load." do
    notebook = %Notebook{relative_path: "./file_does_not_exist"}

    message = """
    ./file_does_not_exist does not exist.
    Try running mix compile --force in the test environment to ensure the notebook has been compiled.
    """

    assert_raise RuntimeError, message, fn ->
      Notebooks.load!(notebook)
    end
  end

  test "navigation_snippet/1 first notebook" do
    notebook = Notebooks.outline_notebooks() |> Enum.at(0)
    next = Notebooks.outline_notebooks() |> Enum.at(1)

    expected = """
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
    <i style="display: none;" class="ri-arrow-left-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href=""></a>
    </div>
    <div style="display: flex;">
    <a style="display: flex; color: #61758a; margin-right: 1rem;" href="#{next.relative_path}">#{next.title}</a>
    <i class="ri-arrow-right-fill"></i>
    </div>
    </div>
    """

    assert Notebooks.navigation_snippet(notebook) == expected
  end

  test "navigation_snippet/1 middle notebook" do
    prev = Notebooks.outline_notebooks() |> Enum.at(4)
    notebook = Notebooks.outline_notebooks() |> Enum.at(5)
    next = Notebooks.outline_notebooks() |> Enum.at(6)

    expected = """
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
    <i class="ri-arrow-left-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="#{prev.relative_path}">#{prev.title}</a>
    </div>
    <div style="display: flex;">
    <a style="display: flex; color: #61758a; margin-right: 1rem;" href="#{next.relative_path}">#{next.title}</a>
    <i class="ri-arrow-right-fill"></i>
    </div>
    </div>
    """

    assert Notebooks.navigation_snippet(notebook) == expected
  end

  test "navigation_snippet/1 last notebook" do
    notebook = Notebooks.outline_notebooks() |> Enum.at(-1)
    prev = Notebooks.outline_notebooks() |> Enum.at(-2)

    expected = """
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
    <i class="ri-arrow-left-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="#{prev.relative_path}">#{prev.title}</a>
    </div>
    <div style="display: flex;">
    <a style="display: flex; color: #61758a; margin-right: 1rem;" href=""></a>
    <i style="display: none;" class="ri-arrow-right-fill"></i>
    </div>
    </div>
    """

    assert Notebooks.navigation_snippet(notebook) == expected
  end

  test "outline_notebooks/0" do
    assert Enum.all?(Notebooks.outline_notebooks(), fn notebook -> notebook.index end)
  end

  test "unused_notebooks/0" do
    assert Enum.all?(Notebooks.unused_notebooks(), fn notebook -> is_nil(notebook.index) end)
  end

  test "update_dependencies" do
    notebook = %Notebook{
      content: """
      Mix.install([
        {:jason, "~> 1.2"},
        {:kino, "~> 0.8.0", override: true},
        {:youtube, github: "brooklinjazz/youtube"},
        {:hidden_cell, github: "brooklinjazz/hidden_cell"},
        {:benchee, "~> 1.0"},
        {:poison, "~> 4.0.0"},
        {:httpoison, "~> 2.0.0"},
        {:finch, "~> 0.14.0"},
        {:timex, "~> 3.6"},
        {:ecto, "~> 3.9"},
        {:faker, "~> 0.16.0"},
        {:vega_lite, "~> 0.1.5"},
        {:kino_vega_lite, "~> 0.1.7"},
        {:hackney, "~> 1.17"},
        {:oban, "~> 2.13"},
        {:kino_db, "~> 0.2.0"},
        {:postgrex, "~> 0.16.4"},
        {:poolboy, "~> 1.4"}
      ])
      """
    }

    assert Notebooks.update_dependencies(notebook) == %Notebook{
             content: """
             Mix.install([
               {:jason, "~> 1.4"},
               {:kino, "~> 0.9", override: true},
               {:youtube, github: "brooklinjazz/youtube"},
               {:hidden_cell, github: "brooklinjazz/hidden_cell"},
               {:benchee, "~> 1.1"},
               {:poison, "~> 5.0.0"},
               {:httpoison, "~> 2.1.0"},
               {:finch, "~> 0.16.0"},
               {:timex, "~> 3.7.11"},
               {:ecto, "~> 3.9.5"},
               {:faker, "~> 0.17.0"},
               {:vega_lite, "~> 0.1.6"},
               {:kino_vega_lite, "~> 0.1.8"},
               {:hackney, "~> 1.18"},
               {:oban, "~> 2.14"},
               {:kino_db, "~> 0.2.1"},
               {:postgrex, "~> 0.16.5"},
               {:poolboy, "~> 1.5"}
             ])
             """
           }
  end
end

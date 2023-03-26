defmodule Utils.NotebooksTest do
  use ExUnit.Case, async: true
  alias Utils.Notebooks
  alias Utils.Notebooks.Notebook
  doctest Utils.Notebooks

  test "navigation_snippet/2 first notebook" do
    notebook = Notebooks.outline_notebooks() |> Enum.at(0)
    next = Notebooks.outline_notebooks() |> Enum.at(1)

    expected = """
    ## Up Next

    <div style="display: flex; align-items: center; width: 100%; justify-content: space-between; font-size: 1rem; color: #61758a; background-color: #f0f5f9; height: 4rem; padding: 0 1rem; border-radius: 1rem;">
    <div style="display: flex;">
    <i class="ri-home-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="../reading/start.livemd">Home</a>
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

  test "navigation_snippet/2 middle notebook" do
    prev = Notebooks.outline_notebooks() |> Enum.at(4)
    notebook = Notebooks.outline_notebooks() |> Enum.at(5)
    next = Notebooks.outline_notebooks() |> Enum.at(6)

    expected = """
    ## Up Next

    <div style="display: flex; align-items: center; width: 100%; justify-content: space-between; font-size: 1rem; color: #61758a; background-color: #f0f5f9; height: 4rem; padding: 0 1rem; border-radius: 1rem;">
    <div style="display: flex;">
    <i class="ri-home-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="../reading/start.livemd">Home</a>
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

  test "navigation_snippet/2 last notebook" do
    notebook = Notebooks.outline_notebooks() |> Enum.at(-1)
    prev = Notebooks.outline_notebooks() |> Enum.at(-2)

    expected = """
    ## Up Next

    <div style="display: flex; align-items: center; width: 100%; justify-content: space-between; font-size: 1rem; color: #61758a; background-color: #f0f5f9; height: 4rem; padding: 0 1rem; border-radius: 1rem;">
    <div style="display: flex;">
    <i class="ri-home-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="../reading/start.livemd">Home</a>
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
           [Apply to the DockYard Academy June-August 2023 Cohort Now](https://docs.google.com/forms/d/1RwqHc1wUoY0jS440sBJHHl3gyQlw2xhz2Dt1ZbRaXEc/edit?ts=641e1aachttps://academy.dockyard.com/).
           """
  end
end

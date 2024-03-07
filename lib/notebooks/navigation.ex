defmodule Utils.Notebooks.Notebook.Navigation do
  alias Utils.Notebooks.Notebook

  def navigation_snippet(%Notebook{} = notebook, outline_notebooks) do
    prev_notebook = prev(notebook, outline_notebooks)
    next_notebook = next(notebook, outline_notebooks)
    home_path = "../#{notebook.parent_notebook.file_name}"

    # indenting results in Livebook misformatting the code.
    """
    ## Navigation

    <div style="display: flex; align-items: center; width: 100%; justify-content: space-between; font-size: 1rem; color: #61758a; background-color: #f0f5f9; height: 4rem; padding: 0 1rem; border-radius: 1rem;">
    <div style="display: flex;">
    <i class="ri-home-fill"></i>
    <a style="display: flex; color: #61758a; margin-left: 1rem;" href="#{home_path}">Home</a>
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

  defp prev(%{index: 0}, _), do: %{}

  defp prev(notebook, outline_notebooks) do
    Enum.at(outline_notebooks, notebook.index - 1, %{})
  end

  defp next(notebook, outline_notebooks) do
    if Enum.count(outline_notebooks) == notebook.index + 1 do
      %{}
    else
      Enum.at(outline_notebooks, notebook.index + 1)
    end
  end

  def header_navigation_section(notebook, outline_notebooks) do
    content =
      Regex.replace(
        ~r/## (:?Up Next|Navigation)\n(\n|.)+(?=##)/U,
        notebook.content,
        navigation_snippet(notebook, outline_notebooks)
      )

    %Notebook{notebook | content: content}
  end

  def footer_navigation_section(notebook, outline_notebooks) do
    cleared_content =
      Regex.replace(
        ~r/## (:?Up Next|Navigation)(\n|.(?!#))+\z/,
        notebook.content,
        ""
      )

    content = cleared_content <> navigation_snippet(notebook, outline_notebooks)

    %Notebook{notebook | content: content}
  end
end

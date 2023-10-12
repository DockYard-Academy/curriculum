defmodule Utils.Notebooks.Notebook do
  @moduledoc """
  A struct that represents a single .livemd notebook in the curriculum.
  """
  defstruct [
    :content,
    :name,
    :relative_path,
    :title,
    :folder,
    :type,
    :next_notebook,
    :prev_notebook
  ]

  @type t :: %__MODULE__{
          content: String.t(),
          name: String.t(),
          relative_path: String.t(),
          title: String.t(),
          folder: String.t(),
          type: String.t(),
          next_notebook: map(),
          prev_notebook: map()
        }

  require Logger

  @doc """
  Given a list of names and relative paths will create a list of notebook structs
  with the next_notebook and prev_notebook attributes set according to the position 
  of the notebook in the list.

  Useful for parsing input that is read from the start.livemd file.
  """
  @spec map_notebooks([%{name: String.t(), relative_path: String.t()}]) :: [__MODULE__.t()]
  def map_notebooks(nodes) do
    [first, second | _rest] = nodes
    first_node = Map.put(first, :next_notebook, second) |> Map.put(:prev_notebook, %{})

    rest =
      Enum.chunk_every(nodes, 3, 1)
      |> Enum.map(fn
        [prev, curr, next] ->
          Map.put(curr, :prev_notebook, prev)
          |> Map.put(:next_notebook, next)

        [prev, curr] ->
          Map.put(curr, :prev_notebook, prev)
          |> Map.put(:next_notebook, %{})
      end)

    [first_node | rest]
    |> Enum.map(&new!/1)
  end

  @doc """
  Create a new Notebook struct

  iex> Utils.Notebooks.Notebook.new!(%{index: 0, relative_path: "../reading/strings_and_binaries.livemd"})
  %Utils.Notebooks.Notebook{index: 0, relative_path: "../reading/strings_and_binaries.livemd", name: "strings_and_binaries", title: "Strings And Binaries", folder: "reading", type: :reading}
  """
  def new!(%{relative_path: "../start.livemd"} = attrs) do
    struct!(
      __MODULE__,
      Map.merge(attrs, %{name: "Home", type: :outline, title: "Curriculum Outline"})
    )
  end

  def new!(attrs) do
    "# " <> title = File.stream!(attrs.relative_path) |> Enum.take(1) |> hd() |> String.trim()

    name = Path.basename(attrs.relative_path, ".livemd")

    [[folder]] = Regex.scan(~r/(?:reading|exercises)/, attrs.relative_path)

    type =
      case folder do
        "reading" -> :reading
        "exercises" -> :exercise
      end

    struct!(__MODULE__, Map.merge(attrs, %{name: name, folder: folder, type: type, title: title}))
  end
end

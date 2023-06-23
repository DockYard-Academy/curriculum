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
  Create a new Notebook struct

  iex> Utils.Notebooks.Notebook.new!(%{index: 0, relative_path: "../reading/strings_and_binaries.livemd"})
  %Utils.Notebooks.Notebook{index: 0, relative_path: "../reading/strings_and_binaries.livemd", name: "strings_and_binaries", title: "Strings And Binaries", folder: "reading", type: :reading}
  """
  require Logger

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

defmodule Utils.Notebooks.Notebook do
  @moduledoc """
  A struct that represents a single .livemd notebook in the curriculum.
  """
  defstruct [
    :content,
    :index,
    :name,
    :relative_path,
    :title,
    :type
  ]

  @doc """
  Create a new Notebook struct

  iex> Utils.Notebooks.Notebook.new(%{index: 0, relative_path: "../reading/strings_and_binaries.livemd"})
  %Utils.Notebooks.Notebook{index: 0, relative_path: "../reading/strings_and_binaries.livemd", name: "strings_and_binaries", title: "Strings And Binaries", type: :reading}
  """
  require Logger

  def new(%{relative_path: "../start.livemd"} = attrs) do
    struct!(
      __MODULE__,
      Map.merge(attrs, %{name: "Home", type: :outline, title: "Curriculum Outline"})
    )
  end

  def new(attrs) do
    "# " <> title = File.stream!(attrs.relative_path) |> Enum.take(1) |> hd() |> String.trim()

    name = Path.basename(attrs.relative_path, ".livemd")

    type =
      case Regex.scan(~r/(?:reading|exercise)/, attrs.relative_path) do
        [["reading"]] -> :reading
        [["exercise"]] -> :exercise
      end

    struct!(__MODULE__, Map.merge(attrs, %{name: name, type: type, title: title}))
  end
end

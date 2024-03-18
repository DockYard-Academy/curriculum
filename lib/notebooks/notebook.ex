defmodule Utils.Notebooks.Notebook do
  @moduledoc """
  A struct that represents a single .livemd notebook in the curriculum.
  """

  @dependencies [
    {:kino, "0.12.3"},
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

  @release_dir "release"
  use StructCop

  contract do
    field :content, :binary
    field :index, :integer
    field :name, :binary
    field :relative_path, :binary
    field :full_path, :binary
    field :release_dir, :binary
    field :file_name, :binary

    field :title, :binary
    field :folder, :binary
    field :type, Ecto.Enum, values: [:outline, :reading, :exercise, :presentation]

    field :parent_notebook, :map
    field :outline_notebooks, {:array, :map}
  end

  @outline_notebooks_types_regex_part "reading|exercise|presentation"
  @doc """
  Create a new Notebook struct

  iex> Utils.Notebooks.Notebook.new!(%{index: 0, relative_path: "../reading/strings_and_binaries.livemd"})
  %Utils.Notebooks.Notebook{index: 0, relative_path: "../reading/strings_and_binaries.livemd", name: "strings_and_binaries", title: "Strings And Binaries", folder: "reading", type: :reading}
  """
  require Logger
  alias __MODULE__, as: Notebook

  def changeset(ch, attrs) do
    import Ecto.Changeset

    ch
    |> super(attrs)
    |> then(fn ch ->
      ch
      |> put_change(
        :relative_path,
        ch
        |> get_field(:full_path)
        |> String.replace("livebooks/", "")
      )
      |> put_change(
        :file_name,
        ch |> get_field(:full_path) |> Path.basename()
      )
    end)
    |> then(fn ch ->
      relative_path =
        get_field(ch, :relative_path)

      "# " <> title =
        get_field(ch, :full_path)
        |> file_path_to_read()
        |> File.stream!()
        |> Enum.take(1)
        |> hd()
        |> String.trim()

      name = Path.basename(relative_path, ".livemd")

      type =
        case Regex.compile!("(?:#{@outline_notebooks_types_regex_part})")
             |> Regex.scan(relative_path) do
          [[folder]] ->
            folder

          _ ->
            :outline
        end

      ch
      |> put_change(:name, name)
      |> put_change(:type, type)
      |> put_change(:title, title)
    end)
    |> then(fn ch ->
      ch
      |> put_change(
        :release_dir,
        get_field(ch, :release_dir) ||
          Path.join([@release_dir, get_field(ch, :file_name) |> Path.basename(".livemd")])
      )
    end)
    |> then(fn ch ->
      ch
      |> put_change(:content, ch |> get_field(:full_path) |> file_path_to_read() |> File.read!())
    end)
  end

  def update_dependencies(notebook) do
    content =
      Enum.reduce(dependencies(), notebook.content, fn {dependency, version}, acc ->
        Regex.replace(~r/#{dependency}, \"~> .+\"/, acc, "#{dependency}, \"~> #{version}\"")
      end)

    %Notebook{notebook | content: content}
  end

  def format(notebook) do
    formatted_content = LivebookFormatter.reformat(notebook.content)
    %Notebook{notebook | content: formatted_content}
  end

  def save(notebook) do
    File.write(notebook.relative_path, notebook.content)
  end

  def save_release(notebook) do
    IO.inspect(notebook)

    Path.join([
      notebook.release_dir,
      notebook.relative_path
    ])
    |> tap(fn path ->
      path |> Path.dirname() |> File.mkdir_p!()
    end)
    |> File.write(notebook.content)
  end

  def dependencies, do: @dependencies

  def load_outline_notebooks(%Notebook{type: :outline} = nb) do
    %Notebook{nb | outline_notebooks: outline_notebooks(nb)}
  end

  def load_outline_notebooks(any), do: any

  defp outline_notebooks(%Notebook{content: content} = nb) do
    Regex.compile!("(?:#{@outline_notebooks_types_regex_part})/[^/]+.livemd")
    |> Regex.scan(content)
    |> Enum.map(fn name -> Path.join("./", name) end)
    |> Enum.with_index()
    |> Enum.map(fn {relative_path, index} ->
      new!(
        release_dir: nb.release_dir,
        full_path: relative_path,
        index: index,
        parent_notebook: nb
      )
    end)
  end

  def lessons(%Notebook{outline_notebooks: outline_notebooks}) do
    outline_notebooks |> Enum.filter(fn x -> x.type == :reading end)
  end

  def exercises(%Notebook{outline_notebooks: outline_notebooks}) do
    outline_notebooks |> Enum.filter(fn x -> x.type == :exercise end)
  end

  def number_of_notebooks(%Notebook{outline_notebooks: outline_notebooks}),
    do: Enum.count(outline_notebooks)

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

    Run `git status` to ensure there are no undesirable changes.
    Then run the following in your command line from the `curriculum` folder to commit your progress.
    ```
    $ git add .
    $ git commit -m "finish #{notebook.title} #{notebook.type}"
    $ git push
    ```
    """
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

  defp built_in_module_docs(content) do
    Regex.replace(~r/`(\w+)`/, content, fn full, module_name ->
      module =
        module_name
        |> String.capitalize()
        |> then(fn
          "Genserver" -> "GenServer"
          "Mapset" -> "MapSet"
          x -> x
        end)
        |> then(fn x -> "Elixir." <> x end)
        |> String.to_atom()

      if Code.ensure_loaded?(module) do
        "[#{module_name}](https://hexdocs.pm/elixir/#{module_name}.html)"
      else
        full
      end
    end)
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

  def word_count(%Notebook{outline_notebooks: outline_notebooks}) do
    notebook_boilerplate_word_count = 245

    Enum.reduce(outline_notebooks, 0, fn x, acc ->
      count = String.split(x.content, " ") |> Enum.count()
      acc + count - notebook_boilerplate_word_count
    end)
  end

  def set_release_links(%Notebook{} = nb) do
    content =
      Regex.compile!("((?:#{@outline_notebooks_types_regex_part})/[^/]+.livemd)")
      |> Regex.replace(
        nb.content,
        fn _full, relative ->
          if nb.type == :outline do
            relative
          else
            Path.join(["..", relative])
          end
        end
      )

    %Notebook{nb | content: content}
  end

  defp file_path_to_read(full_path) do
    Path.join(["livebooks", full_path]) |> String.replace("livebooks/livebooks", "livebooks/")
  end
end

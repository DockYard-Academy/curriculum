defmodule UtilsTest do
  use ExUnit.Case, async: true
  doctest Utils
  alias Utils.Notebooks

  test "External libraries are installed if used in a notebook" do
    # dependency install name, and usage indicator
    used_deps = [
      {:kino, "Kino"},
      {:benchee, "Benchee"},
      {:poison, "Poison"},
      {:httpoison, "HTTPoison"},
      {:finch, "Finch"},
      {:timex, "Timex"},
      {:jason, "Jason"},
      {:faker, "Faker"},
      {:vega_lite, "VegaLite"},
      {:kino_vega_lite, "Kino.VegaLite"},
      {:kino_db, "KinoDB"},
      {:poolboy, "Poolboy"},
      {:youtube, "YouTube"},
      {:hidden_cell, "HiddenCell"},
      {:visual, "Visual"},
      {:smart_animation, "SmartAnimation"}
      # removed due to many false positives
      # {:ecto, "Ecto"},
      # {:postgrex, "Postgrex"},
    ]

    Notebooks.outline_notebooks()
    |> Enum.each(fn notebook ->
      %{content: content} = Notebooks.load!(notebook)

      assert Enum.each(used_deps, fn {dep, module} ->
               # regex attempts to avoids false negatives.
               if Regex.match?(~r/#{module}\.[^html][a-z]+/, content) do
                 assert String.contains?(content, ":#{dep}"),
                        "#{notebook.name} is missing #{dep} dependency."
               end
             end)
    end)
  end

  test "headings use title case" do
    Notebooks.outline_notebooks()
    |> Enum.each(fn notebook ->
      %{content: content} = Notebooks.load!(notebook)

      Regex.scan(~r/^\#{1,3} .+/, content)
      |> List.flatten()
      |> Enum.each(fn title ->
        expected_title = Notebooks.title_case(title)

        assert title == expected_title,
               "title #{title} in #{notebook.relative_path} should be #{expected_title}. Run mix all_tasks to resolve this issue."
      end)
    end)
  end

  test ".livemd files are formatted" do
    Notebooks.all_notebooks()
    |> Enum.each(fn notebook ->
      %{content: content} = Notebooks.load!(notebook)

      assert content == LivebookFormatter.reformat(content),
             """
             #{notebook.relative_path} is not formatted.
             Run mix all_tasks to resolve the issue.
             Alternatively, sometimes code blocks and other markdown syntax immediately after bullet points can cause issues.
             """
    end)
  end

  test "local images exist" do
    Notebooks.outline_notebooks()
    |> Enum.flat_map(fn notebook ->
      %{content: content} = Notebooks.load!(notebook)

      Regex.scan(~r/!\[[^\]]*\]\(([^http][^\)]+)\)/, content)
      |> Enum.map(fn [_, image_path] ->
        Path.join(["../", notebook.folder, URI.decode(image_path)])
      end)
    end)
    |> Enum.uniq()
    |> Enum.each(fn relative_image_path ->
      assert File.exists?(relative_image_path)
    end)
  end

  test "outline files exist" do
    Notebooks.outline_notebooks()
    |> Enum.all?(fn notebook ->
      assert File.exists?(notebook.relative_path)
    end)
  end

  test "outline files have header and footer navigation" do
    Notebooks.outline_notebooks()
    |> Enum.each(fn notebook ->
      content = File.read!(notebook.relative_path)
      navigation_sections = Regex.scan(~r/\n## Navigation\n/, content)

      assert length(navigation_sections) == 2, "missing navigation in #{notebook.relative_path}"
    end)
  end

  test "Documentation links should not contain references to version numbers" do
    regex = ~r/\/\d\.\d\d\//

    Notebooks.all_notebooks()
    |> Enum.each(fn notebook ->
      notebook = Notebooks.load!(notebook)

      refute Regex.match?(regex, notebook.content),
             "found version number #{Regex.run(regex, notebook.content)} in #{notebook.relative_path}"
    end)
  end

  test "Prefer links to documentation over backticks" do
    regex = ~r/`(?:#{Enum.join(Notebooks.documented_libraries(), "|")})`/

    Notebooks.all_notebooks()
    |> Enum.each(fn notebook ->
      notebook = Notebooks.load!(notebook)
      refute Regex.match?(regex, notebook.content), "run mix all_tasks to resolve this issue."
    end)
  end

  test "referenced notebooks exist" do
    Notebooks.outline_notebooks()
    |> Enum.each(fn notebook ->
      %{content: content} = Notebooks.load!(notebook)

      links =
        Regex.scan(
          ~r/\(((?:\w|\/|\.|\-)+\.livemd)\)/,
          content
        )
        |> Enum.map(fn [_full, relative_path] -> relative_path end)

      Enum.each(links, fn link ->
        link_path_relative_to_notebook = Path.join("../#{notebook.folder}", link)

        assert File.exists?(link_path_relative_to_notebook),
               "The link: #{link} in #{notebook.relative_path} does not exist."
      end)
    end)
  end
end

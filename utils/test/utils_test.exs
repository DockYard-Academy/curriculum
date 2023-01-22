defmodule UtilsTest do
  use ExUnit.Case, async: true
  doctest Utils
  alias Utils.Notebooks

  @tag :skip_ci
  test "Ensure all .livemd files are formatted." do
    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)
      # loading the file in livebook adds a newline, so we add it when we format
      # to avoid changing the file every time a student opens a .livemd file.
      expected = LivebookFormatter.reformat(file)

      assert file == expected,
             """
             #{file_name}: Needs to be formatted.

             Run mix bc.format_notebooks to format all notebooks.
             Sometimes bullet points * can cause formatting issues.
             """
    end)
  end

  test "Prefer links to documentation over backticks" do
    # i.e. prefer [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2) over `Enum.map/2`
    libraries = [
      "Kino",
      "ExUnit",
      "Benchee",
      "IEx",
      "Mix",
      "Poison",
      "HTTPoison",
      "Timex"
    ]

    Notebooks.all_livebooks()
    |> Notebooks.stream_lines(fn line, file_name, line_number ->
      Regex.scan(~r/\`([A-Z]\w+)\`|\`([A-Z]\w+)\.\w+!*\?*\/[1-9]\`/, line)
      |> Enum.map(fn
        [_, module, ""] ->
          module

        [_, "", module] ->
          module

        [_, module] ->
          module
      end)
      |> Enum.each(fn module ->
        should_use_documentation =
          match?({:module, _}, Code.ensure_compiled(String.to_atom("Elixir.#{module}"))) or
            module in libraries

        if should_use_documentation do
          flunk("""
          #{file_name}:#{line_number} #{module} should use a documentation link [module](url) instead of backticks.

          run mix bc.autolink to resolve this issue.
          """)
        end
      end)
    end)
  end

  test "Ensure all external libraries are installed if used" do
    # dependency install name, and usage indicator
    possible_deps = [
      {":youtube", "YouTube."},
      {":smart_animation", "SmartAnimation."},
      {":hidden_cell", "HiddenCell."},
      {":benchee", "Benchee."},
      {":timex", "Timex."},
      {":httpoison", "HTTPoison."},
      {":kino_db", "Elixir.KinoDB."},
      {":postgrex", "Kino.start_child({Postgrex}"}
    ]

    Notebooks.all_livebooks()
    |> Enum.each(fn file_name ->
      file = File.read!(file_name)

      Enum.each(possible_deps, fn {install, usage} ->
        if String.contains?(file, usage) do
          assert String.contains?(file, install), "#{file_name}: Add #{install} to Mix.install/2"
        end
      end)
    end)
  end

  test "All outline files exist" do
    outline = File.read!("../start.livemd")

    Regex.scan(~r/\[[^\]]+\]\(([^\)]+\.livemd)\)/, outline)
    |> Enum.each(fn [_, file_name] ->
      assert File.exists?(Path.join("../", file_name))
    end)
  end

  test "Ensure all images are used and exist" do
    file_and_image_paths =
      Path.wildcard("../*/*.livemd")
      |> Enum.map(fn file_path ->
        content = File.read!(file_path)

        Regex.scan(~r/!\[[^\]]*\]\(([^http][^\)]+)\)/, content)
        |> Enum.map(fn [_, image_path] ->
          {file_path, Path.join(Path.dirname(file_path), URI.decode(image_path))}
        end)
      end)
      |> List.flatten()

    Enum.each(file_and_image_paths, fn {file_path, image_path} ->
      assert File.exists?(image_path), "Could not find image #{image_path} in #{file_path}"
    end)
  end

  test "Ensure files not in outline are deprecated" do
    outline = File.read!("../start.livemd")

    all_paths = Path.wildcard("../*/*.livemd")
    ignored_paths = Path.wildcard("../*/_*.livemd")
    deprecated_paths = Path.wildcard("../*/deprecated*.livemd")

    outline_paths =
      Regex.scan(~r/\[[^\]]+\]\(([^\)]+\.livemd)\)/, outline)
      |> Enum.map(fn [_, file_name] ->
        Path.join("../", file_name)
      end)

    remaining_paths = all_paths -- ignored_paths
    remaining_paths = remaining_paths -- deprecated_paths
    remaining_paths = remaining_paths -- outline_paths
    assert remaining_paths == []
  end

  test "Ensure no broken / empty links in livebooks" do
    Notebooks.stream_lines(Notebooks.reading() ++ Notebooks.exercises(), fn line, file_name ->
      # Empty Links
      refute Regex.match?(~r/\]\(\)/, line)

      # Invalid Links
      found = Regex.scan(~r/\[(\w+)\]\(((\w|\/|\.)+)\)/, line)

      Enum.each(found, fn [_full, name, path, _] ->
        assert String.length(name) > 0, "Link name should not be empty"

        if Regex.match?(~r/exercises|reading/, path) do
          assert File.exists?(path)
        else
          # Relative Links
          [base_path] = Regex.run(~r/\.\.\/\w+\//, file_name)
          assert File.exists?(base_path <> path)
        end
      end)
    end)
  end

  test "Headings should be in title case" do
    Notebooks.all_livebooks()
    |> Notebooks.stream_lines(fn line, file_name, line_number ->
      heading =
        case {line, line_number} do
          {"### " <> heading, _} -> heading
          {"## " <> heading, _} -> heading
          {"# " <> heading, 1} -> heading
          # ignore
          _ -> ""
        end

      expected = Notebooks.to_title_case(heading)

      assert heading =~ expected,
             """
             Incorrectly Formatted Heading:
             #{file_name}:#{line_number}.

             Expected: #{expected}
             Received: #{heading}

             Manually resolve the issue or run mix bc.format_headings.
             """
    end)
  end

  test "modules are only defined once" do
    Notebooks.all_livebooks()
    |> Enum.each(fn path ->
      content = File.read!(path)

      modules =
        Regex.scan(~r/(?<!<\/summary>\n\n\`\`\`elixir\n)defmodule ((\w|\.)+) do/, content)
        |> Enum.map(fn [_, module, _] -> {path, module} end)

      non_duplicates = Enum.dedup(modules)

      duplicates = modules -- non_duplicates

      ignored_file_paths = [
        "./exercises/product_filters.livemd",
        "../exercises/mapset_product_filters.livemd",
        "../exercises/product_filters.livemd",
        "../exercises/rps_pattern_matching.livemd",
        "../exercises/fizzbuzz.livemd",
        "../exercises/lazy_product_filters.livemd",
        "../exercises/custom_assertions.livemd",
        "../exercises/supervisor_and_genserver_drills.livemd",
        "../exercises/anagram.livemd",
        "../exercises/tic-tac-toe.livemd",
        "../reading/phoenix_authentication.livemd",
        "../reading/generic_server.livemd",
        "../reading/schemas_and_migrations.livemd",
        "../reading/iex.livemd",
        "../reading/agents_and_ets.livemd",
        "../reading/newsletter.livemd",
        "../reading/phoenix_1.7.livemd",
        "../reading/executables.livemd",
        "../reading/phoenix_1.6.livemd",
        "../reading/supervised_mix_project.livemd",
        "../reading/liveview.livemd"
      ]

      Enum.each(duplicates, fn
        {path, module} ->
          unless path in ignored_file_paths do
            IO.puts("""
            #{path} may contain duplicate module: #{module}.

            Add this path to the ignored_file_paths in utils_tests.exs or resolve the issue.
            """)
          end
      end)
    end)
  end

  test "we no longer use Tested.Cell" do
    Notebooks.all_livebooks()
    |> Enum.each(fn path ->
      content = File.read!(path)
      refute content =~ "Elixir.TestedCell"
    end)
  end
end

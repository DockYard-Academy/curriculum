defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils
  alias Utils.Factory
  alias Utils.Solutions
  alias Livebook.LiveMarkdown.MarkdownHelpers

  test "slide/1" do
    Utils.Slide.__info__(:functions)
    |> Enum.each(fn {slide_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.slide(slide_name)
    end)
  end

  test "table/1" do
    Utils.Table.__info__(:functions)
    |> Enum.each(fn {table_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.table(table_name)
    end)
  end

  test "graph/1" do
    Utils.Graph.__info__(:functions)
    |> Enum.each(fn {graph_name, _arity} ->
      assert %Kino.JS.Live{} = Utils.graph(graph_name)
    end)
  end

  test "constants/1" do
    Utils.Constants.__info__(:functions)
    |> Enum.each(fn {constant_name, _arity} ->
      assert Utils.constants(constant_name)
    end)
  end

  test "form/1" do
    Utils.Form.__info__(:functions)
    |> Enum.each(fn {form_name, _arity} ->
      assert %Kino.JS{} = Utils.form(form_name)
    end)
  end

  test "random" do
    assert Utils.random(:rock_paper_scissors) in [:rock, :paper, :scissors]
    assert Utils.random(1..9) in 1..9
  end

  test "feedback/2" do
    Enum.each(Utils.Feedback.test_names(), fn each ->
      exists = Keyword.has_key?(Solutions.__info__(:functions), each)

      if !exists do
        raise "define a Solutions.#{Atom.to_string(each)} function."
      end
    end)

    execute_tests_until_failure(Utils.Feedback.test_names())
  end

  test "feedback/2 with invalid atom" do
    atom = String.to_atom(Factory.string())

    assert Utils.feedback(atom, "non-nil answer") ==
             "Something went wrong, feedback does not exist for #{atom}. Please speak to your teacher and/or reset the exercise."
  end

  defp execute_tests_until_failure([]), do: nil

  defp execute_tests_until_failure([test | tail]) do
    test_failed = Utils.feedback(test, apply(Solutions, test, [])).failures > 0

    unless test_failed do
      execute_tests_until_failure(tail)
    end
  end

  test "Ensure no broken / empty links in livebooks" do
    exercises = fetch_livebooks("../exercises/")
    reading = fetch_livebooks("../reading/")

    assert file_contains?(~r/\]\(.*exercises\/\w+.livemd\)/, exercises) == false
    assert file_contains?(~r/\]\(.*reading\/\w+.livemd\)/, reading) == false
    assert file_contains?(~r/\]\(\)/, exercises ++ reading) == false
  end

  test "Teacher-only editors are hidden" do
    exercises = fetch_livebooks("../exercises/")
    reading = fetch_livebooks("../reading/")

    refute file_contains?(~r/TestedCell\./, exercises ++ reading)
  end

  describe "Notebook Headlines" do
    test "h2-h6 titles should be in title case" do
      one_word_title_titlecase_regex = ~r/^[A-Z].*$/

      exercises = fetch_livebooks("../exercises/")
      reading = fetch_livebooks("../reading/")

      (exercises ++ reading)
      |> Enum.each(fn filename ->
        {_, ast, _} = filename |> File.read!() |> MarkdownHelpers.markdown_to_block_ast()

        # get only headers in file
        header_list =
          Enum.filter(ast, fn
            # only match h2 - h6 since h1's are notebook titles
            {tag, _, _, _} when is_binary(tag) -> String.match?(tag, ~r/h[2-6]/)
            _ -> false
          end)

        # check each header for titlecase
        Enum.each(header_list, fn {_tag, _, [content], _} ->
          word_list = String.split(content)
          single_word = word_list |> filter_headline |> List.first()

          # if header is only one word, check that it's capitalized
          if length(word_list) == 1 && is_binary(single_word) &&
               !String.starts_with?(single_word, ":") do
            assert String.match?(single_word, one_word_title_titlecase_regex),
                   "[#{filename}] expected: \"#{single_word}\" to be capitalized"
          else
            is_line_titlecase =
              word_list
              # filter out punctuations , `#`'s, articles, conjunctions, prepositions, numbers
              |> filter_headline
              # check each word starts with a capital letter
              |> Enum.all?(fn word -> String.match?(word, ~r/^[A-Z]/) end)

            assert is_line_titlecase, "[#{filename}] expected \"#{content}\" to be titlecase"
          end
        end)
      end)
    end
  end

  defp file_contains?(regex, livebooks) do
    livebooks
    |> Stream.map(fn file ->
      File.stream!(file, [], :line)
      |> Enum.any?(&Regex.match?(regex, &1))
    end)
    |> Enum.any?()
  end

  defp fetch_livebooks(path) do
    File.ls!(path)
    |> Stream.filter(&String.ends_with?(&1, ".livemd"))
    |> Enum.map(&(path <> &1))
  end

  defp filter_headline(word_list) do
    Enum.filter(
      word_list,
      &(!String.match?(
          &1,
          # ~r/
          # method_names: e.g. increased/1, Stream.iterate/2, <start_link> |
          # all punctuations |
          # hashes |
          # word-boundary numbers word-boundary
          # /
          ~r/.*\/[0-9]$|[!"#$%&'()*+,-.:;<=>?@[\]^_`{|}~]|#+|\b[0-9]+\b/
        ))
    )
  end
end

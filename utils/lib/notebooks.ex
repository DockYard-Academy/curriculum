defmodule Utils.Notebooks do
  @minor_words ["and", "the", "in", "to", "of"]

  def stream_lines(file_names, function) do
    arity = :erlang.fun_info(function)[:arity]

    Stream.each(file_names, fn file_name ->
      file_name
      |> File.stream!([], :line)
      |> Stream.with_index()
      |> Stream.map(fn {line, index} ->
        line_number = index + 1

        case arity do
          1 -> function.(line)
          2 -> function.(line, file_name)
          3 -> function.(line, file_name, line_number)
        end
      end)
      |> Stream.run()
    end)
    |> Stream.run()
  end

  def all_livebooks do
    reading() ++ exercises() ++ ["../start.livemd"]
  end

  def reading do
    fetch_livebooks("../reading/")
  end

  def exercises do
    fetch_livebooks("../exercises/")
    |> Enum.reject(&(Path.basename(&1) in exercises_exceptions()))
  end

  def exercises_exceptions do
    ["_template.livemd"]
  end

  defp fetch_livebooks(path) do
    File.ls!(path)
    |> Stream.filter(&String.ends_with?(&1, ".livemd"))
    |> Enum.map(&(path <> &1))
    |> Enum.reject(fn file_name -> String.contains?(String.downcase(file_name), "deprecated") end)
  end

  @doc """
  Capitalize first letter of string without downcasing rest of string.

    ## Examples

      iex> Utils.Notebooks.capitalize_first("hello")
      "Hello"

      iex> Utils.Notebooks.capitalize_first("genServer")
      "GenServer"
  """
  def capitalize_first(str) do
    {first, rest} = String.split_at(str, 1)
    String.capitalize(first) <> rest
  end

  @doc """
  Convert string to title case downcasing minor words and capitalizing first letter of major words.

    ## Examples

    iex> Utils.Notebooks.to_title_case("bottles of soda")
    "Bottles of Soda"

    iex> Utils.Notebooks.to_title_case("my_function/1")
    "my_function/1"

    iex> Utils.Notebooks.to_title_case(":atom")
    ":atom"

    iex> Utils.Notebooks.to_title_case("Bottles Of Soda")
    "Bottles of Soda"
  """
  def to_title_case(str) do
    String.split(str)
    |> Enum.with_index()
    |> Enum.map(fn
      {word, index} ->
        cond do
          String.contains?(word, "/") ->
            word

          index == 0 ->
            capitalize_first(word)

          String.downcase(word) in @minor_words ->
            String.downcase(word)

          true ->
            capitalize_first(word)
        end
    end)
    |> Enum.join(" ")
  end

  def student_progress_map(outline) do
    Regex.scan(~r/\[[^\]]+\]\((reading|exercises)\/([^\)]+)\.livemd\)/, outline)
    |> Enum.reduce(%{}, fn [_, type, name], acc ->
      key =
        case type do
          "reading" -> "#{name}_reading"
          "exercises" -> "#{name}_exercise"
        end

      Map.put(acc, key, false)
    end)
  end

  def navigation_blocks(outline) do
    files =
      Regex.scan(~r/\[([^\]]+)\]\((\w+\/[^\)]+\.livemd)\)/, outline)
      |> Enum.map(fn [_, lesson_name, file_name] ->
        {file_name, "[#{lesson_name}](../#{file_name})"}
      end)

    Enum.reduce(Enum.with_index(files), %{}, fn {{file_name, _}, index}, acc ->
      prev = index > 0 && Enum.at(files, index - 1)
      next = Enum.at(files, index + 1)

      Map.put(acc, file_name, %{
        prev: (prev && elem(prev, 1)) || "-",
        next: (next && elem(next, 1)) || "-"
      })
    end)
  end

  def navigation(navigation_map, file_name) do
    """
    ## Up Next

    | Previous | Next |
    | :------- | ----:|
    | #{navigation_map[file_name].prev} | #{navigation_map[file_name].next} |
    """
  end
end

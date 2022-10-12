defmodule Mix.Tasks.Bc.AddNavigation do
  @moduledoc "Add Previous/Next navigation link to reading pages."
  @shortdoc @moduledoc

  use Mix.Task

  @impl Mix.Task
  def run(_) do
    file = File.read!("../start.livemd")

    Regex.scan(~r/reading\/\w+.livemd|exercises\/\w+.livemd/, file)
    |> List.flatten()
    |> Enum.map(fn file_name -> "../" <> file_name end)
    |> Enum.filter(&File.exists?/1)
    |> Enum.chunk_every(3, 1)
    |> Enum.each(fn
      # ignoring first and last section in favor of manually adding navigation.
      [_first, _last] ->
        "IGNORE"

      [prev, current, next] ->
        file = File.read!(current)

        content = """

        ## Up Next

        | Previous | Next |
        | :------- | ----:|
        | [#{to_title(prev)}](#{prev}) | [#{to_title(next)}](#{next}) |
        """

        if String.contains?(file, "## Up Next") do
          # Up Next should always be the last section of the live markdown content.
          # All content after Up Next is overwritten.
          new_file = Regex.replace(~r/\n\#\# Up Next(.|\n)+/, file, content)
          File.write(current, new_file)
        else
          File.write!(current, content, [:append])
        end
    end)
  end

  defp to_title(file_path) do
    file_name =
      case file_path do
        "../reading/" <> file_name -> file_name
        "../exercises/" <> file_name -> file_name
      end

    [name, _extension] = String.split(file_name, ".")

    String.split(name, "_")
    |> Enum.map(&capitalize/1)
    |> Enum.join(" ")
  end

  @custom_capitalizations %{
    "api" => "API",
    "apis" => "APIs",
    "cli" => "CLI",
    "css" => "CSS",
    "datetime" => "DateTime",
    "ets" => "ETS",
    "exunit" => "ExUnit",
    "fizzbuzz" => "FizzBuzz",
    "genserver" => "GenServer",
    "genservers" => "GenServers",
    "html" => "HTML",
    "iex" => "IEx",
    "io" => "IO",
    "liveview" => "LiveView",
    "mapset" => "MapSet",
    "mapsets" => "MapSets",
    "rdbms" => "RDBMS",
    "rpg" => "RPG",
    "rps" => "RPS",
    "saferange" => "SafeRange"
  }

  defp capitalize(word) do
    @custom_capitalizations
    |> Map.get(String.downcase(word), String.capitalize(word))
  end
end

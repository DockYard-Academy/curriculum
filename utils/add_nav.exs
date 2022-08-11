defmodule AddNav do
  def get_readings(path) do
    case File.read(path) do
      {:ok, text} ->
        text
          |> String.split("\n")
          |> Enum.filter(fn x -> Regex.match?(~r/reading.*\.livemd/, x) end)
    end
  end
end

# start_path = Path.expand("../start.livemd")
# start = AddNav.get_readings(start_path)
# IO.inspect(start)

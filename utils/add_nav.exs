defmodule AddNav do
  @reading_regex ~r/(?<=reading\/).*\.livemd/

  def get_readings(filepath) do
    case File.read(filepath) do
      {:ok, text} ->
        text
          |> String.split("\n")
          |> Enum.filter(fn x -> Regex.match?(@reading_regex, x) end)
          |> Enum.map(fn x -> Regex.run(@reading_regex, x) end)
          |> List.flatten()
      {:error, reason} ->
        raise(reason)
    end
  end

  def get_prev_next(page_list, filepath) do
    list_len = length(page_list)
    pos = Enum.find_index(page_list, fn x -> x == filepath end)

    cond do
      pos == 0 ->
        {nil, Enum.at(page_list, 1)}
      pos == list_len ->
        {Enum.at(page_list, pos - 1), nil}
      pos >= 1 ->
        {Enum.at(page_list, pos - 1), Enum.at(page_list, pos + 1)}
    end
  end

  def edit_file(filepath) do
    # Check if last two lines are newline/nav line
    # If so overwrite, if not append
    # """
    # <span align="left;">
    #     PREVIOUS
    #     <span style="float:right;">
    #         NEXT
    #     </span>
    # </p>
    # <span align="left;">
    #     <a href="../reading/#{prev_link}">Prev Link</a>
    #     <span style="float:right;">
    #         <a href="#{next_link}">Next Link</a>
    #     </span>
    # </p>
    # """
  end

  def run(folder) do
    # Loop through all files in selected folder if folder and if file then run on just that file
  end
end

start_path = Path.expand("../start.livemd")
start = AddNav.get_readings(start_path)
IO.inspect(start)

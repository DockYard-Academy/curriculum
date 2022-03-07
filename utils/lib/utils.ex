defmodule Utils do
  @moduledoc """
  Documentation for `Utils`.
  """

  def animate(:remainder) do
    Kino.animate(500, 0, fn i ->
      md = Kino.Markdown.new("
  ```elixir
  rem(#{i}, 10) = #{rem(i, 10)}
  ```
  ")

      {:cont, md, i + 1}
    end)
  end

  @doc ~S"""
  iex> %Kino.Markdown{} = Utils.visual(:loading_bar, 50)
  iex> %Kino.Image{} = Utils.visual(:light_control, true)
  """
  def visual(:loading_bar, percentage) do
    Kino.Markdown.new("
    <div style=\"height: 20px; width: 100%; background-color: grey\">
      <div style=\"height: 20px; width: #{percentage}%; background-color: green\"></div>
    </div>
  ")
  end

  def visual(:light_control, power) do
    content = if power, do: "/images/on.png", else: "/images/off.png"
    image = Kino.Image.new(File.read!(__DIR__ <> content), :png)
  end
end

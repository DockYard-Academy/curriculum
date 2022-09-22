defmodule Utils.Visual do
  def visual(:loading_bar, percentage) do
  Kino.Markdown.new(~s(
    <div style=\"height: 20px; width: 100%; background-color: grey\">
    <div style=\"height: 20px; width: #{percentage}%; background-color: green\"></div>
    </div>
  ))
  end

  def visual(:light_control, power) do
    content = if power, do: "/images/on.png", else: "/images/off.png"
    Kino.Image.new(File.read!(__DIR__ <> content), :png)
  end
end

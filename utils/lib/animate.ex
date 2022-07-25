defmodule Utils.Animate do
  def animate(:biggest_integer) do
    max = 10 ** 80

    Kino.animate(100, 1, fn i ->
      integer_display = (10 ** i < max && 10 ** i) || "$10^{#{i}}$"
      md = Kino.Markdown.new("
integer: #{integer_display}\n
digits: #{Integer.digits(10 ** i) |> Enum.count()}
  ")

      {:cont, md, i + 1}
    end)
  end

  def animate(:eager_evaluation) do
    sequence = [
      "
  #{row("1..10", Enum.map(1..10, &green_box/1))}
  #{row("map", [])}
  #{row("filter", [])}
  #{row("take", [])}
",
      "
  #{row("1..10", Enum.map(1..10, &green_box/1))}
  #{row("map", Enum.map(2..20//2, &green_box/1))}
  #{row("filter", [])}
  #{row("take", [])}
",
      "
  #{row("1..10", Enum.map(1..10, &green_box/1))}
  #{row("map", Enum.map(2..20//2, &green_box/1))}
  #{row("filter", Enum.map(2..10//2, &green_box/1) ++ Enum.map(12..20//2, &grey_box/1))}
  #{row("take", [])}
",
      "
  #{row("1..10", Enum.map(1..10, &green_box/1))}
  #{row("map", Enum.map(2..20//2, &green_box/1))}
  #{row("filter", Enum.map(2..10//2, &green_box/1) ++ Enum.map(12..20//2, &grey_box/1))}
  #{row("take", Enum.map(2..8//2, &green_box/1) ++ Enum.map(10..20//2, fn _ -> space() end))}
  "
    ]

    Kino.animate(2000, 0, fn i ->
      md = Kino.Markdown.new(Enum.at(sequence, i))
      {:cont, md, rem(i + 1, length(sequence))}
    end)
  end

  def animate(:lazy_evaluation) do
    Kino.animate(500, {0, 0}, fn {current_row, current_column} ->
      current_element = current_column + 1
      range = green_boxes(1..current_element) ++ grey_boxes((current_element + 1)..10)

      maybe_display = fn expected_row, display ->
        if current_row === expected_row, do: display, else: []
      end

      indent = spaces(current_column)
      md = Kino.Markdown.new("
#{row("1..10", range)}
#{row("map", maybe_display.(1, indent ++ [green_box(current_element * 2)]))}
#{row("filter", maybe_display.(2, indent ++ [green_box(current_element * 2)]))}
#{row("take", green_boxes(2..(current_element * 2 - 2)//2) ++ maybe_display.(3, [green_box(current_element * 2)]))}
")
      next_row = rem(current_row + 1, 4)
      next_column = rem((current_row === 3 && current_column + 1) || current_column, 4)
      {:cont, md, {next_row, next_column}}
    end)
  end

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

  def animate(:road_light) do
    Kino.animate(500, 0, fn i ->
      md = Kino.Markdown.new(~s(
<div style=\"display: flex; justify-content: center; width: 100%;\">
  <div style=\"height: 50px; width: 50px; margin: 10px; background-color: #{(i === 0 && "green") || "black"}; border-radius: 50%;\"></div>
  <div style=\"height: 50px; width: 50px; margin: 10px; background-color: #{(i === 1 && "yellow") || "black"}; border-radius: 50%;\"></div>
  <div style=\"height: 50px; width: 50px; margin: 10px; background-color: #{(i === 2 && "red") || "black"}; border-radius: 50%;\"></div>
</div>
  "))
      {:cont, md, rem(i + 1, 3)}
    end)
  end

  defp box(text, style) do
    "<div style=\"margin: 0 10px; font-size: 24px; font-weight: bold; height: 50px; width: 50px; background-color: #{style.background}; border: #{style.border} solid 1px; display: flex;  align-items: center; justify-content: center;\">#{text}</div>"
  end

  defp space, do: box("", %{background: "none", border: "none"})
  defp green_box(text), do: box(text, %{background: "#D5E8D4", border: "#82B366"})
  defp grey_box(text), do: box(text, %{background: "#F5F5F5", border: "#666666"})

  defp row(title, items) do
    "<div style=\"height: 80px; display: flex; width: 100%; align-items: center;\">
    <p style=\"font-weight: bold; font-size: 24px; margin: 0; width: 10%;\">#{title}</p>
    <div style=\"display: flex; width: 90%;\">#{items}</div>
  </div>"
  end

  defp spaces(0), do: []
  defp spaces(integer), do: Enum.map(1..integer, fn _ -> space() end)
  defp green_boxes(range), do: Enum.map(range, &green_box/1)
  defp grey_boxes(range), do: Enum.map(range, &grey_box/1)
end

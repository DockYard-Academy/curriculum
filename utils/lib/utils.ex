defmodule Utils do
  @moduledoc """
  Documentation for `Utils`.
  """
  alias Kino.ValidatedForm

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

  @doc """
  iex> Utils.animate(:eager_evaluation)
  iex> Utils.animate(:lazy_evaluation)
  iex> Utils.animate(:remainder)
  iex> Utils.animate(:road_light)
  """
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
      md = Kino.Markdown.new("
<div style=\"display: flex; justify-content: center; width: 100%;\">
  <div style=\"height: 50px; width: 50px; margin: 10px; background-color: #{(i === 0 && "green") || "black"}; border-radius: 50%;\"></div>
  <div style=\"height: 50px; width: 50px; margin: 10px; background-color: #{(i === 1 && "yellow") || "black"}; border-radius: 50%;\"></div>
  <div style=\"height: 50px; width: 50px; margin: 10px; background-color: #{(i === 2 && "red") || "black"}; border-radius: 50%;\"></div>
</div>
  ")
      {:cont, md, rem(i + 1, 3)}
    end)
  end

  @doc ~S"""
  iex> %Kino.JS{} = Utils.form(:comparison_operators)
  iex> %Kino.JS{} = Utils.form(:boolean_fill_in_the_blank)
  iex> %Kino.JS{} = Utils.form(:lists_vs_tuples)
  """
  def form(:comparison_operators) do
    ValidatedForm.new([
      %{label: "7 __ 8", answers: ["<"]},
      %{label: "8 __ 7", answers: [">"]},
      %{
        label: "8 __ 8 and 9 __ 9 and <b>not</b> 10 __ 10.0",
        answers: ["==="]
      },
      %{label: "8 __ 8.0 and 0 __ 9.0", answers: ["=="]},
      %{label: "8 __ 7 and 7 __ 7", answers: [">="]},
      %{label: "7 __ 8 and 7 __ 7", answers: ["<="]}
    ])
  end

  def form(:boolean_fill_in_the_blank) do
    ValidatedForm.new([
      %{label: "not ____ and true === false", answers: ["true"]},
      %{label: "true ____ false === true", answers: ["or"]},
      %{label: "not true ____ true === true", answers: ["or"]},
      %{label: "not false ____ true === true", answers: ["and"]},
      %{label: "not (true and false) ____ false === true", answers: ["or"]},
      %{label: "not (true or false) or not (not ____ and true) === true", answers: ["false"]},
      %{label: "____ false and true === true", answers: ["not"]},
      %{label: "false or ____ true === false", answers: ["not"]}
    ])
  end

  def form(:lists_vs_tuples) do
    options = [
      "",
      "O(n)",
      "O(n*)",
      "O(1)",
      "O(n1)",
      "O(n1 + n2)"
    ]

    ValidatedForm.new([
      %{label: "concatenating two lists", answers: ["O(n1)"], options: options},
      %{label: "inserting an element in tuple", answers: ["O(n)"], options: options},
      %{label: "deleting an element in a list", answers: ["O(n*)"], options: options},
      %{label: "prepending an element in a list", answers: ["O(1)"], options: options},
      %{label: "updating an element in a list", answers: ["O(n*)"], options: options},
      %{label: "concatenating two tuples", answers: ["O(n1 + n1)"], options: options},
      %{label: "inserting an element in list", answers: ["O(n*)"], options: options},
      %{label: "updating an element in tuple", answers: ["O(n)"], options: options},
      %{label: "deleting an element in a tuple", answers: ["O(n)"], options: options},
      %{label: "finding the length of a tuple", answers: ["O(1)"], options: options},
      %{label: "deleting an element in a list", answers: ["O(n*)"], options: options},
      %{label: "finding the length of a list", answers: ["O(n)"], options: options},
      %{label: "finding the length of a list", answers: ["O(n)"]}
    ])
  end

  @doc ~S"""
  iex> %{} = Utils.get(:string_maze)
  iex> %{} = Utils.get(:atom_maze)
  """
  def get(:string_maze) do
    put_in(
      %{},
      Enum.map(
        [
          "west",
          "south",
          "east",
          "north",
          "east",
          "south",
          "east",
          "south",
          "east",
          "south",
          "west",
          "north"
        ],
        &Access.key(&1, %{})
      ),
      "Exit!"
    )
  end

  def get(:atom_maze) do
    put_in(
      %{},
      Enum.map(
        [
          :south,
          :east,
          :north,
          :east,
          :south,
          :west,
          :north,
          :east,
          :south,
          :east,
          :north,
          :west,
          :south,
          :west,
          :south,
          :west,
          :north,
          :west,
          :south,
          :west,
          :south,
          :west,
          :south,
          :east,
          :north,
          :east,
          :south,
          :east,
          :south
        ],
        &Access.key(&1, %{})
      ),
      "Exit!"
    )
  end

  @doc ~S"""
  iex> %Kino.JS.Live{} = Utils.graph(:big_o_notation)
  iex> %Kino.JS.Live{} = Utils.graph(:binary_search)
  iex> %Kino.JS.Live{} = Utils.graph(:comprehension_big_o)
  iex> %Kino.JS.Live{} = Utils.graph(:exponential_complexity)
  iex> %Kino.JS.Live{} = Utils.graph(:factorial_complexity)
  iex> %Kino.JS.Live{} = Utils.graph(:linear_complexity)
  iex> %Kino.JS.Live{} = Utils.graph(:pigeon_beats_internet)
  iex> %Kino.JS.Live{} = Utils.graph(:polynomial_complexity)
  """
  def graph(:big_o_notation) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "x", type: :quantitative)
      |> VegaLite.encode_field(:y, "y", type: :quantitative)
      |> VegaLite.transform(groupby: ["color"], extent: [2500, 6500])
      |> VegaLite.encode_field(:color, "type", title: "Big O Notation", type: :nominal)
      |> Kino.VegaLite.new()

    max_x = 5
    initial_x = 2

    linear = Enum.map(initial_x..max_x, &%{x: &1, y: &1, type: "O(n)"})
    constant = Enum.map(initial_x..max_x, &%{x: &1, y: 1, type: "O(1)"})
    polonomial = Enum.map(initial_x..max_x, &%{x: &1, y: &1 ** 2, type: "O(n^2)"})
    logarithmic = Enum.map(initial_x..max_x, &%{x: &1, y: :math.log2(&1), type: "O(log n)"})
    exponential = Enum.map(initial_x..max_x, &%{x: &1, y: 2 ** &1, type: "O(2^n)"})
    factorial = Enum.map(initial_x..max_x, &%{x: &1, y: Math.factorial(&1), type: "O(n!)"})

    Kino.VegaLite.push_many(widget, factorial)
    Kino.VegaLite.push_many(widget, exponential)
    Kino.VegaLite.push_many(widget, polonomial)
    Kino.VegaLite.push_many(widget, linear)
    Kino.VegaLite.push_many(widget, logarithmic)
    Kino.VegaLite.push_many(widget, constant)
    widget
  end

  def graph(:binary_search) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "number of elements", type: :quantitative)
      |> VegaLite.encode_field(:y, "time", type: :quantitative)
      |> VegaLite.transform(groupby: ["color"], extent: [2500, 6500])
      |> VegaLite.encode_field(:color, "type", title: "Big O Notation", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 500

    logn = for n <- init..max, do: %{"number of elements": n, time: :math.log2(n), type: "log(n)"}

    Kino.VegaLite.push_many(widget, logn)
    widget
  end

  def graph(:comprehension_big_o) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "number of elements", type: :quantitative)
      |> VegaLite.encode_field(:y, "time", type: :quantitative)
      |> VegaLite.transform(groupby: ["color"], extent: [2500, 6500])
      |> VegaLite.encode_field(:color, "type", title: "Number Of Generators", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 5

    n1 = for n <- init..max, do: %{"number of elements": n, time: n, type: "1"}
    n2 = for n <- init..max, do: %{"number of elements": n, time: n ** 2, type: "2"}
    n3 = for n <- init..max, do: %{"number of elements": n, time: n ** 3, type: "3"}
    n4 = for n <- init..max, do: %{"number of elements": n, time: n ** 4, type: "4"}

    Kino.VegaLite.push_many(widget, n1)
    Kino.VegaLite.push_many(widget, n2)
    Kino.VegaLite.push_many(widget, n3)
    Kino.VegaLite.push_many(widget, n4)
    widget
  end

  def graph(:exponential_complexity) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "x", type: :quantitative)
      |> VegaLite.encode_field(:y, "y", type: :quantitative)
      |> VegaLite.transform(groupby: ["color"], extent: [2500, 6500])
      |> VegaLite.encode_field(:color, "type", title: "Exponential Growth", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 10

    exponential = for n <- init..max, do: %{x: n, y: 10 ** n, type: "2^n"}

    Kino.VegaLite.push_many(widget, exponential)
    widget
  end

  def graph(:factorial_complexity) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "x", type: :quantitative)
      |> VegaLite.encode_field(:y, "y", type: :quantitative)
      |> VegaLite.transform(groupby: ["color"], extent: [2500, 6500])
      |> VegaLite.encode_field(:color, "type", title: "Factorial Growth", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 5

    factorial = for n <- init..max, do: %{x: n, y: Math.factorial(n), type: "n!"}

    Kino.VegaLite.push_many(widget, factorial)
    widget
  end

  def graph(:linear_complexity) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "number of elements", type: :quantitative)
      |> VegaLite.encode_field(:y, "time", type: :quantitative)
      |> VegaLite.encode_field(:color, "type", title: "Linear Growth", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 100

    linear = for n <- init..max, do: %{"number of elements": n, time: n, type: "O(n)"}

    Kino.VegaLite.push_many(widget, linear)
    widget
  end

  def graph(:pigeon_beats_internet) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "data", type: :quantitative)
      |> VegaLite.encode_field(:y, "time", type: :quantitative)
      |> VegaLite.encode_field(:color, "type", title: "Linear Growth", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 200

    internet = for n <- init..max, do: %{data: n, time: n, type: "Internet"}
    pigeon = for n <- init..max, do: %{data: n, time: 100, type: "Pigeon"}

    Kino.VegaLite.push_many(widget, internet)
    Kino.VegaLite.push_many(widget, pigeon)
    widget
  end

  def graph(:polynomial_complexity) do
    size = 600

    widget =
      VegaLite.new(width: size, height: size)
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "number of elements", type: :quantitative)
      |> VegaLite.encode_field(:y, "time", type: :quantitative)
      |> VegaLite.transform(groupby: ["color"], extent: [2500, 6500])
      |> VegaLite.encode_field(:color, "type", title: "Polonomial Growth", type: :nominal)
      |> Kino.VegaLite.new()

    init = 1
    max = 5

    n2 = for n <- init..max, do: %{"number of elements": n, time: n ** 2, type: "n^2"}
    n3 = for n <- init..max, do: %{"number of elements": n, time: n ** 3, type: "n^3"}
    n4 = for n <- init..max, do: %{"number of elements": n, time: n ** 4, type: "n^4"}

    Kino.VegaLite.push_many(widget, n2)
    Kino.VegaLite.push_many(widget, n3)
    Kino.VegaLite.push_many(widget, n4)
    widget
  end

  @doc """
  Display a list of slides.
  iex> %Kino.JS.Live{} = Utils.slide(:case)
  iex> %Kino.JS.Live{} = Utils.slide(:cond)
  iex> %Kino.JS.Live{} = Utils.slide(:functions)
  iex> %Kino.JS.Live{} = Utils.slide(:recursion)
  iex> %Kino.JS.Live{} = Utils.slide(:reduce)
  """
  def slide(:case) do
    [
      "
We create a case statement.
```elixir
case \"snowy\" do
  \"sunny\" -> \"wear a t-shirt\"
  \"rainy\" -> \"wear a rain jacket\"
  \"cold\" -> \"wear a sweater\"
  \"snowy\" -> \"wear a thick coat\"
end
```
  ",
      "
Check if snowy equals sunny.
```elixir
case \"snowy\" do
  \"snowy\" === \"sunny\" -> \"wear a t-shirt\"
  \"rainy\" -> \"wear a rain jacket\"
  \"cold\" -> \"wear a sweater\"
  \"snowy\" -> \"wear a thick coat\"
end
```
  ",
      "
It's false, so check if snowy equals rainy.
```elixir
case \"snowy\" do
  false -> \"wear a t-shirt\"
  \"snowy\" === \"rainy\" -> \"wear a rain jacket\"
  \"cold\" -> \"wear a sweater\"
  \"snowy\" -> \"wear a thick coat\"
end
```
  ",
      "
It's false, so check if snowy equals cold.```elixir
```elixir
case \"snowy\" do
  false -> \"wear a t-shirt\"
  false -> \"wear a rain jacket\"
  \"snowy\" === \"cold\" -> \"wear a sweater\"
  \"snowy\" -> \"wear a thick coat\"
end
```
  ",
      "
It's false, so check if snowy equals snowy.```elixir
```elixir
case \"snowy\" do
  false -> \"wear a t-shirt\"
  false -> \"wear a rain jacket\"
  false -> \"wear a sweater\"
  \"snowy\" === \"snowy\" -> \"wear a thick coat\"
end
```
  ",
      "
snowy equals snowy.
```elixir
case \"snowy\" do
  false -> \"wear a t-shirt\"
  false -> \"wear a rain jacket\"
  false -> \"wear a sweater\"
  true -> \"wear a thick coat\"
end
```
  ",
      "
Return wear a thick coat.
```elixir




          \"wear a thick coat\"

```
  "
    ]
    |> Enum.map(&Kino.Markdown.new/1)
    |> Kino.Slide.new()
  end

  def slide(:cond) do
    [
      "
Check if plant is dead.
```elixir
daylight = true
days_since_watered = 14
plant = \"healthy\"

cond do
  plant === \"dead\" -> \"get a new plant\"
  plant === \"wilting\" && !daylight -> \"use a UV light\"
  plant === \"wilting\" && daylight -> \"put the plant in sunlight\"
  days_since_watered >= 14 -> \"water the plant\"
end
```
 ",
      "
`false`, so check if plant is wilting and it's dark.
```elixir
daylight = true
days_since_watered = 14
plant = \"healthy\"

cond do
  false -> \"get a new plant\"
  plant === \"wilting\" && !daylight -> \"use a UV light\"
  plant === \"wilting\" && daylight -> \"put the plant in sunlight\"
  days_since_watered >= 14 -> \"water the plant\"
end
```
 ",
      "
`false`, so check if plant is wilting and it's sunny.
```elixir
daylight = true
days_since_watered = 14
plant = \"healthy\"

cond do
  false -> \"get a new plant\"
  false -> \"use a UV light\"
  plant === \"wilting\" && daylight -> \"put the plant in sunlight\"
  days_since_watered >= 14 -> \"water the plant\"
end
```
 ",
      "
`false`, so check if days_since_watered is >= 14.
```elixir
daylight = true
days_since_watered = 14
plant = \"healthy\"

cond do
  false -> \"get a new plant\"
  false -> \"use a UV light\"
  false -> \"put the plant in sunlight\"
  days_since_watered >= 14 -> \"water the plant\"
end
```
 ",
      "
`true`! days_since_watered is >= 14.
```elixir
daylight = true
days_since_watered = 14
plant = \"healthy\"

cond do
  false -> \"get a new plant\"
  false -> \"use a UV light\"
  false -> \"put the plant in sunlight\"
  true -> \"water the plant\"
end
```
 ",
      "
Water the plant.
```elixir








          \"water the plant\"

```
 "
    ]
    |> Enum.map(&Kino.Markdown.new/1)
    |> Kino.Slide.new()
  end

  def slide(:functions) do
    [
      "
  First, we define the `double` function and call it.
  ```elixir
  double = fn number -> number * 2 end
  double.(3)
  ```
  ",
      "
  The `double` function executes in place of the `double.(call)` with `number` bound to `3`.
  ```elixir
  double = fn number -> number * 2 end
  fn 3 -> 3 * 2 end
  ```
  ",
      "
  The function evaluates the function body between the `->` and the `end`
  ```elixir
  double = fn number -> number * 2 end
  3 * 2
  ```
  ",
      "
  `3` * `2` is `6`, so the function call returns `6`.
  ```elixir
  double = fn number -> number * 2 end
  6
  ```
  "
    ]
    |> Enum.map(&Kino.Markdown.new/1)
    |> Kino.Slide.new()
  end

  def slide(:recursion) do
    [
      "
The base case would return the accumulator when the list is empty.
```elixir
defmodule Recursion do
    def sum([], accumulator), do: accumulator



end


```
",
      "
Otherwise, we'll add the head to an accumulator and recurse on the tail of the list.
```elixir
defmodule Recursion do
    def sum([], accumulator), do: accumulator
    def sum([head | tail], accumulator do
        sum(tail, accumulator + head)
    end
end

Recursion.sum([4, 5, 6], 0)
```
",
      "
The `sum/2` function is called with the list `[4, 5, 6]`.
```elixir
defmodule Recursion do
    def sum([], accumulator), do: accumulator
    def sum([4 | [5, 6]], 0) do
        sum([5, 6], 4 + 0)
    end
end

Recursion.sum([4, 5, 6], 0)
```
",
      "
The `sum/2` function is called again on the tail of the list `[5, 6]`.
```elixir
defmodule Recursion do
    def sum([], accumulator), do: accumulator
    def sum([5 | [6]], 4) do
        sum([6], 5 + 4)
    end
end

Recursion.sum([4, 5, 6], 0)
```
",
      "
The `sum/2` function is called again on the tail of the list `[6]`.
```elixir
defmodule Recursion do
    def sum([], accumulator), do: accumulator
    def sum([6 | []], 9) do
        sum([], 6 + 9)
    end
end

Recursion.sum([4, 5, 6], 0)
```
",
      "
The `sum/2` function is called again on the tail of the list `[]`. This triggers the base case to return the accumulator.
```elixir
defmodule Recursion do
    def sum([], 15), do: 15
    def sum([head | tail], accumulator) do
        sum(tail, accumulator + head)
    end
end

Recursion.sum([4, 5, 6], 0)
```
",
      "
And our function returns `15`.
```elixir
defmodule Recursion do
    def sum([], accumulator), do: accumulator
    def sum([head | tail], accumulator) do
        sum(tail, accumulator + head)
    end
end

15
```
"
    ]
    |> Enum.map(&Kino.Markdown.new/1)
    |> Kino.Slide.new()
  end

  def slide(:reduce) do
    [
      "
First, we define the call the `Enum.reduce/2` function with a list, and a function.
```elixir
Enum.reduce([1, 2, 3, 4], fn integer, accumulator -> integer + accumulator  end)
```
",
      "
The first element in the list `1` is the initial accumulator value.
```elixir
Enum.reduce([2, 3, 4], fn integer, 1 -> integer + 1  end)
```
",
      "
The function is called on the next element `2`. The next accumulator is 2 + 1
```elixir
Enum.reduce([3, 4], fn 2, 1 -> 2 + 1  end)
```
",
      "
The function is called on the next element `3`. The next accumulator is 3 + 3
```elixir
Enum.reduce([4], fn 3, 3 -> 3 + 3  end)
```
",
      "
The function is called on the next element `4`. The next accumulator is 4 + 6
```elixir
Enum.reduce([], fn 4, 6 -> 4 + 6  end)
```
",
      "
4 + 6 equals 10.
```elixir
Enum.reduce([], fn 4, 6 -> 10  end)
```
",
      "
`10` is the last accumulator value, so `Enum.reduce/2` returns `10`.
```elixir
                           10
```
"
    ]
    |> Enum.map(&Kino.Markdown.new/1)
    |> Kino.Slide.new()
  end

  @doc """
  Create a Data Table

  iex> %Kino.JS.Live{} = Utils.table(:exponential_growth)
  iex> %Kino.JS.Live{} = Utils.table(:factorial_complexity)
  iex> %Kino.JS.Live{} = Utils.table(:fib_cache)
  iex> %Kino.JS.Live{} = Utils.table(:lists_vs_tuples)
  iex> %Kino.JS.Live{} = Utils.table(:n2)
  iex> %Kino.JS.Live{} = Utils.table(:n3)
  iex> %Kino.JS.Live{} = Utils.table(:unicode)
  iex> %Kino.JS.Live{} = Utils.table(:users_and_photos)
  """

  def table(:exponential_growth) do
    Enum.map(1..100, fn each ->
      %{
        "# of elements": each,
        result: 10 ** each,
        equation: "100 ** #{each}"
      }
    end)
    |> Kino.DataTable.new()
  end

  def table(:factorial_complexity) do
    Enum.map(1..10, fn each ->
      equation =
        Enum.map(each..1, fn
          ^each -> "#{each}"
          n -> " * #{n}"
        end)
        |> Enum.join()

      %{"# of elements": each, result: each ** each, equation: equation}
    end)
    |> Kino.DataTable.new()
  end

  def table(:fib_cache) do
    defmodule Fib do
      def get(n) do
        sequence =
          Stream.unfold({1, 1}, fn {a, b} ->
            {a, {b, a + b}}
          end)
          |> Enum.take(n)

        [0 | sequence]
      end
    end

    data =
      Fib.get(150)
      |> Enum.with_index()
      |> Enum.map(fn {value, index} -> %{input: index, output: value} end)

    Kino.DataTable.new(data)
  end

  def table(:lists_vs_tuples) do
    Kino.DataTable.new(
      [
        %{operation: "length", tuple: "O(1)", list: "O(n)"},
        %{operation: "prepend", tuple: "O(n)", list: "O(1)"},
        %{operation: "insert", tuple: "O(n)", list: "O(n*)"},
        %{operation: "access", tuple: "O(1)", list: "O(n*)"},
        %{operation: "update/replace", tuple: "O(n)", list: "O(n*)"},
        %{operation: "delete", tuple: "O(n)", list: "O(n*)"},
        %{operation: "concatenation", tuple: "O(n1 + n2)", list: "O(n1)"}
      ],
      keys: [:operation, :tuple, :list]
    )
  end

  def table(:n2) do
    Enum.map(1..1000, fn each ->
      %{
        "# of elements": each,
        result: each ** 2,
        notation: "#{each}**2",
        equation: "#{each} * #{each}"
      }
    end)
    |> Kino.DataTable.new()
  end

  def table(:n3) do
    Enum.map(1..1000, fn each ->
      %{
        "# of elements": each,
        result: each ** 3,
        notation: "#{each}**3",
        equation: "#{each} * #{each} * #{each}"
      }
    end)
    |> Kino.DataTable.new()
  end

  def table(:unicode) do
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    |> String.codepoints()
    |> Enum.map(fn char ->
      <<code_point::utf8>> = char
      %{character: char, code_point: code_point}
    end)
    |> Kino.DataTable.new()
  end

  def table(:users_and_photos) do
    Kino.DataTable.new([[id: 1, image: "daily-bugel-photo.jpg"]], name: "Photos") |> Kino.render()
    Kino.DataTable.new([[id: 2, name: "Peter Parker"]], name: "Users")
  end

  @doc ~S"""
  iex> Utils.test(:naming_numbers, fn int -> Enum.at(["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"], int) end)
  """
  def test(:naming_numbers, convert_to_named_integer) do
    ExUnit.start(auto_run: false)

    :persistent_term.put(:convert_to_named_integer, convert_to_named_integer)

    defmodule NamingNumbers do
      use ExUnit.Case

      test "convert_to_named_integer" do
        answer_key = [
          {0, "zero"},
          {1, "one"},
          {2, "two"},
          {3, "three"},
          {4, "four"},
          {5, "five"},
          {6, "six"},
          {7, "seven"},
          {8, "eight"},
          {9, "nine"}
        ]

        convert_to_named_integer = :persistent_term.get(:convert_to_named_integer)

        Enum.each(answer_key, fn {key, value} ->
          assert convert_to_named_integer.(key) === value
        end)
      end
    end

    ExUnit.run()
  end

  def test(:file_copy_challenge) do
    ExUnit.start(auto_run: false)

    defmodule CopyExample do
      use ExUnit.Case

      test "file was copied" do
        assert File.read("data/copied_example") === "Copy me!"
      end
    end

    ExUnit.run()
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
    Kino.Image.new(File.read!(__DIR__ <> content), :png)
  end

  def visual(:comparison_examples) do
    Kino.DataTable.new([
      %{comparison: "5 === 5", result: true},
      %{comparison: "5 === 5.0", result: false},
      %{comparison: "5 == 5.0", result: true},
      %{comparison: "5 === 4", result: false},
      %{comparison: "5 > 4", result: true},
      %{comparison: "4 > 5", result: false},
      %{comparison: "5 < 4", result: false},
      %{comparison: "4 < 5", result: true},
      %{comparison: "5 >= 5", result: true},
      %{comparison: "5 >= 4", result: true},
      %{comparison: "4 >= 5", result: false},
      %{comparison: "5 <= 5", result: true},
      %{comparison: "4 <= 5", result: true},
      %{comparison: "5 <= 4", result: false}
    ])
  end
end

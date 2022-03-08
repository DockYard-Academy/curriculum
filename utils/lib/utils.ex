defmodule Utils do
  @moduledoc """
  Documentation for `Utils`.
  """
  alias Utils.ValidatedForm

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
  iex> %Kino.JS{} = Utils.form(:comparison_operators)
  iex> %Kino.JS{} = Utils.form(:boolean_fill_in_the_blank)
  """

  def form(:comparison_operators) do
    ValidatedForm.new([
      %{label: "7 __ 8", answers: ["<"]},
      %{label: "8 __ 7", answers: [">"]},
      %{label: "8 __ 8 and 9 __ 9 and not 10 __ 10.0", answers: ["==="]},
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

  @doc ~S"""
  iex> %{"west" => _} = Utils.get(:string_maze)
  iex> %{south: _} = Utils.get(:atom_maze)
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
  iex> :ok = Utils.graph(:binary_search)
  iex> :ok = Utils.graph(:comprehension_big_o)
  """
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
      |> Kino.render()

    init = 1
    max = 500

    logn = for n <- init..max, do: %{"number of elements": n, time: :math.log2(n), type: "log(n)"}

    Kino.VegaLite.push_many(widget, logn)
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
      |> Kino.render()

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
  end

  @doc """
  Display a LiveSlide.
  iex> %Kino.JS.Live{module: LiveSlide} = Utils.slide(:case)
  iex> %Kino.JS.Live{module: LiveSlide} = Utils.slide(:cond)
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
    |> LiveSlide.new()
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
    |> LiveSlide.new()
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

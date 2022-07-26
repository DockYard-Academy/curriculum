defmodule Utils.Slide do
  @moduledoc false

  def case do
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
It's false, so check if snowy equals cold.
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
It's false, so check if snowy equals snowy.
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

  def cond do
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

  def functions do
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

  def reduce do
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
end

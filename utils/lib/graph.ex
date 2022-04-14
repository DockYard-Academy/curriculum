defmodule Utils.Graph do
  def big_o_notation do
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

  def binary_search do
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

  def comprehension_big_o do
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

  def exponential_complexity do
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

  def factorial_complexity do
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

  def linear_complexity do
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

  def pigeon_beats_internet do
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

  def polynomial_complexity do
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
end

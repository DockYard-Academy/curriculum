defmodule Utils.Graph do
  defp factorial(0), do: 1

  defp factorial(n) when n > 0 do
    Enum.reduce(1..n, &*/2)
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

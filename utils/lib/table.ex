defmodule Utils.Table do
  def comparison_examples do
    [
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
    ]
  end

  def example do
    Enum.map(1..5, fn each ->
      %{
        number: each
      }
    end)
  end

  def exponential_growth do
    Enum.map(1..100, fn each ->
      %{
        "# of elements": each,
        result: 10 ** each,
        equation: "100 ** #{each}"
      }
    end)
  end

  def factorial_complexity do
    Enum.map(1..10, fn each ->
      equation =
        Enum.map_join(each..1, fn
          ^each -> "#{each}"
          n -> " * #{n}"
        end)

      %{"# of elements": each, result: each ** each, equation: equation}
    end)
  end

  def fib_cache do
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

    Fib.get(150)
    |> Enum.with_index()
    |> Enum.map(fn {value, index} -> %{input: index, output: value} end)
  end

  def lists_vs_tuples do
    [
      [operation: "length", tuple: "O(1)", list: "O(n)"],
      [operation: "prepend", tuple: "O(n)", list: "O(1)"],
      [operation: "insert", tuple: "O(n)", list: "O(n*)"],
      [operation: "access", tuple: "O(1)", list: "O(n*)"],
      [operation: "update/replace", tuple: "O(n)", list: "O(n*)"],
      [operation: "delete", tuple: "O(n)", list: "O(n*)"],
      [operation: "concatenation", tuple: "O(n1 + n2)", list: "O(n1)"]
    ]
  end

  def n2 do
    Enum.map(1..1000, fn each ->
      %{
        "# of elements": each,
        result: each ** 2,
        notation: "#{each}**2",
        equation: "#{each} * #{each}"
      }
    end)
  end

  def n3 do
    Enum.map(1..1000, fn each ->
      %{
        "# of elements": each,
        result: each ** 3,
        notation: "#{each}**3",
        equation: "#{each} * #{each} * #{each}"
      }
    end)
  end

  def unicode do
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    |> String.codepoints()
    |> Enum.map(fn char ->
      <<code_point::utf8>> = char
      %{character: char, code_point: code_point}
    end)
  end

  def measurements do
    [
      [unit: :millimeter, value: 1, centimeter: 0.1],
      [unit: :meter, value: 1, centimeter: 100],
      [unit: :kilometer, value: 1, centimeter: 100_000],
      [unit: :inch, value: 1, centimeter: 2.54],
      [unit: :feet, value: 1, centimeter: 30],
      [unit: :yard, value: 1, centimeter: 91],
      [unit: :mile, value: 1, centimeter: 160_000]
    ]
  end

  def code_points do
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    |> String.codepoints()
    |> Enum.map(fn char ->
      <<code_point::utf8>> = char
      %{character: char, code_point: code_point}
    end)
  end

  def base_2_10_comparison do
    Enum.map(1..500, fn integer ->
      binary = Integer.digits(integer, 2) |> Enum.join() |> String.to_integer()
      %{base10: integer, base2: binary}
    end)
  end

  def hexadecimal do
    "1,2,3,4,5,6,7,8,9,10,a,b,c,d,e,f"
    |> String.split(",")
    |> Enum.with_index()
    |> Enum.map(fn {symbol, index} -> %{integer: "#{index}", hexadecimal: symbol} end)
  end
end

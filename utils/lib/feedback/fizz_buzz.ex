defmodule Utils.Feedback.FizzBuzz do
  use Utils.Feedback.Assertion

  feedback :fizzbuzz do
    fizz_buzz_module = get_answers()

    assert fizz_buzz_module.run(1..15) == [
             1,
             2,
             "fizz",
             4,
             "buzz",
             "fizz",
             7,
             8,
             "fizz",
             "buzz",
             11,
             "fizz",
             13,
             14,
             "fizzbuzz"
           ]
  end

  defmodule FizzBuzz do
    def run(range) do
      Enum.map(range, fn integer ->
        cond do
          rem(integer, 15) == 0 -> "fizzbuzz"
          rem(integer, 5) == 0 -> "buzz"
          rem(integer, 3) == 0 -> "fizz"
          true -> integer
        end
      end)
    end
  end

  def fizzbuzz do
    FizzBuzz
  end
end

defmodule Utils.Feedback.FunFormulas do
  use Utils.Feedback.Assertion

  feedback :percentage do
    [completed_items, total_items, percentage] = get_answers()

    assert percentage == completed_items / total_items * 100
  end

  feedback :pythagorean_c_square do
    c_square = get_answers()
    assert c_square == 10 ** 2 + 10 ** 2
  end

  feedback :pythagorean_c do
    c = get_answers()
    assert c == :math.sqrt(200)
  end

  feedback :rocket_ship, ignore: true do
    force = get_answers()
    assert force == 20
  end

  feedback :tip_amount do
    [cost_of_the_meal, tip_rate, tip_amount] = get_answers()
    assert tip_rate == 0.20, "tip rate should be 0.2."
    assert cost_of_the_meal == 55.5, "cost_of_the_meal should be 55.5."

    assert tip_amount === cost_of_the_meal * tip_rate,
           "tip_amount should be cost_of_the_meal * tip_rate."
  end

  def pythagorean_c do
    :math.sqrt(200)
  end

  def pythagorean_c_square do
    10 ** 2 + 10 ** 2
  end

  def percentage do
    completed_items = 10
    total_items = 100
    percentage = completed_items / total_items * 100
    [completed_items, total_items, percentage]
  end

  def tip_amount do
    cost_of_the_meal = 55.5
    tip_rate = 0.2

    tip_amount = cost_of_the_meal * tip_rate

    [cost_of_the_meal, tip_rate, tip_amount]
  end
end

defmodule Utils.Feedback.CardCounting do
  use Utils.Feedback.Assertion

  feedback :card_count_four, ignore: true do
    next_count = get_answers()
    assert next_count == 1
  end

  feedback :card_count_king, ignore: true do
    next_count = get_answers()
    assert next_count === 4
  end

  feedback :card_count_random do
    [card, next_count] = get_answers()

    cond do
      card in 2..6 ->
        assert next_count === 1

      card in 7..9 ->
        assert next_count === 0

      card in 10..14 ->
        assert next_count === -1

      true ->
        raise "Something went wrong. Please reset the exercise."
    end
  end

  def card_count_random do
    random_card = Utils.random(2..14)

    count = 0

    next_count = (random_card <= 6 && count + 1) || (random_card >= 10 && count - 1) || count
    [random_card, next_count]
  end
end

defmodule Utils.Feedback do
  @moduledoc """
  Utils.Feedback defines tests using the `feedback` macro.
  Each `feedback` macro creates an associated Utils.feedback function and
  ensures that each has a corresponding solution in Utils.Solutions.

  ## Examples

  ```elixir
  feedback :example do
    answer = get_answers()
    assert answer == 5
  end
  ```

  Creates a a Utils.feedback(:example, answers) function clause.
  """
  use Utils.Feedback.Assertion

  feedback :string_concatenation do
    answer = get_answers()
    assert is_binary(answer), "the answer should be a string."
    assert "Hi, " <> _name = answer, "the answer should be in the format: Hi, name."
    assert Regex.match?(~r/Hi, \w+\./, answer), "the answer should end in a period."
  end

  feedback :string_interpolation do
    answer = get_answers()
    assert is_binary(answer), "the answer should be a string."

    assert Regex.match?(~r/I have/, answer),
           "the answer should be in the format: I have 10 classmates"

    assert Regex.match?(~r/I have \d+/, answer),
           "the answer should contain an integer for classmates."

    assert Regex.match?(~r/I have \d+ classmates\./, answer) ||
             answer === "I have 1 classmate.",
           "the answer should end in a period."
  end

  feedback :rock_paper_scissors_pattern_matching do
    rock_paper_scissors = get_answers()

    assert rock_paper_scissors.play(:rock, :rock) == "draw!",
           "Ensure you implement the RockPaperScissors.play/2 function."

    assert rock_paper_scissors.play(:paper, :paper) == "draw!"
    assert rock_paper_scissors.play(:scissors, :scissors) == "draw!"

    assert rock_paper_scissors.play(:rock, :scissors) == ":rock beats :scissors!"
    assert rock_paper_scissors.play(:scissors, :paper) == ":scissors beats :paper!"
    assert rock_paper_scissors.play(:paper, :rock) == ":paper beats :rock!"

    assert rock_paper_scissors.play(:rock, :paper) == ":paper beats :rock!"
    assert rock_paper_scissors.play(:scissors, :rock) == ":rock beats :scissors!"
    assert rock_paper_scissors.play(:paper, :scissors) == ":scissors beats :paper!"
  end

  feedback :startup_madlib do
    [
      madlib,
      name_of_company,
      a_defined_offering,
      a_defined_audience,
      solve_a_problem,
      secret_sauce
    ] = answers = get_answers()

    assert Enum.all?(answers, fn each -> is_binary(each) and String.length(each) > 0 end),
           "each variable should be bound to a non-empty string"

    assert madlib ==
             "My company, #{name_of_company}, is developing #{a_defined_offering} to help #{a_defined_audience} #{solve_a_problem} with #{secret_sauce}."
  end

  feedback :nature_show_madlib do
    [
      animal,
      country,
      plural_noun,
      a_food,
      type_of_screen_device,
      noun,
      verb1,
      verb2,
      adjective,
      madlib
    ] = answers = get_answers()

    assert Enum.all?(answers, fn each -> is_binary(each) and String.length(each) > 0 end),
           "each variable should be bound to a non-empty string"

    assert madlib ==
             "The majestic #{animal} has roamed the forests of #{country} for thousands of years. Today she wanders in search of #{plural_noun}. She must find food to survive. While hunting for #{a_food}, she found a/an #{type_of_screen_device} hidden behind a #{noun}. She has never seen anything like this before. What will she do? With the device in her teeth, she tries to #{verb1}, but nothing happens. She takes it back to her family. When her family sees it, they quickly #{verb2}. Soon, the device becomes #{adjective}, and the family decides to put it back where they found it."
  end

  feedback :copy_file do
    file_name = get_answers()
    assert {:ok, "Copy me!"} = File.read("../data/#{file_name}")
  end

  feedback :item_generator_search do
    search = get_answers()
    items = [Utils.Factory.item(%{}), Utils.Factory.item()]
    result = search.all_items(items, [])
    assert result, "Implement the `all_items/2` function."
    assert is_list(result), "`all_items/2` should return a list."

    assert length(result) == 2,
           "`all_items/2` should return all items when no filters are provided."

    assert Enum.sort(items) == Enum.sort(result),
           "`all_items/2` should return all items when no filters are provided."

    [item1, _] = items = [Utils.Factory.item(%{type: "a"}), Utils.Factory.item(%{type: "b"})]
    result = search.all_items(items, type: "a")
    assert result == [item1], "`all_items/2` should filter by type."

    [item1, _] = items = [Utils.Factory.item(%{effect: "a"}), Utils.Factory.item(%{effect: "b"})]

    result = search.all_items(items, effect: "a")
    assert result == [item1], "`all_items/2` should filter by type."

    [item1, _] = items = [Utils.Factory.item(%{style: "a"}), Utils.Factory.item(%{style: "b"})]

    result = search.all_items(items, style: "a")
    assert result == [item1], "`all_items/2` should filter by style."

    [item1, _] = items = [Utils.Factory.item(%{size: 1}), Utils.Factory.item(%{size: 2})]
    result = search.all_items(items, size: 1)
    assert result == [item1], "`all_items/2` should filter by size."

    [item1, _] = items = [Utils.Factory.item(%{level: 1}), Utils.Factory.item(%{level: 2})]
    result = search.all_items(items, level: 1)
    assert result == [item1], "`all_items/2` should filter by level."

    [item1, item2] = items = [Utils.Factory.item(), Utils.Factory.item(%{level: 2})]

    result =
      search.all_items(items,
        type: item1.type,
        effect: item1.effect,
        style: item1.style,
        size: item1.size,
        level: item1.level
      )

    assert result == [item1], "`all_items/2` should work with multiple filters."

    result =
      search.all_items(items,
        type: item1.type,
        effect: item1.effect,
        style: item1.style,
        size: item1.size,
        level: item2.level,
        inclusive: true
      )

    assert Enum.sort(result) == Enum.sort([item1, item2]),
           "`all_items/2` should work with multiple inclusive filters."
  end

  feedback :voter_tally do
    voter_tally = get_answers()
    assert voter_tally.tally([]), "Implement the `tally/1` function."
    assert is_map(voter_tally.tally([])), "`tally/1` should return a map."
    assert voter_tally.tally([:dogs, :cats]) == %{dogs: 1, cats: 1}
    assert voter_tally.tally([:dogs, :dogs, :cats]) == %{dogs: 2, cats: 1}

    votes = Enum.map(1..10, fn _ -> Enum.random([:cats, :dogs, :birds]) end)

    expected_result =
      Enum.reduce(votes, %{}, fn each, acc ->
        Map.update(acc, each, 1, fn existing_value -> existing_value + 1 end)
      end)

    assert voter_tally.tally(votes) == expected_result
  end

  feedback :voter_power do
    voter_tally = get_answers()
    assert voter_tally.tally([]), "Implement the `tally/1` function."
    assert is_map(voter_tally.tally([])), "`tally/1` should return a map."
    assert voter_tally.tally(dogs: 2) == %{dogs: 2}
    assert voter_tally.tally(dogs: 2, cats: 1) == %{dogs: 2, cats: 1}
    assert voter_tally.tally([:cats, dogs: 2]) == %{dogs: 2, cats: 1}

    assert voter_tally.tally([:dogs, :cats, birds: 3, dogs: 10]) == %{dogs: 11, cats: 1, birds: 3}
  end

  feedback :keyword_list_hero do
    hero = get_answers()

    assert [name: _, secret_identity: _] = hero,
           "Ensure hero is a keyword list with :name and :secret_identity."
  end

  feedback :string_key_map do
    map = get_answers()

    assert is_map(map), "Ensure you use %{} to create a map."
    assert map_size(map) > 0, "Ensure your map is not empty."
    assert Enum.all?(Map.keys(map), &is_binary/1), "Ensure your map contains only string keys."
  end

  feedback :atom_key_map do
    map = get_answers()

    assert is_map(map), "Ensure you use %{} to create a map."
    assert map_size(map) > 0, "Ensure your map is not empty."
    assert Enum.all?(Map.keys(map), &is_atom/1), "Ensure your map contains only atom keys."
  end

  feedback :non_standard_key_map do
    map = get_answers()

    assert is_map(map), "Ensure you use %{} to create a map."
    assert map_size(map) > 0, "Ensure your map is not empty."

    assert Enum.all?(Map.keys(map), fn key -> !is_atom(key) and !is_binary(key) end),
           "Ensure your map contains only non-atom and non-string keys."
  end

  feedback :access_map do
    value = get_answers()
    assert value == "world"
  end

  feedback :update_map do
    updated_map = get_answers()
    assert is_map(updated_map), "Ensure `updated_map` is a map."

    assert Map.has_key?(updated_map, :example_key),
           "Ensure `updated_map` still has the `:example_key`"

    assert %{example_key: _} = updated_map

    assert updated_map.example_key !== "value",
           "Ensure you update the :example_key with a changed value."
  end

  feedback :remainder do
    remainder = get_answers()
    assert remainder == rem(10, 3)
  end

  feedback :exponents do
    result = get_answers()
    assert result == 10 ** 214
  end

  feedback :bedmas do
    answer = get_answers()
    assert answer == (20 + 20) * 20
  end

  feedback :gcd do
    gcd = get_answers()
    assert gcd == Integer.gcd(10, 15)
  end

  feedback :string_at do
    answer = get_answers()
    assert answer == "l"
  end

  feedback :merged_map do
    merged_map = get_answers()
    assert merged_map == %{one: 1, two: 2}
  end

  feedback :bingo_winner do
    bingo_winner = get_answers()

    row_win = ["X", "X", "X"]
    row_lose = [nil, nil, nil]

    # full board
    assert bingo_winner.is_winner?([row_win, row_win, row_win])

    # empty (losing) board
    refute bingo_winner.is_winner?([row_lose, row_lose, row_lose])

    # rows
    assert bingo_winner.is_winner?([row_win, row_lose, row_lose])
    assert bingo_winner.is_winner?([row_lose, row_win, row_lose])
    assert bingo_winner.is_winner?([row_lose, row_lose, row_win])

    # columns
    assert bingo_winner.is_winner?([["X", nil, nil], ["X", nil, nil], ["X", nil, nil]])
    assert bingo_winner.is_winner?([[nil, "X", nil], [nil, "X", nil], [nil, "X", nil]])
    assert bingo_winner.is_winner?([[nil, nil, "X"], [nil, nil, "X"], [nil, nil, "X"]])

    # diagonals
    assert bingo_winner.is_winner?([["X", nil, nil], [nil, "X", nil], [nil, nil, "X"]])
    assert bingo_winner.is_winner?([[nil, nil, "X"], [nil, "X", nil], ["X", nil, nil]])

    # losing boards (not fully comprehensive)
    losing_board =
      ["X", "X", nil, nil, nil, nil, nil, nil, nil] |> Enum.shuffle() |> Enum.chunk_every(3)

    refute bingo_winner.is_winner?(losing_board)
  end

  feedback :bingo do
    bingo = get_answers()

    numbers = Enum.to_list(1..9)
    [row1, row2, row3] = board = Enum.chunk_every(numbers, 3)
    [r1c1, r1c2, r1c3] = row1
    [r2c1, r2c2, r2c3] = row2
    [r3c1, r3c2, r3c3] = row3
    # rows
    assert bingo.is_winner?(board, row1)
    assert bingo.is_winner?(board, row2)
    assert bingo.is_winner?(board, row3)

    # columns
    assert bingo.is_winner?(board, [r1c1, r2c1, r3c1])
    assert bingo.is_winner?(board, [r1c2, r2c2, r3c2])
    assert bingo.is_winner?(board, [r1c3, r2c3, r3c3])

    # diagonals
    assert bingo.is_winner?(board, [r1c1, r2c2, r3c3])
    assert bingo.is_winner?(board, [r3c1, r2c2, r1c3])

    # losing (not fully comprehensive)
    refute bingo.is_winner?(board, numbers |> Enum.shuffle() |> Enum.take(2))
  end

  feedback :is_type do
    [
      is_a_map,
      is_a_bitstring,
      is_a_integer,
      is_a_float,
      is_a_boolean,
      is_a_list,
      is_a_tuple
    ] = get_answers()

    assert is_a_map, "Use the Kernel.is_map/1 function on `map`"
    assert is_a_bitstring, "Use the Kernel.is_binary/1 function on `bitstring`"
    assert is_a_integer, "Use the Kernel.is_integer/1 function on `integer`"
    assert is_a_float, "Use the Kernel.is_float/1 function on `float`"
    assert is_a_boolean, "Use the Kernel.is_boolean/1 function on `boolean`"
    assert is_a_list, "Use the Kernel.is_list/1 function on `list`"
    assert is_a_tuple, "Use the Kernel.is_tuple/1 function on `tuple`"
  end

  feedback :pipe_operator do
    answer = get_answers()
    assert answer
    assert is_integer(answer), "answer should be an integer"
    assert answer == 56
  end

  feedback :filter_by_type do
    filter = get_answers()

    input = [1, 2, 1.0, 2.0, :one, :two, [], [1], [1, 2], %{}, %{one: 1}, [one: 1], [two: 2]]

    assert filter.integers(input) == [1, 2]
    assert filter.floats(input) == [1.0, 2.0]
    assert filter.numbers(input) == [1, 2, 1.0, 2.0]
    assert filter.atoms(input) == [:one, :two]
    assert filter.lists(input) == [[], [1], [1, 2], [one: 1], [two: 2]]
    assert filter.maps(input) == [%{}, %{one: 1}]
    assert filter.keyword_lists(input) == [[], [one: 1], [two: 2]]
  end

  feedback :tic_tac_toe do
    tic_tac_toe = get_answers()

    board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    assert tic_tac_toe.play(board, {0, 0}, "X"), "Ensure you implement the `play/3` function."

    assert tic_tac_toe.play(board, {0, 0}, "X") == [
             ["X", nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    assert tic_tac_toe.play(board, {0, 2}, "X") == [
             [nil, nil, "X"],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    assert tic_tac_toe.play(board, {1, 1}, "X") == [
             [nil, nil, nil],
             [nil, "X", nil],
             [nil, nil, nil]
           ]

    assert tic_tac_toe.play(board, {2, 2}, "X") == [
             [nil, nil, nil],
             [nil, nil, nil],
             [nil, nil, "X"]
           ]

    assert board
           |> tic_tac_toe.play({0, 0}, "X")
           |> tic_tac_toe.play({1, 1}, "O")
           |> tic_tac_toe.play({2, 2}, "X")
           |> tic_tac_toe.play({2, 1}, "O") ==
             [
               ["X", nil, nil],
               [nil, "O", nil],
               [nil, "O", "X"]
             ]
  end

  feedback :datetime_new do
    date = get_answers()
    assert date == DateTime.new!(~D[1938-04-18], ~T[12:00:00])
  end

  feedback :datetime_today do
    today = get_answers()
    now = DateTime.utc_now()
    assert today.year == now.year
    assert today.month == now.month
    assert today.day == now.day

    assert today.hour == now.hour
    # Allowing 2 second adjustment for possible time delay
    assert DateTime.diff(now, today) < 2
  end

  feedback :datetime_tomorrow do
    tomorrow = get_answers()

    now = DateTime.utc_now()
    assert tomorrow.year == now.year
    assert tomorrow.month == now.month
    assert tomorrow.day == now.day + 1
    assert tomorrow.hour == now.hour
    # Allowing 2 second adjustment for possible time delay
    assert DateTime.diff(DateTime.add(now, 60 * 60 * 24, :second), tomorrow) < 2
  end

  feedback :datetime_compare do
    comparison = get_answers()

    assert comparison == :gt
  end

  feedback :datetime_diff do
    difference = get_answers()

    assert is_integer(difference), "`difference` should be a positive integer."
    assert difference != -318_384_000, "Ensure your arguments are in the correct order."
    assert difference == 318_384_000
  end

  feedback :itinerary do
    itinerary = get_answers()

    start = DateTime.utc_now()
    # four hours
    finish = DateTime.add(start, 60 * 60 * 4)

    assert itinerary.has_time?(start, finish, [])
    assert itinerary.has_time?(start, finish, hour: 0)
    assert itinerary.has_time?(start, finish, hour: 0, minute: 0)
    assert itinerary.has_time?(start, finish, hour: 3, minute: 59)
    assert itinerary.has_time?(start, finish, hour: 4)

    refute itinerary.has_time?(start, finish, hour: 5)
    refute itinerary.has_time?(start, finish, hour: 4, minute: 1)
  end

  feedback :timeline do
    timeline = get_answers()

    assert timeline.generate(["2022-04-24", "2022-04-24"]) == [0]
    assert timeline.generate(["2022-04-24", "2022-04-25"]) == [1]
    assert timeline.generate(["2022-04-24", "2022-05-24"]) == [30]
    assert timeline.generate(["2022-04-24", "2023-04-24"]) == [365]
    assert timeline.generate(["2022-04-24", "2023-05-24"]) == [395]
  end

  feedback :school_must_register do
    school_grades = get_answers()
    name = Faker.Person.first_name()

    assert school_grades.must_register([], 2022) == []

    assert school_grades.must_register([%{name: name, birthday: Date.new!(2017, 12, 31)}], 2022) ==
             [%{name: name, birthday: Date.new!(2017, 12, 31)}]

    assert school_grades.must_register([%{name: name, birthday: Date.new!(2018, 1, 1)}], 2022) ==
             []

    assert school_grades.must_register([%{name: name, birthday: Date.new!(2005, 12, 31)}], 2022) ==
             []

    assert school_grades.must_register([%{name: name, birthday: Date.new!(2006, 1, 1)}], 2022) ==
             [
               %{name: name, birthday: Date.new!(2006, 1, 1)}
             ]
  end

  feedback :school_grades do
    school = get_answers()
    name = Faker.Person.first_name()

    assert school.grades([], 2022), "Implement the `grades/2` function."
    assert school.grades([], 2022) == %{}

    assert school.grades([%{name: name, birthday: ~D[2016-01-01]}], 2022) == %{
             grade1: [%{name: name, birthday: ~D[2016-01-01]}]
           }

    assert school.grades([%{name: name, birthday: ~D[2015-01-01]}], 2022) == %{
             grade2: [%{name: name, birthday: ~D[2015-01-01]}]
           }

    assert school.grades([%{name: name, birthday: ~D[2014-01-01]}], 2022) == %{
             grade3: [%{name: name, birthday: ~D[2014-01-01]}]
           }

    assert school.grades([%{name: name, birthday: ~D[2013-01-01]}], 2022) == %{
             grade4: [%{name: name, birthday: ~D[2013-01-01]}]
           }

    assert school.grades([%{name: name, birthday: ~D[2012-01-01]}], 2022) == %{
             grade5: [%{name: name, birthday: ~D[2012-01-01]}]
           }

    students = [
      %{name: "Name1", birthday: ~D[2016-01-01]},
      %{name: "Name2", birthday: ~D[2016-12-31]},
      %{name: "Name3", birthday: ~D[2015-01-01]},
      %{name: "Name4", birthday: ~D[2015-12-31]},
      %{name: "Name5", birthday: ~D[2014-01-01]},
      %{name: "Name6", birthday: ~D[2014-12-31]},
      %{name: "Name7", birthday: ~D[2013-01-01]},
      %{name: "Name8", birthday: ~D[2013-12-31]},
      %{name: "Name9", birthday: ~D[2012-01-01]},
      %{name: "Name10", birthday: ~D[2012-12-31]}
    ]

    assert school.grades(students, 2022) ==
             %{
               grade1: [
                 %{name: "Name1", birthday: ~D[2016-01-01]},
                 %{name: "Name2", birthday: ~D[2016-12-31]}
               ],
               grade2: [
                 %{name: "Name3", birthday: ~D[2015-01-01]},
                 %{name: "Name4", birthday: ~D[2015-12-31]}
               ],
               grade3: [
                 %{name: "Name5", birthday: ~D[2014-01-01]},
                 %{name: "Name6", birthday: ~D[2014-12-31]}
               ],
               grade4: [
                 %{name: "Name7", birthday: ~D[2013-01-01]},
                 %{name: "Name8", birthday: ~D[2013-12-31]}
               ],
               grade5: [
                 %{name: "Name9", birthday: ~D[2012-01-01]},
                 %{name: "Name10", birthday: ~D[2012-12-31]}
               ]
             }

    assert school.grades(Enum.take(students, 8), 2023) == %{
             grade2: [
               %{name: "Name1", birthday: ~D[2016-01-01]},
               %{name: "Name2", birthday: ~D[2016-12-31]}
             ],
             grade3: [
               %{name: "Name3", birthday: ~D[2015-01-01]},
               %{name: "Name4", birthday: ~D[2015-12-31]}
             ],
             grade4: [
               %{name: "Name5", birthday: ~D[2014-01-01]},
               %{name: "Name6", birthday: ~D[2014-12-31]}
             ],
             grade5: [
               %{name: "Name7", birthday: ~D[2013-01-01]},
               %{name: "Name8", birthday: ~D[2013-12-31]}
             ]
           }
  end

  feedback :say_guards do
    say = get_answers()

    name = Faker.Person.first_name()
    assert say.hello(name), "Ensure you implement the `hello/1` function"
    assert say.hello(name) == "Hello, #{name}."

    assert_raise FunctionClauseError, fn ->
      say.hello(1) && flunk("Ensure you guard against non string values.")
    end
  end

  feedback :percent do
    percent = get_answers()

    assert percent.display(1), "Ensure you implement the `display/1` function"
    assert percent.display(0.1) == "0.1%"
    assert percent.display(100) == "100%"

    assert_raise FunctionClauseError, fn ->
      percent.display(0) && flunk("Ensure you guard against 0.")
    end

    assert_raise FunctionClauseError, fn ->
      percent.display(-1) && flunk("Ensure you guard negative numbers.")
    end

    assert_raise FunctionClauseError, fn ->
      percent.display(101) && flunk("Ensure you guard against numbers greater than 100.")
    end
  end

  feedback :case_match do
    case_match = get_answers()

    assert case_match != "default", "Ensure you replace `nil` with a value that matches [_, 2, 3]"
    assert case_match == "A"
  end

  feedback :hello_match do
    hello = get_answers()

    assert_raise FunctionClauseError, fn ->
      hello.everyone(nil) && flunk("Replace `nil` with your answer.")
    end

    assert hello.everyone(["name", "name", "name"]) == "Hello, everyone!"

    assert hello.everyone(["name", "name", "name", "name"]) == "Hello, everyone!",
           "list with 4 elements should match."

    assert_raise FunctionClauseError, fn ->
      hello.everyone([]) && flunk("Empty list should not match.")
    end

    assert_raise FunctionClauseError, fn ->
      hello.everyone(["name"]) && flunk("list with one element should not match.")
    end

    assert_raise FunctionClauseError, fn ->
      hello.everyone(["name", "name"]) && flunk("list with two elements should not match.")
    end
  end

  feedback :with_points do
    points = get_answers()

    assert points.tally([10, 20]) == 30
    assert points.tally([20, 20]) == 40
    assert points.tally(10) == {:error, :invalid}
    assert points.tally([]) == {:error, :invalid}
    assert points.tally([10]) == {:error, :invalid}
    assert points.tally([10, 20, 30]) == {:error, :invalid}
    assert points.tally([10, ""]) == {:error, :invalid}
    assert points.tally([1, 10]) == {:error, :invalid}
  end

  feedback :money do
    money = get_answers()

    assert Keyword.get(money.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`"

    assert match?(%{amount: nil, currency: nil}, struct(money)),
           "Ensure you use `defstruct` with :amount and :currency without enforcing keys."

    assert money.new(500, :CAD), "Ensure you implement the `new/1` function"
    assert is_struct(money.new(500, :CAD)), "Money.new/2 should return a `Money` struct"

    assert %{amount: 500, currency: :CAD} = money.new(500, :CAD),
           "Money.new(500, :CAD) should create a %Money{amount: 500, currency: :CAD} struct"

    assert %{amount: 500, currency: :EUR} = money.new(500, :EUR),
           "Money.new(500, :EUR) should create a %Money{amount: 500, currency: :EUR} struct"

    assert %{amount: 500, currency: :US} = money.new(500, :US),
           "Money.new(500, :US) should create a %Money{amount: 500, currency: :US} struct"

    assert money.convert(money.new(500, :CAD), :EUR) == money.new(round(500 / 1.39), :EUR)

    assert %{amount: 1000, currency: :CAD} = money.add(money.new(500, :CAD), money.new(500, :CAD))

    assert_raise FunctionClauseError, fn ->
      money.add(money.new(500, :CAD), money.new(100, :US)) &&
        flunk(
          "Money.add/2 should only accept the same currency type or throw a FunctionClauseError."
        )
    end

    assert money.subtract(money.new(10_000, :US), money.new(100, :US)) == money.new(9900, :US)

    assert_raise FunctionClauseError, fn ->
      money.subtract(money.new(500, :CAD), money.new(100, :US)) &&
        flunk(
          "Money.subtract/2 should only accept the same currency type or throw a FunctionClauseError."
        )
    end

    assert money.multiply(money.new(100, :CAD), 10) == money.new(1000, :CAD)
    assert money.multiply(money.new(100, :CAD), 1.1) == money.new(110, :CAD)
  end

  feedback :metric_measurements do
    measurement = get_answers()

    conversion = [
      millimeter: 0.1,
      centimeter: 1,
      meter: 100,
      kilometer: 100_000,
      inch: 2.54,
      feet: 30,
      yard: 91,
      mile: 160_000
    ]

    assert measurement.convert({:millimeter, 1}, :centimeter),
           "Ensure you implement the `convert/2` function."

    assert measurement.convert({:millimeter, 1}, :centimeter) == {:centimeter, 0.1}
    assert measurement.convert({:centimeter, 1}, :centimeter) == {:centimeter, 1}
    assert measurement.convert({:meter, 1}, :centimeter) == {:centimeter, 100}
    assert measurement.convert({:kilometer, 1}, :centimeter) == {:centimeter, 100_000}
    assert measurement.convert({:inch, 1}, :centimeter) == {:centimeter, 2.54}
    assert measurement.convert({:feet, 1}, :centimeter) == {:centimeter, 30}
    assert measurement.convert({:yard, 1}, :centimeter) == {:centimeter, 91}
    assert measurement.convert({:mile, 1}, :centimeter) == {:centimeter, 160_000}

    assert measurement.convert({:meter, 1}, :millimeter) == {:millimeter, 1000}
    assert measurement.convert({:meter, 1}, :centimeter) == {:centimeter, 100}
    assert measurement.convert({:meter, 1}, :meter) == {:meter, 1}
    assert measurement.convert({:meter, 1}, :kilometer) == {:kilometer, 0.001}

    Enum.each(conversion, fn {measure, amount} ->
      measurement.convert({:centimeter, 1}, measure) == {measure, 1 / amount}
    end)

    # to centimeter
    Enum.each(conversion, fn {measure, amount} ->
      assert measurement.convert({measure, 1}, :centimeter) == {:centimeter, amount}
    end)

    # from anything to anything
    Enum.each(conversion, fn {measure1, amount1} ->
      Enum.each(conversion, fn {measure2, amount2} ->
        assert measurement.convert({measure1, 1}, measure2) == {measure2, amount1 / amount2}
      end)
    end)
  end

  feedback :cypher do
    cypher = get_answers()

    assert cypher.shift("a"), "Ensure you implement the `shift/1` function."
    assert cypher.shift("a") == "b"
    assert cypher.shift("b") == "c"
    assert cypher.shift("abc") == "bcd"

    assert cypher.shift("z") == "a",
           "Ensure you handle the z special case. It should wrap around to a."

    assert cypher.shift("abcdefghijklmnopqrstuvwxyz") == "bcdefghijklmnopqrstuvwxyza"
  end

  feedback :email_validation do
    email = get_answers()

    assert email.validate("mail@mail.com"), "Ensure you implement the `validate/1` function."
    assert email.validate("bruce@wayne.tech")
    assert email.validate("name@domain.ca")
    assert email.validate("***@#@$.!@#")
    assert email.validate("123@123.123")

    refute email.validate("")
    refute email.validate("recipient")
    refute email.validate("123")
    refute email.validate("@.")
    refute email.validate("@domain.")
    refute email.validate("name@domain")
    refute email.validate("name@domain.")
    refute email.validate("domain.com")
    refute email.validate("@domain.com")
  end

  feedback :obfuscate_phone do
    obfuscate = get_answers()

    assert is_function(obfuscate), "Ensure obfuscate is a function."
    assert obfuscate.(""), "Ensure you implement the obfuscate function."
    assert obfuscate.("111-111-1111") == "XXX-111-XXXX"
    assert obfuscate.("123-111-1234") == "XXX-111-XXXX"
    assert obfuscate.("123-123-1234") == "XXX-123-XXXX"
    assert obfuscate.("123-123-1234 123-123-1234") == "XXX-123-XXXX XXX-123-XXXX"
  end

  feedback :convert_phone do
    convert = get_answers()

    assert convert.("#1231231234"), "Ensure you implement the `convert/1` function."
    assert convert.("#1231231234") == "#123-123-1234"
    assert convert.("#1231231234 #1231231234") == "#123-123-1234 #123-123-1234"
    assert convert.("#1231231234 1231231234") == "#123-123-1234 1231231234"
    assert convert.("#999-999-9999 #9999999999") == "#999-999-9999 #999-999-9999"
  end

  feedback :phone_number_parsing do
    phone_number = get_answers()

    assert phone_number.parse("1231231234"), "Ensure you implement the `parse/1` function."
    text = "
1231231234
123 123 1234
(123)-123-1234
(123) 123 1234
(123)123-1234
"

    assert phone_number.parse(text) == "
123-123-1234
123-123-1234
123-123-1234
123-123-1234
123-123-1234
"

    text = "
5555550150
555 555 0199
(555)-555-0120
(555) 555 0100
(555)555-0101
"

    assert phone_number.parse(text) ==
             "
555-555-0150
555-555-0199
555-555-0120
555-555-0100
555-555-0101
"
  end

  feedback :classified do
    classified = get_answers()

    assert classified.redact(""), "Ensure you implement the `redact/1` function."
    assert classified.redact("Peter Parker") == "REDACTED"
    assert classified.redact("Bruce Wayne") == "REDACTED"
    assert classified.redact("Clark Kent") == "REDACTED"
    assert classified.redact("1234") == "REDACTED"
    assert classified.redact("111-111-1111") == "REDACTED"
    assert classified.redact("email@mail.com") == "REDACTED"
    assert classified.redact("1234 123-123-1234") == "REDACTED REDACTED"

    assert classified.redact("@mail.com") == "@mail.com"
    assert classified.redact("12345") == "12345"
    assert classified.redact(".com") == ".com"
    assert classified.redact("12341234") == "12341234"
    assert classified.redact("-1234-") == "-REDACTED-"

    text = "
    Peter Parker
    Bruce Wayne
    Clark Kent
    1234
    4567
    9999
    123-123-1234
    456-456-4567
    999-999-9999
    email@mail.com
    name@gmail.ca
    "
    assert classified.redact(text) == "
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    REDACTED
    "
  end

  feedback :caesar_cypher do
    caesar_cypher = get_answers()

    assert caesar_cypher.encode("", 1), "Ensure you implement the `encode/2` function."
    assert caesar_cypher.encode("", 1) == ""
    assert caesar_cypher.encode("a", 1) == "b"
    assert caesar_cypher.encode("a", 14) == "o"
    assert caesar_cypher.encode("a", 25) == "z"
    assert caesar_cypher.encode("z", 1) == "a"
    assert caesar_cypher.encode("z", 14) == "n"
    assert caesar_cypher.encode("z", 25) == "y"
    assert caesar_cypher.encode("abcdefghijklmnopqrstuvwxyz", 1) == "bcdefghijklmnopqrstuvwxyza"
    assert caesar_cypher.encode("abcdefghijklmnopqrstuvwxyz", 14) == "opqrstuvwxyzabcdefghijklmn"
    assert caesar_cypher.encode("abcdefghijklmnopqrstuvwxyz", 25) == "zabcdefghijklmnopqrstuvwxy"
    assert caesar_cypher.encode("et tu, brute?", 2) == "gv vw, dtwvg?"

    assert caesar_cypher.decode("", 1), "Ensure you implement the `decode/2` function."
    assert caesar_cypher.decode("", 1) == ""
    assert caesar_cypher.decode("b", 1) == "a"
    assert caesar_cypher.decode("o", 14) == "a"
    assert caesar_cypher.decode("z", 25) == "a"
    assert caesar_cypher.decode("a", 1) == "z"
    assert caesar_cypher.decode("n", 14) == "z"
    assert caesar_cypher.decode("y", 25) == "z"
    assert caesar_cypher.decode("bcdefghijklmnopqrstuvwxyza", 1) == "abcdefghijklmnopqrstuvwxyz"
    assert caesar_cypher.decode("opqrstuvwxyzabcdefghijklmn", 14) == "abcdefghijklmnopqrstuvwxyz"
    assert caesar_cypher.decode("zabcdefghijklmnopqrstuvwxy", 25) == "abcdefghijklmnopqrstuvwxyz"
    assert caesar_cypher.decode("gv vw, dtwvg?", 2) == "et tu, brute?"
  end

  feedback :rollable_expressions do
    rollable = get_answers()

    assert rollable.replace(""), "Ensure you implement the `replace/1` function."
    assert rollable.replace("") == ""
    assert rollable.replace("1d4") == "[1d4](https://www.google.com/search?q=roll+1d4)"
    assert rollable.replace("1d6") == "[1d6](https://www.google.com/search?q=roll+1d6)"
    assert rollable.replace("1d8") == "[1d8](https://www.google.com/search?q=roll+1d8)"
    assert rollable.replace("1d12") == "[1d12](https://www.google.com/search?q=roll+1d12)"
    assert rollable.replace("1d20") == "[1d20](https://www.google.com/search?q=roll+1d20)"

    assert rollable.replace("2d4") == "[2d4](https://www.google.com/search?q=roll+2d4)"
    assert rollable.replace("10d4") == "[10d4](https://www.google.com/search?q=roll+10d4)"
    assert rollable.replace("99d4") == "[99d4](https://www.google.com/search?q=roll+99d4)"
    assert rollable.replace("10d20") == "[10d20](https://www.google.com/search?q=roll+10d20)"
    assert rollable.replace("99d20") == "[99d20](https://www.google.com/search?q=roll+99d20)"

    for sides <- ["4", "6", "8", "12", "20"], dice <- 1..99 do
      assert rollable.replace("Fireball: deal #{sides}d#{dice} fire damage.") ==
               "Fireball: deal [#{sides}d#{dice}](https://www.google.com/search?q=roll+#{sides}d#{dice}) fire damage."
    end

    rollable.replace("Click the following to test your solution: 1d4")
    |> Kino.Markdown.new()
    |> Kino.render()
  end

  feedback :enum_recursion do
    custom_enum = get_answers()

    list = Enum.to_list(1..5)

    assert custom_enum.reduce(list, 0, fn each, _acc -> each end),
           "Ensure you implement the `reduce/3` function."

    assert custom_enum.reduce(list, 0, fn each, acc -> acc + each end) == 15

    assert custom_enum.map(list, fn each -> each end),
           "Ensure you implement the `map/2` function."

    assert custom_enum.map(list, fn each -> each end) == Enum.to_list(list)
    assert custom_enum.map(list, fn each -> each * 2 end) == Enum.to_list(2..10//2)

    assert custom_enum.reverse(list), "Ensure you implement the `reverse/2` function."

    assert custom_enum.each(list, fn _ -> nil end), "Ensure you implement the `each/2` function."

    assert custom_enum.each(list, fn _ -> nil end) == :ok,
           "The `each/2` function should return :ok"

    assert capture_log(fn ->
             custom_enum.each(["log message"], fn each -> Logger.error(each) end)
           end) =~ "log message"

    assert custom_enum.filter([], fn _ -> true end) == [],
           "Ensure you implement the `filter/2` function."

    assert custom_enum.filter(list, fn _ -> true end) == [1, 2, 3, 4, 5]
    assert custom_enum.filter(list, fn _ -> false end) == []
    assert custom_enum.filter([true, false, true], fn each -> each end) == [true, true]
    assert custom_enum.filter(list, fn each -> each <= 3 end) == [1, 2, 3]
  end

  feedback :pascal do
    pascal = get_answers()

    assert pascal.of(1), "Ensure you implement the `pascal/1` function."
    assert pascal.of(1) == [[1]]
    assert pascal.of(2) == [[1], [1, 1]]

    assert pascal.of(5) == [
             [1],
             [1, 1],
             [1, 2, 1],
             [1, 3, 3, 1],
             [1, 4, 6, 4, 1]
           ]

    assert pascal.of(8) == [
             [1],
             [1, 1],
             [1, 2, 1],
             [1, 3, 3, 1],
             [1, 4, 6, 4, 1],
             [1, 5, 10, 10, 5, 1],
             [1, 6, 15, 20, 15, 6, 1],
             [1, 7, 21, 35, 35, 21, 7, 1]
           ]

    assert length(pascal.of(50)) == 50
  end

  feedback :sublist do
    sublist = get_answers()

    assert sublist.sublists([1, 1, 2, 3, 1, 4, 2], 3) == [
             [1, 1, 2],
             [1, 2, 3],
             [2, 3, 1],
             [3, 1, 4],
             [1, 4, 2]
           ]
  end

  feedback :lucas_numbers do
    lucas_numbers = get_answers()

    assert lucas_numbers.generate(1), "Ensure you implement the `generate/1` function."
    assert lucas_numbers.generate(1) == [2]

    assert lucas_numbers.generate(2) == [2, 1]

    assert lucas_numbers.generate(3) == [2, 1, 3]

    sequence = [
      2,
      1,
      3,
      4,
      7,
      11,
      18,
      29,
      47,
      76,
      123,
      199,
      322,
      521,
      843,
      1364,
      2207,
      3571,
      5778,
      9349,
      15_127,
      24_476,
      39_603,
      64_079,
      103_682,
      167_761,
      271_443,
      439_204,
      710_647,
      1_149_851
    ]

    assert lucas_numbers.generate(10) == Enum.take(sequence, 10)
    assert lucas_numbers.generate(20) == Enum.take(sequence, 20)
    assert lucas_numbers.generate(30) == Enum.take(sequence, 30)
  end

  feedback :rpg_character do
    character = get_answers()

    assert Keyword.get(character.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{health: 100, speed: 20, class: nil, equipment: []}, struct(character)),
           "Ensure you use default values for :health, :speed, and :equipment."
  end

  feedback :rpg_healing_potion do
    healing_potion = get_answers()

    assert Keyword.get(healing_potion.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{level: 1}, struct(healing_potion)),
           "Ensure you use default values for :level."
  end

  feedback :rpg_armor do
    armor = get_answers()

    assert Keyword.get(armor.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{defense: 10}, struct(armor)),
           "Ensure you use default values for :defense."
  end

  feedback :rpg_consumable do
    [consumable, character, healing_potion] = get_answers()

    assert Keyword.get(consumable.__info__(:functions), :consume),
           "Define a `consume/2` function."

    assert Keyword.get(consumable.__info__(:functions), :consume) == 2,
           "the `consume/2` function should accept an item and a character."

    character_struct = struct(character, %{class: :wizard})
    injured_character_struct = struct(character, %{class: :wizard, health: 10})
    potion_struct = struct(healing_potion)
    level2_potion_struct = struct(healing_potion, %{level: 2})

    assert match?(
             %{health: 110, speed: 20, class: :wizard, equipment: []},
             consumable.consume(potion_struct, character_struct)
           )

    assert match?(
             %{health: 120, speed: 20, class: :wizard, equipment: []},
             consumable.consume(level2_potion_struct, character_struct)
           )

    assert match?(
             %{health: 20, speed: 20, class: :wizard, equipment: []},
             consumable.consume(potion_struct, injured_character_struct)
           )

    assert match?(
             %{health: 30, speed: 20, class: :wizard, equipment: []},
             consumable.consume(level2_potion_struct, injured_character_struct)
           )
  end

  feedback :rpg_wearable do
    # Missing test cases
    # - adding multiple wearables
    # - removing multiple wearables
    [wearable, character, armor] = get_answers()

    assert Keyword.get(wearable.__info__(:functions), :wear),
           "Define a `wear/2` function."

    assert Keyword.get(wearable.__info__(:functions), :wear) == 2,
           "the `wear/2` function should accept an item and a character"

    character_struct = struct(character, %{class: :wizard})
    armor_struct = struct(armor)

    assert match?(
             %{health: 110, speed: 15, class: :wizard, equipment: [^armor_struct]},
             wearable.wear(armor_struct, character_struct)
           )

    assert Keyword.get(wearable.__info__(:functions), :remove),
           "Define a `remove/2` function."

    assert Keyword.get(wearable.__info__(:functions), :remove) == 2,
           "the `remove/2` function should accept an item and a character"

    armored_character = wearable.wear(armor_struct, character_struct)
    assert character_struct == wearable.remove(armor_struct, armored_character)
  end

  feedback :math_module do
    math = get_answers()
    assert math, "Ensure you implement a `Math` module or protocol"
    assert math.__info__(:functions), "Ensure you implement a `Math` module or protocol"

    assert Keyword.get(math.__info__(:functions), :add), "Implement the `add/2` function"
    assert math.add(1, 2) == 3, "Implement the `add/2` function for integers."
    assert math.add(3, 2) == 5
    assert math.add(1.0, 2) == 3.0, "Implement the `add/2` function for floats"
    assert math.add([1], [1]) == [1, 1], "Implement the `add/2` function for lists."
    assert math.add([1, 2], [1]) == [1, 2, 1]
    assert math.add([1, 2], [1, 2]) == [1, 2, 1, 2]
    assert math.add(1..10, 1..10) == 2..20, "Implement the `add/2` function for ranges."
    assert math.add(4..5, 1..1) == 5..6

    assert math.add("hello, ", "world!") == "hello, world!",
           "Implement the `add/2` function for strings."

    assert math.add("a", "b") == "ab"

    assert Keyword.get(math.__info__(:functions), :subtract),
           "Implement the `subtract/2` function."

    assert math.subtract(2, 2) == 0, "Implement the `subtract/2` function for integers."
    assert math.subtract(10, 2) == 8
    assert math.subtract(10, 2.0) == 8.0
    assert math.subtract(2.0, 1) == 1.0, "Implement the `subtract/2` function for floats."
    assert math.subtract(10.0, 2.0) == 8.0
    assert math.subtract([1, 2], [1]) == [2], "Implement the `subtract/2` function for lists."
    assert math.subtract([1, 2, 3], [1, 2]) == [3]
    assert math.subtract(5..10, 1..5) == 4..5, "Implement the `subtract/2` function for ranges."
    assert math.subtract(1..10, 2..5) == -1..5

    assert math.subtract("hello", "he") == "llo",
           "Implement the `subtract/2` function for ranges."

    assert math.subtract("hi", "i") == "h"
    assert math.subtract("oooo", "ooo") == "o"

    assert Keyword.get(math.__info__(:functions), :multiply),
           "Implement the `multiply/2` function"

    assert math.multiply(5, 5) == 25, "Implement the `multiply/2` function for integers."
    assert math.multiply(10, 10) == 100
    assert math.multiply(5.0, 10) == 50.0, "Implement the `multiply/2` function for floats."
    assert math.multiply(2.0, 5.0) == 10.0, "Implement the `multiply/2` function for floats."

    assert math.multiply([1, 2], 3) == [1, 2, 1, 2, 1, 2],
           "Implement the `multiply/2` function for lists."

    assert math.multiply(["a"], 2) == ["a", "a"]

    assert math.multiply(5..10, 5..10) == 25..100,
           "Implement the `multiply/2` function for ranges."

    assert math.multiply(2..4, 5..10) == 10..40
  end

  feedback :pokemon_evolution_structs do
    [charmander, charmeleon, charizard] = get_answers()

    assert Keyword.get(charmander.__info__(:functions), :__struct__),
           "Ensure you use `defstruct` for Charmander."

    assert %{hp: _, attack: _, defense: _} = struct(charmander),
           "Define the :hp, :attack, and :defense keys for Charmander."

    assert %{hp: 39, attack: 52, defense: 43} = struct(charmander)

    assert Keyword.get(charmeleon.__info__(:functions), :__struct__),
           "Ensure you use `defstruct` for Charmeleon."

    assert %{hp: _, attack: _, defense: _} = struct(charmeleon),
           "Define the :hp, :attack, and :defense keys for Charmeleon."

    assert %{hp: 58, attack: 64, defense: 58} = struct(charmeleon)

    assert Keyword.get(charizard.__info__(:functions), :__struct__),
           "Ensure you use `defstruct` for Charizard."

    assert %{hp: _, attack: _, defense: _} = struct(charizard),
           "Define the :hp, :attack, and :defense keys for Charizard."

    assert %{hp: 78, attack: 84, defense: 78} = struct(charizard)
  end

  feedback :evolvable do
    [evolvable, charmander, charmeleon, charizard] = get_answers()

    assert Keyword.get(evolvable.__info__(:functions), :evolve),
           "add the `evolve` function to the `Evolvable` protocol."

    assert %{hp: 39, attack: 52, defense: 43} = struct(charmander),
           "Create the `Charmander` struct before starting this exercise."

    assert %{hp: 58, attack: 64, defense: 58} = struct(charmeleon),
           "Create the `Charmeleon` struct before starting this exercise."

    assert %{hp: 78, attack: 84, defense: 78} = struct(charizard),
           "Create the `Charizard` struct before starting this exercise."

    assert evolvable.evolve(struct(charmander)) == struct(charmeleon)
    assert evolvable.evolve(struct(charmeleon)) == struct(charizard)
  end

  feedback :battle_map do
    [character, barbarian, wizard] = get_answers()

    wizard = struct(wizard)
    barbarian = struct(barbarian)

    for init_x <- 1..7, init_y <- 1..7, x <- 1..7, y <- 1..7 do
      x_diff = init_x - x
      y_diff = init_y - y

      can_attack = init_x == x || init_y == y || abs(x_diff) == abs(y_diff)

      assert character.can_attack?(wizard, {init_x, init_y}, {x, y}) == can_attack, """
      Called with: Character.can_attack(%Wizard{}, #{inspect({init_x, init_y})}, #{inspect({x, y})})
      Expected: #{can_attack}
      Received: #{character.can_attack?(wizard, {init_x, init_y}, {x, y})}
      """
    end

    for init_x <- 1..7, init_y <- 1..7, x <- 1..7, y <- 1..7 do
      x_diff = init_x - x
      y_diff = init_y - y

      can_attack = abs(x_diff) <= 2 && abs(y_diff) <= 2

      assert character.can_attack?(barbarian, {init_x, init_y}, {x, y}) == can_attack, """
      Called with: Character.can_attack(%Barbarian{}, #{inspect({init_x, init_y})}, #{inspect({x, y})})
      Expected: #{can_attack}
      Received: #{character.can_attack?(barbarian, {init_x, init_y}, {x, y})}
      """
    end
  end

  feedback :number_wordle do
    number_wordle = get_answers()

    assert number_wordle.feedback(1111, 9999), "Ensure you implement the feedback/2 function."

    assert number_wordle.feedback(1111, 1111) == [:green, :green, :green, :green]
    assert number_wordle.feedback(1111, 2222) == [:gray, :gray, :gray, :gray]
    assert number_wordle.feedback(1111, 1122) == [:green, :green, :gray, :gray]
    assert number_wordle.feedback(1112, 2333) == [:gray, :gray, :gray, :yellow]
    assert number_wordle.feedback(2221, 1222) == [:yellow, :green, :green, :yellow]
  end

  # test_names must be after tests that require a solution.
  def test_names, do: @tests

  feedback :example do
    example = get_answers()
    assert example == 5
  end

  feedback :atom_maze do
    [atom_maze, path] = get_answers()

    expected_maze = %{
      south: %{
        west: %{
          south: %{
            east: %{
              south: %{
                east: %{
                  south: "Exit!"
                }
              }
            }
          }
        }
      }
    }

    assert expected_maze == atom_maze, reset_message()
    assert path, "Enter a value for `path`"
    assert path != atom_maze, "Use atom_maze.south to access the first key of the map."
    assert path != atom_maze.south, "Use atom_maze.south.west to access next map value."

    assert path != atom_maze.south.west,
           "Use atom_maze.south.west.south to access next map value."

    assert path == "Exit!", "Continue using atom_maze.key syntax until you reach the Exit!"
  end

  feedback :string_maze do
    [string_maze, path] = get_answers()

    expected_maze = %{
      "south" => %{
        "east" => %{
          "south" => %{
            "west" => %{
              "south" => %{
                "west" => %{
                  "south" => %{
                    "east" => %{
                      # using string_maze[key] syntax, access this deeply nested value.
                      "south" => "Exit!"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    assert string_maze == expected_maze, reset_message()
    assert path, "Enter a value for `path`"
    assert path != string_maze, "Use string_maze[\"south\"] to access the first key of the map."

    assert path != string_maze["south"],
           "Use string_maze[\"south\"][\"east\"] to access next map value."

    assert path != string_maze["south"]["east"],
           "Use string_maze[\"south\"][\"east\"][\"south\"] to access next map value."

    assert path == "Exit!", "Continue using string_maze[key] syntax until you reach the Exit!"
  end

  feedback :custom_maze do
    [custom_maze, path] = get_answers()
    assert custom_maze, "Ensure you enter a value for `custom_maze`."
    assert path, "Ensure you enter a value for path."

    assert is_map(custom_maze), "`custom_maze` should be a map."

    assert path == "Exit!"
  end

  feedback :treasure_map do
    [treasure_map, path] = get_answers()

    expected_map = %{
      "south ten paces" => %{
        10 => %{
          :"east three paces" => %{
            [1, 2, 3] => %{
              {"turn", "right"} => %{
                :dig => "gold"
              }
            }
          }
        }
      }
    }

    assert treasure_map == expected_map, reset_message()
    assert path, "Enter a value for `path`."

    assert path != treasure_map,
           "Use treasure_map[\"south ten paces\"] to get the next value of the `treasure_map`"

    assert path != treasure_map["south ten paces"],
           "Use treasure_map[\"south ten paces\"][10] to get the next value of the `treasure_map`"

    assert path == "gold",
           "use treasure_map[key] or treasure_map.key syntax until you reach the gold!"
  end

  feedback :update_treasure_map do
    [treasure_map, updated_map] = get_answers()

    expected_map = %{
      "south ten paces" => %{
        10 => %{
          :"east three paces" => %{
            [1, 2, 3] => %{
              {"turn", "right"} => %{
                :dig => "gold"
              }
            }
          }
        }
      }
    }

    assert treasure_map == expected_map, reset_message()

    assert updated_map, "Enter an answer for `updated_map`."
    assert is_map(updated_map), "`updated_map` should be a map."

    assert updated_map == %{
             treasure_map
             | "south ten paces" => %{
                 10 => %{
                   :"east three paces" => %{
                     [1, 2, 3] => %{{"turn", "right"} => %{:dig => "taken"}}
                   }
                 }
               }
           }
  end

  feedback :timer_tc do
    result = get_answers()

    assert {_time, _result} = result, "Ensure you use `:timer.tc/1` with `slow_function/0`"
    assert {time, :ok} = result, "The result of `slow_function/0` should be :ok."

    assert time > 900_000,
           "It's possible that your computer hardware causes :timer.tc/1 to deviate significantly."

    assert time < 1_100_000,
           "It's possible that your computer hardware causes :timer.tc/1 to deviate significantly."
  end

  feedback :binary_150 do
    binary = get_answers()
    assert binary == 10_010_110
  end

  feedback :graphemes do
    graphemes = get_answers()
    assert graphemes == String.graphemes("hello")
  end

  feedback :hexadecimal_4096 do
    hexadecimal = get_answers()
    assert hexadecimal == 0x1000
  end

  feedback :hexadecimal_a do
    hexadecimal = get_answers()
    assert hexadecimal == "\u0061"
  end

  feedback :codepoint_z do
    z = get_answers()
    assert z == ?z
  end

  feedback :hello do
    hello = get_answers()
    assert hello == "world"
  end

  feedback :jewel do
    jewel = get_answers()
    assert jewel != [1, 2, "jewel"], "Ensure you use pattern matching to bind `jewel`"
    assert jewel == "jewel"
  end

  feedback :keyword_get do
    color = get_answers()
    options = [color: "red"]
    assert color == Keyword.get(options, :color)
  end

  feedback :keyword_keys do
    options = [one: 1, two: 2, three: 3]
    keys = get_answers()
    assert keys == Keyword.keys(options)
  end

  feedback :keyword_keyword? do
    is_keyword_list = get_answers()
    keyword_list = [key: "value"]

    assert is_keyword_list == Keyword.keyword?(keyword_list)
  end

  feedback :integer_parse do
    parsed = get_answers()

    assert parsed == Integer.parse("2")
  end

  feedback :integer_digits do
    digits = get_answers()

    assert digits == Integer.digits(123_456_789)
  end

  feedback :string_contains do
    answer = get_answers()

    assert answer == String.contains?("Hello", "lo")
  end

  feedback :string_capitalize do
    answer = get_answers()

    assert answer == String.capitalize("hello")
  end

  feedback :string_split do
    words = get_answers()
    string = "have,a,great,day"

    assert words == String.split(string, ",")
  end

  feedback :string_trim do
    trimmed_string = get_answers()
    string = "  hello!  "

    assert trimmed_string == String.trim(string)
  end

  feedback :string_upcase do
    uppercase_string = get_answers()
    string = "hello"

    assert uppercase_string == String.upcase(string)
  end

  feedback :map_get do
    retrieved_value = get_answers()
    map = %{hello: "world"}
    assert retrieved_value == Map.get(map, :hello)
  end

  feedback :map_put do
    new_map = get_answers()
    map = %{one: 1}
    assert new_map == Map.put(map, :two, 2)
  end

  feedback :map_keys do
    keys = get_answers()
    map = %{key1: 1, key2: 2, key3: 3}
    assert keys == Map.keys(map)
  end

  feedback :map_delete do
    new_map = get_answers()
    map = %{key1: 1, key2: 2, key3: 3}
    assert new_map == Map.delete(map, :key1)
  end

  feedback :map_values do
    values = get_answers()
    map = %{key1: 1, key2: 2, key3: 3}
    assert values == Map.values(map)
  end

  feedback :date_compare do
    [today, tomorrow, comparison] = get_answers()
    assert today, "Ensure today is defined"
    assert today == Date.utc_today()
    assert tomorrow, "Ensure tomorrow is defined"
    assert tomorrow == Date.add(today, 1)
    assert comparison, "Ensure comparison is defined"
    assert comparison == Date.compare(today, tomorrow)
  end

  feedback :date_sigil do
    today = get_answers()
    assert today == Date.utc_today()
  end

  feedback :date_difference do
    [date1, date2, difference] = get_answers()

    assert is_struct(date1), "date1 should be a `Date` struct."
    assert date1.__struct__ == Date, "date1 should be a `Date` struct."
    assert date1 == %Date{year: 1995, month: 4, day: 28}

    assert is_struct(date2), "date2 should be a `Date` struct."
    assert date2.__struct__ == Date, "date2 should be a `Date` struct."
    assert date2 == %Date{year: 1915, month: 4, day: 17}

    assert difference == Date.diff(date2, date1)
  end

  feedback :calculate_force do
    calculate_force = get_answers()

    assert calculate_force
    assert is_function(calculate_force), "calculate_force should be a function."

    assert is_function(calculate_force, 2),
           "calculate_force should be a function with arity of 2."

    assert calculate_force.(10, 5), "calculate_force should return a value."
    assert is_integer(calculate_force.(10, 5)), "calculate_force should return an integer."
    assert calculate_force.(10, 5) == 10 * 5, "calculate_force should return mass * acceleration"
  end

  feedback :is_even? do
    is_even? = get_answers()
    assert is_even?
    assert is_function(is_even?), "is_even? should be a function."
    assert is_function(is_even?, 1), "is_even? should be a function with a single parameter."

    even_number = Enum.random(2..10//2)
    odd_number = Enum.random(1..9//2)
    refute is_even?.(odd_number), "is_even? should return false for odd numbers."
    assert is_even?.(even_number), "is_even? should return true for even numbers."
  end

  feedback :call_with_20 do
    call_with_20 = get_answers()

    assert call_with_20
    assert is_function(call_with_20), "call_with_20 should be a function."

    assert is_function(call_with_20, 1),
           "call_with_20 should be a function with a single parameter."

    assert call_with_20.(fn int -> int * 2 end) == 20 * 2
    assert call_with_20.(fn int -> int * 10 end) == 20 * 10
  end

  feedback :range_to_list do
    list = get_answers()
    assert list == [3, 6, 9]
  end

  feedback :created_project do
    path = get_answers()

    assert File.dir?("../projects/#{path}"),
           "Ensure you create a mix project `#{path}` in the `projects` folder."
  end
end

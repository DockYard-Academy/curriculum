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
  Module.register_attribute(Utils.Feedback, :test_names, accumulate: true)
  require Utils.Macros
  import Utils.Macros

  # Allows for tests that don't require input
  def test(test_name), do: test(test_name, "")
  def test({:module, _, _, _} = module, test_name), do: test(test_name, module)

  def test(test_name, answers) do
    answers_in_list_provided =
      is_list(answers) and Enum.all?(answers, fn each -> not is_nil(each) end)

    answer_provided = not is_list(answers) and not is_nil(answers)

    if answer_provided or answers_in_list_provided or Mix.env() == :test do
      ExUnit.start(auto_run: false)
      test_module(test_name, answers)
      ExUnit.run()
    else
      "Please enter an answer above."
    end
  end

  feedback :card_count_four do
    next_count = get_answers()
    assert next_count == 1
  end

  feedback :card_count_king do
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

  feedback :habit_tracker_definition do
    [small, medium, large] = get_answers()
    assert small == 5
    assert medium == 20
    assert large == 30
  end

  feedback :habit_tracker_add do
    total_points = get_answers()
    assert total_points == 20 + 5
  end

  feedback :habit_tracker_percentage do
    percentage = get_answers()
    assert percentage == (5 + 20) / 40 * 100
  end

  feedback :habit_tracker_penalties_1 do
    total_points = get_answers()
    assert total_points == 5 + 20 + 30 * 0.5
  end

  feedback :habit_tracker_penalties_2 do
    total_points = get_answers()
    assert total_points == 5 / 2 * 3 + 20 / 2 * 3
  end

  feedback :habit_tracker_rewards do
    total_points = get_answers()
    assert total_points == 20 * 1.6 + 5 * 1.6 + 30 * 0.5
  end

  feedback :percentage do
    [completed_items, total_items, percentage] = get_answers()

    assert completed_items == 10,
           "completed_items should always be 10. Please reset the exercise."

    assert total_items == 100, "total_items should always be 100. Please reset the exercise."
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

  feedback :string_concatenation do
    answer = get_answers()
    assert is_bitstring(answer), "the answer should be a string."
    assert "Hi, " <> _name = answer, "the answer should be in the format: Hi, name."
    assert Regex.match?(~r/Hi, \w+\./, answer), "the answer should end in a period."
  end

  feedback :string_interpolation do
    answer = get_answers()
    assert is_bitstring(answer), "the answer should be a string."

    assert Regex.match?(~r/I have/, answer),
           "the answer should be in the format: I have 10 classmates"

    assert Regex.match?(~r/I have \d+/, answer),
           "the answer should contain an integer for classmates."

    assert Regex.match?(~r/I have \d+ classmates\./, answer) ||
             answer === "I have 1 classmate.",
           "the answer should end in a period."
  end

  feedback :tip_amount do
    [cost_of_the_meal, tip_rate, tip_amount] = get_answers()
    assert tip_rate == 0.20, "tip rate should be 0.2."
    assert cost_of_the_meal == 55.5, "cost_of_the_meal should be 55.5."

    assert tip_amount === cost_of_the_meal * tip_rate,
           "tip_amount should be cost_of_the_meal * tip_rate."
  end

  feedback :rock_paper_scissors_ai do
    [player_choice, ai_choice] = get_answers()

    case player_choice do
      :rock ->
        assert ai_choice === :paper,
               "when player_choice is :rock, ai_choice should be :paper."

      :paper ->
        assert ai_choice === :scissors,
               "when player_choice is :paper, ai_choice should be :scissors."

      :scissors ->
        assert ai_choice === :rock,
               "when player_choice is :scissors, ai_choice should be :rock."
    end
  end

  feedback :rock_paper_scissors_two_player do
    [player1_choice, player2_choice, winner] = get_answers()

    case {player1_choice, player2_choice} do
      {:rock, :scissors} -> assert winner == :player1
      {:paper, :rock} -> assert winner == :player1
      {:scissors, :paper} -> assert winner == :player1
      {:scissors, :rock} -> assert winner == :player2
      {:rock, :paper} -> assert winner == :player2
      {:paper, :scissors} -> assert winner == :player2
      _ -> assert winner == :draw
    end
  end

  feedback :rocket_ship do
    force = get_answers()
    assert force == 20
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

    assert Enum.all?(answers, fn each -> is_bitstring(each) and String.length(each) > 0 end),
           "each variable should be bound to a non-empty string"

    assert madlib ==
             "My company, #{name_of_company} is developing #{a_defined_offering} to help #{a_defined_audience} #{solve_a_problem} with #{secret_sauce}."
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

    assert Enum.all?(answers, fn each -> is_bitstring(each) and String.length(each) > 0 end),
           "each variable should be bound to a non-empty string"

    assert madlib ==
             "The majestic #{animal} has roamed the forests of #{country} for thousands of years. Today she wanders in search of #{plural_noun}. She must find food to survive. While hunting for #{a_food}, she found a/an #{type_of_screen_device} hidden behind a #{noun}. She has never seen anything like this before. What will she do? With the device in her teeth, she tries to #{verb1}, but nothing happens. She takes it back to her family. When her family sees it, they quickly #{verb2}. Soon, the device becomes #{adjective}, and the family decides to put it back where they found it."
  end

  feedback :boolean_diagram1 do
    answer = get_answers()
    assert answer == false
  end

  feedback :boolean_diagram2 do
    answer = get_answers()
    assert answer == true
  end

  feedback :boolean_diagram3 do
    answer = get_answers()
    assert answer == false
  end

  feedback :boolean_diagram4 do
    answer = get_answers()
    assert answer == false
  end

  feedback :boolean_diagram5 do
    answer = get_answers()
    assert answer == true
  end

  feedback :boolean_diagram6 do
    answer = get_answers()
    assert answer == true
  end

  feedback :guess_the_word do
    [guess, answer, correct] = answers = get_answers()

    assert Enum.all?(answers, &is_bitstring/1),
           "Ensure `guess`, `answer`, and `correct` are all strings"

    if guess == answer do
      assert correct == "Correct!"
    else
      assert correct == "Incorrect."
    end
  end

  feedback :guess_the_number do
    [guess, answer, correct] = get_answers()

    assert is_integer(guess), "Ensure `guess` is an integer"
    assert is_integer(answer), "Ensure `answer` is an integer"
    assert is_bitstring(correct), "Ensure `correct` is a string"

    cond do
      guess == answer -> assert correct == "Correct!"
      guess < answer -> assert correct == "Too low!"
      guess > answer -> assert correct == "Too high!"
    end
  end

  feedback :copy_file do
    file_name = get_answers()
    assert {:ok, "Copy me!"} = File.read("../data/#{file_name}")
  end

  feedback :shopping_list do
    shopping_list = get_answers()
    list = [] ++ ["grapes", "walnuts", "apples"]
    list = list ++ ["blueberries", "chocolate", "pizza"]
    list = list -- ["grapes", "walnuts"]
    list = list ++ ["banana", "banana", "banana"]

    assert is_list(shopping_list), "Ensure shopping_list is still a list."

    assert Enum.sort(list) == Enum.sort(shopping_list),
           "Ensure your shopping list has all of the expected items"

    assert shopping_list == list, "Ensure you add and remove items in the expected order"
  end

  feedback :shopping_list_with_quantities do
    shopping_list = get_answers()
    list = [] ++ [milk: 1, eggs: 12]
    list = list ++ [bars_of_butter: 2, candies: 10]
    list = list -- [bars_of_butter: 2]
    list = list -- [candies: 10]
    list = list ++ [candies: 5]

    assert is_list(shopping_list), "Ensure shopping_list is still a list."

    assert Enum.sort(shopping_list) == Enum.sort(shopping_list),
           "Ensure your shopping list has all of the expected items"

    assert shopping_list == list, "Ensure you add and remove items in the expected order"
  end

  feedback :family_tree do
    family_tree = get_answers()
    assert is_map(family_tree), "Ensure `family_tree` is a map."
    assert %{name: "Arthur"} = family_tree, "Ensure `family_tree` starts with Arthur."

    assert %{name: "Arthur", parents: _list} = family_tree,
           "Ensure Arthur in `family_tree` has a list of parents."

    assert family_tree == Utils.Solutions.family_tree()
  end

  feedback :naming_numbers do
    naming_numbers = get_answers()

    assert is_function(naming_numbers),
           "Ensure you bind `naming_numbers` to an anonymous function."

    list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    Enum.each(1..9, fn integer ->
      assert naming_numbers.(integer) == Enum.at(list, integer)
    end)
  end

  feedback :numbering_names do
    numbering_names = get_answers()

    list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    capital_list = Enum.map(list, &String.capitalize/1)

    assert is_function(numbering_names),
           "Ensure you bind `naming_numbers` to an anonymous function."

    Enum.each(list, fn name ->
      assert numbering_names.(name) ==
               Enum.find_index(list, fn each -> each == String.downcase(name) end)
    end)

    Enum.each(capital_list, fn name ->
      assert numbering_names.(name) ==
               Enum.find_index(list, fn each -> each == String.downcase(name) end)
    end)
  end

  feedback :define_character_struct do
    character_module = get_answers()

    assert Keyword.get(character_module.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`"

    assert match?(%{name: nil, class: nil, weapon: nil}, struct(character_module)),
           "Ensure you use `defstruct` with :name, :class, and :weapon"

    assert_raise ArgumentError, fn ->
      struct!(character_module, %{weapon: "", class: ""})
    end
  end

  feedback :character_structs do
    [arthur, gandalf, jarlaxle] = get_answers()
    assert is_struct(arthur), "Ensure `arthur` is a struct."
    assert is_struct(gandalf), "Ensure `gandalf` is a struct."
    assert is_struct(jarlaxle), "Ensure `jarlaxle` is a struct."

    assert %{name: "Arthur", weapon: "sword", class: "warrior"} = arthur
    assert %{name: "Gandalf", weapon: "staff", class: "wizard"} = gandalf
    assert %{name: "Jarlaxle", weapon: "daggers", class: "rogue"} = jarlaxle
  end

  feedback :character_dialogue do
    dialogue_module = get_answers()

    character_permutations =
      for class <- ["wizard", "rogue", "warrior", nil],
          weapon <- ["daggers", "sword", "staff", nil],
          name <- [Utils.Factory.name(), nil] do
        %{class: class, weapon: weapon, name: name}
      end

    enemy = Utils.Factory.name()

    Enum.each(character_permutations, fn character ->
      assert dialogue_module.greet(character) == "Hello, my name is #{character.name}."

      assert dialogue_module.attack(character, enemy) ==
               "#{character.name} attacks #{enemy} with a #{character.weapon}."

      relinquish_weapon_dialogue =
        case character.class do
          "rogue" -> "Fine, have my #{character.weapon}. I have more hidden anyway."
          "wizard" -> "You would not part an old man from his walking stick?"
          "warrior" -> "Have my #{character.weapon} then!"
          _ -> "My precious!"
        end

      assert dialogue_module.relinquish_weapon(character) == relinquish_weapon_dialogue

      matching_weapon_dialogue =
        case {character.class, character.weapon} do
          {"wizard", "staff"} -> "My lovely magical staff"
          {"rogue", "daggers"} -> "Hidden and deadly."
          {"warrior", "sword"} -> "My noble sword!"
          {_, nil} -> "I'm unarmed!"
          {_, _} -> "I'm not sure a #{character.weapon} suits a #{character.class}."
        end

      assert dialogue_module.matching_weapon(character) == matching_weapon_dialogue
    end)
  end

  feedback :define_pokemon_struct do
    pokemon_module = get_answers()

    assert Keyword.get(pokemon_module.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{name: nil, type: nil, speed: nil}, struct(pokemon_module)),
           "Ensure you use `defstruct` with :name, :type, :health, :attack, and :speed."

    assert match?(%{health: 20, attack: 5}, struct(pokemon_module)),
           "Ensure :health has a default value of 20 and :attack has a default value of 5."
  end

  feedback :pokemon_structs do
    [charmander, bulbasaur, squirtle] = get_answers()
    assert is_struct(charmander), "Ensure `charmander` is a struct."
    assert is_struct(squirtle), "Ensure `squirtle` is a struct."
    assert is_struct(bulbasaur), "Ensure `bulbasaur` is a struct."

    assert %{name: "Charmander", type: :fire, attack: 5, health: 20, speed: 20} = charmander
    assert %{name: "Bulbasaur", type: :grass, attack: 5, health: 20, speed: 15} = bulbasaur
    assert %{name: "Squirtle", type: :water, attack: 5, health: 20, speed: 10} = squirtle
  end

  feedback :pokemon_battle do
    [pokemon_battle_module, pokemon_module] = get_answers()

    assert Keyword.get(pokemon_module.__info__(:functions), :__struct__),
           "Ensure you complete the `Pokemon` module above first."

    assert match?(
             %{name: nil, type: nil, speed: nil, health: 20, attack: 5},
             struct(pokemon_module)
           ),
           "Ensure you complete the `Pokemon` module above first."

    pokemon_types =
      for speed <- 10..30//5,
          type <- [:water, :fire, :grass],
          attack <- 5..40//5,
          health <- 5..20//5 do
        struct(pokemon_module, %{
          name: "#{Atom.to_string(type)} pokemon",
          speed: speed,
          attack: attack,
          health: health
        })
      end

    pokemon_types
    |> Enum.shuffle()
    |> Enum.take(2)
    |> Enum.chunk_every(2)
    |> Enum.each(fn [pokemon1, pokemon2] ->
      attacked_pokemon = pokemon_battle_module.attack(pokemon1, pokemon2)

      multiplier = Utils.Solutions.PokemonBattle.multiplier(pokemon1, pokemon2)

      assert attacked_pokemon == %{
               pokemon2
               | health: pokemon2.health - pokemon2.attack * multiplier
             }

      assert {battled_pokemon1, battled_pokemon2} =
               pokemon_battle_module.battle(pokemon1, pokemon2)

      {expected_battled_pokemon1, expected_battled_pokemon2} =
        Utils.Solutions.PokemonBattle.battle(pokemon1, pokemon2)

      assert battled_pokemon1 == expected_battled_pokemon1
      assert battled_pokemon2 == expected_battled_pokemon2
    end)
  end

  feedback :rock_paper_scissors_lizard_spock do
    module = get_answers()

    assert Keyword.has_key?(module.__info__(:functions), :play),
           "Ensure you define the `play/2` function"

    game_permutations =
      for player1 <- [:rock, :paper, :scissors, :lizard, :spock],
          player2 <- [:rock, :paper, :scissors, :lizard, :spock] do
        {player1, player2}
      end

    beats? = fn player1, player2 ->
      {player1, player2} in [
        {:rock, :paper},
        {:paper, :rock},
        {:scissors, :paper},
        {:rock, :lizard},
        {:lizard, :spock},
        {:scissors, :lizard},
        {:lizard, :paper},
        {:paper, :spock},
        {:spock, :rock}
      ]
    end

    Enum.each(game_permutations, fn {p1, p2} ->
      expected_result =
        cond do
          beats?.(p1, p2) -> "#{p1} beats #{p2}."
          beats?.(p2, p1) -> "#{p2} beats #{p1}."
          true -> "tie game, play again?"
        end

      actual = module.play(p1, p2)

      assert actual == expected_result,
             "Failed on RockPaperScissorsLizardSpock.play(:#{p1}, :#{p2})."
    end)
  end

  feedback :custom_rps do
    custom_game_module = get_answers()

    assert 3 == Keyword.get(custom_game_module.__info__(:functions), :new),
           "Ensure you define the `new/3` function"

    assert Keyword.get(custom_game_module.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{rock: _, paper: _, scissors: _}, struct(custom_game_module)),
           "Ensure you use `defstruct` with :rock, :paper, and :scissors."

    assert %{rock: :custom_rock, paper: :custom_paper, scissors: :custom_scissors} =
             custom_game_module.new(:custom_rock, :custom_paper, :custom_scissors)

    assert 3 == Keyword.get(custom_game_module.__info__(:functions), :play),
           "Ensure you define the `play/3` function"

    game = custom_game_module.new(:custom_rock, :custom_paper, :custom_scissors)

    beats? = fn p1, p2 ->
      {p1, p2} in [
        {:custom_rock, :custom_scissors},
        {:custom_paper, :custom_rock},
        {:custom_scissors, :custom_paper}
      ]
    end

    for player1 <- [:custom_rock, :custom_paper, :custom_scissors],
        player2 <- [:custom_rock, :custom_paper, :custom_scissors] do
      result = custom_game_module.play(game, player1, player2)

      expected_result =
        cond do
          beats?.(player1, player2) -> "#{player1} beats #{player2}"
          beats?.(player2, player1) -> "#{player2} beats #{player1}"
          true -> "draw"
        end

      assert result == expected_result
    end
  end

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

    assert fizz_buzz_module.run(1..100) == Utils.Solutions.FizzBuzz.run(1..100)
  end

  feedback :voter_count do
    voter_count = get_answers()

    assert voter_count.count([], :test), "Implement the `count` function."

    assert voter_count.count([:dogs, :dogs, :dogs, :cats], :dogs) == 3,
           "failed on ([:dogs, :dogs, :dogs, :cats], :dogs)"

    assert voter_count.count([:dogs, :dogs, :dogs, :cats], :cats) == 1,
           "Failed on ([:dogs, :dogs, :dogs, :cats], :cats)"

    assert voter_count.count([:apples, :oranges, :apples, :cats], :birds) == 0,
           "Failed on ([:apples, :oranges, :apples, :cats], :birds)"

    list = Enum.map(1..10, fn _ -> Enum.random([:cat, :dog, :bird, :apple, :orange]) end)
    choice = Enum.random([:cat, :dog, :bird, :apple, :orange])
    assert voter_count.count(list, choice) == Enum.count(list, fn each -> each == choice end)
  end

  feedback :is_anagram do
    anagram_module = get_answers()

    assert anagram_module.is_anagram?("stop", "pots") == true
    refute anagram_module.is_anagram?("example", "nonanagram") == true

    word = Utils.Factory.string()

    generate_non_anagram = fn word ->
      word <> Enum.random(["a", "b", "c"])
    end

    generate_anagram = fn word ->
      String.split(word, "", trim: true) |> Enum.shuffle() |> Enum.join("")
    end

    assert anagram_module.is_anagram?(word, generate_anagram.(word)),
           "`is_anagram?/1` failed to identify anagram."

    refute anagram_module.is_anagram?(word, generate_non_anagram.(word)),
           "`is_anagram?/1` failed to identify non-anagram."

    non_anagrams = Enum.map(1..5, fn _ -> generate_non_anagram.(word) end)
    anagrams = Enum.map(1..5, fn _ -> generate_anagram.(word) end)

    result = anagram_module.filter_anagrams(word, anagrams ++ non_anagrams)
    assert is_list(result), "filter_anagrams/2 should return a list"

    assert Enum.sort(result) == Enum.sort(anagrams), "filter_anagrams/2 failed to filter anagrams"
  end

  feedback :bottles_of_soda do
    bottles_of_soda = get_answers()
    result = bottles_of_soda.on_the_wall()
    assert result, "Implement the `on_the_wall/0` function."
    assert is_list(result), "`on_the_wall/0` should return a list."

    assert Enum.at(result, 0) ==
             "99 bottles of soda on the wall.\n99 bottles of soda.\nTake one down, pass it around.\n98 bottles of soda on the wall."

    assert length(result) == 100, "There should be 100 total verses."

    assert Enum.at(result, 97) ==
             "2 bottles of soda on the wall.\n2 bottles of soda.\nTake one down, pass it around.\n1 bottle of soda on the wall."

    assert Enum.at(result, 98) ==
             "1 bottle of soda on the wall.\n1 bottle of soda.\nTake one down, pass it around.\n0 bottles of soda on the wall."

    assert Enum.at(result, 99) ==
             "No more bottles of soda on the wall, no more bottles of soda.\nGo to the store and buy some more, 99 bottles of soda on the wall."

    assert result == Utils.Solutions.BottlesOfSoda.on_the_wall()
  end

  feedback :bottles_of_blank do
    bottles_of_soda = get_answers()

    result = bottles_of_soda.on_the_wall(50..0, "pop", "cans")

    assert result, "Implement the `on_the_wall/3` function."

    assert is_list(result), "`on_the_wall/3` should return a list."

    assert Enum.at(result, 0) ==
             "50 cans of pop on the wall.\n50 cans of pop.\nTake one down, pass it around.\n49 cans of pop on the wall."

    assert length(result) == 51, "There should be 51 total verses."

    assert Enum.at(result, 48) ==
             "2 cans of pop on the wall.\n2 cans of pop.\nTake one down, pass it around.\n1 can of pop on the wall."

    assert Enum.at(result, 49) ==
             "1 can of pop on the wall.\n1 can of pop.\nTake one down, pass it around.\n0 cans of pop on the wall."

    assert Enum.at(result, 50) ==
             "No more cans of pop on the wall, no more cans of pop.\nGo to the store and buy some more, 99 cans of pop on the wall."
  end

  feedback :item_generator_item do
    item = get_answers()

    assert Keyword.get(item.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{type: nil, effect: nil, level: nil, size: nil, style: nil}, struct(item)),
           "Ensure you use `defstruct` with :type, :effect, :level, :size, and :style."
  end

  feedback :item_generator do
    items = get_answers()

    assert is_list(items), "`items` should be a list."

    expected_items = Utils.Solutions.item_generator()

    expected_length = length(expected_items)

    assert length(items) == expected_length,
           "There should be #{expected_length} permutations of items."

    Enum.each(items, fn item ->
      assert is_struct(item), "Each item should be an `Item` struct."
      assert match?(%{type: _, effect: _, style: _, size: _, level: _, __struct__: _}, item)
    end)
  end

  feedback :item_generator_search do
    search = get_answers()
    items = [Utils.Factory.item(%{}), Utils.Factory.item()]
    result = search.all_items(items, [])
    assert result, "Implement the `all_items/2` function."
    assert is_list(result), "`all_items/2` should return a list."

    assert length(result) == 2,
           "`all_items/2` should return all items when no filters are provided."

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

  # test names must be after tests that require a solution.
  def test_names, do: @test_names

  feedback :created_project do
    path = get_answers()

    assert File.dir?("../projects/#{path}"),
           "Ensure you create a mix project `#{path}` in the `projects` folder."
  end
end

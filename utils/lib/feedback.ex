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

  feedback :rock_paper_scissors_pattern_matching do
    rock_paper_scissors = get_answers()

    assert rock_paper_scissors.play(:rock, :rock) == "draw",
           "Ensure you implement the RockPaperScissors.play/2 function."

    assert rock_paper_scissors.play(:paper, :paper) == "draw"
    assert rock_paper_scissors.play(:scissors, :scissors) == "draw"

    assert rock_paper_scissors.play(:rock, :scissors) == ":rock beats :scissors!"
    assert rock_paper_scissors.play(:scissors, :paper) == ":scissors beats :paper!"
    assert rock_paper_scissors.play(:paper, :rock) == ":paper beats :rock!"

    assert rock_paper_scissors.play(:rock, :paper) == ":paper beats :rock!"
    assert rock_paper_scissors.play(:scissors, :rock) == ":rock beats :scissors!"
    assert rock_paper_scissors.play(:paper, :scissors) == ":scissors beats :rock!"
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

    assert Enum.all?(answers, fn each -> is_binary(each) and String.length(each) > 0 end),
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

    assert Enum.all?(answers, fn each -> is_binary(each) and String.length(each) > 0 end),
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

    assert Enum.all?(answers, &is_binary/1),
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
    assert is_binary(correct), "Ensure `correct` is a string"

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

  feedback :custom_enum do
    list = Enum.to_list(1..10)

    custom_enum = get_answers()
    assert custom_enum.map(list, & &1), "Implement the `map/2` funtion."
    assert is_list(custom_enum.map(list, & &1)), "`map/2` should return a list."

    assert custom_enum.map(list, &(&1 * 2)) == Enum.map(list, &(&1 * 2)),
           "`map/2` should call the function on each element and return a new list."

    assert custom_enum.each(list, & &1), "Implement the `each/2` funtion."
    assert custom_enum.each(list, & &1) == :ok, "`each/2` should return :ok."

    assert custom_enum.filter(list, & &1), "Implement the `filter/2` funtion."
    assert is_list(custom_enum.filter(list, & &1)), "`each/2` should return a list."

    assert custom_enum.filter(list, &(&1 < 5)) == Enum.filter(list, &(&1 < 5))

    assert custom_enum.sum(list), "Implement the `sum/1` funtion."
    assert is_integer(custom_enum.sum(list)), "`sum/1` should return an integer."

    assert custom_enum.sum(list) == Enum.sum(list)
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

  feedback :measurements do
    measurements = get_answers()
    list = Utils.Factory.integers()

    assert measurements.increased([1, 1]), "Implement the `increased` function."
    assert measurements.increased([1, 2, 1]) == 1
    assert measurements.increased([1, 1, 2, 3, 1]) == 2
    assert measurements.increased(list) == Utils.Solutions.Measurements.increased(list)

    assert measurements.increased_by([1, 1]), "Implement the `increased_by` function."
    assert measurements.increased_by([100, 150, 120, 130]) == 60
    assert measurements.increased_by([10, 20, 10, 40]) == 40
    assert measurements.increased_by(list) == Utils.Solutions.Measurements.increased_by(list)

    assert measurements.increments([1, 2]), "Implement the `increments` function."
    assert measurements.increments([100, 150, 120, 130]) == [50, -30, 10]
    assert measurements.increments([10, 20, 10, 40]) == [10, -10, 30]
    assert measurements.increments(list) == Utils.Solutions.Measurements.increments(list)

    assert measurements.average([1, 1]), "Implement the `average` function."
    assert measurements.average([4, 5, 6]) == 5
    assert measurements.average([2, 10]) == 6
    assert measurements.average(list) == Utils.Solutions.Measurements.average(list)
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

    # colums
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

  feedback :tic_tak_toe do
    tic_tak_toe = get_answers()

    board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    assert tic_tak_toe.play(board, {0, 0}, "X"), "Ensure you implement the `play/3` function."

    assert tic_tak_toe.play(board, {0, 0}, "X") == [
             ["X", nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    assert tic_tak_toe.play(board, {0, 2}, "X") == [
             [nil, nil, "X"],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    assert tic_tak_toe.play(board, {1, 1}, "X") == [
             [nil, nil, nil],
             [nil, "X", nil],
             [nil, nil, nil]
           ]

    assert tic_tak_toe.play(board, {2, 2}, "X") == [
             [nil, nil, nil],
             [nil, nil, nil],
             [nil, nil, "X"]
           ]

    assert board
           |> tic_tak_toe.play({0, 0}, "X")
           |> tic_tak_toe.play({1, 1}, "O")
           |> tic_tak_toe.play({2, 2}, "X")
           |> tic_tak_toe.play({2, 1}, "O") ==
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
    assert today.minute == now.minute
    assert today.second == now.second
  end

  feedback :datetime_tomorrow do
    today = get_answers()

    now = DateTime.utc_now()
    assert today.year == now.year
    assert today.month == now.month
    assert today.day == now.day + 1
    assert today.hour == now.hour
    assert today.minute == now.minute
    assert today.second == now.second
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

    assert money.convert(money.new(500, :CAD), :EUR) == money.new(round(500 * 1.39), :EUR)

    assert %{amount: 10000, currency: :CAD} =
             money.add(money.new(500, :CAD), money.new(500, :CAD))

    assert money.subtract(money.new(10000, :US), 100) == money.new(9900, :US)

    assert = money.multiply(money.new(100, :CAD), 10) == money.new(1000, :CAD)

    assert_raise FunctionClauseError, fn ->
      money.add(money.new(500, :CAD), money.new(100, :US)) &&
        flunk(
          "Money.add/2 should only accept the same currency type or throw a FunctionClauseError."
        )
    end
  end

  feedback :metric_measurements do
    measurement = get_answers()

    conversion = [
      millimeter: 0.1,
      meter: 100,
      kilometer: 100_000,
      inch: 2.54,
      feet: 30,
      yard: 91,
      mile: 160_000
    ]

    assert measurement.convert({:milimeter, 1}, :centimeter),
           "Ensure you implement the `convert/2` function."

    assert measurement.convert({:milimeter, 1}, :centimeter) == {:centimeter, 0.1}

    # from centimeter
    Enum.each(conversion, fn {measure, amount} ->
      assert measurement.convert({:centimeter, 1}, measure) == {measure, 1 / amount}
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
    assert cypher.shift("z") == "a", "Ensure you handle the z special case. It should wrap around to a."
    assert cypher.shift("abcdefghijklmnopqrstuvwxyz") == "bcdefghijklmnopqrstuvwxyza"
  end

  # test_names must be after tests that require a solution.
  def test_names, do: @test_names

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

  feedback :jewel do
    jewel = get_answers()
    assert jewel == "jewel"
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

  feedback :number_wordle do
    number_wordle = get_answers()

    assert number_wordle.feedback(1111, 9999), "Ensure you implement the feedback/2 function."

    assert number_wordle.feedback(1111, 1111) == [:green, :green, :green, :green]
    assert number_wordle.feedback(1111, 2222) == [:gray, :gray, :gray, :gray]
    assert number_wordle.feedback(1111, 1122) == [:green, :green, :gray, :gray]
    assert number_wordle.feedback(1112, 2333) == [:gray, :gray, :gray, :yellow]
    assert number_wordle.feedback(2221, 1222) == [:yellow, :green, :green, :yellow]
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

  feedback :created_project do
    path = get_answers()

    assert File.dir?("../projects/#{path}"),
           "Ensure you create a mix project `#{path}` in the `projects` folder."
  end

  # Allows for tests that don't require input
  def test(test_name), do: test(test_name, "")

  def test(test_name, answers) do
    cond do
      test_name not in @test_names ->
        "Something went wrong, feedback does not exist for #{test_name}."

      Mix.env() == :test ->
        ExUnit.start(auto_run: false)
        test_module(test_name, answers)
        ExUnit.run()

      is_nil(answers) ->
        "Please enter your answer above."

      is_list(answers) and not Enum.any?(answers) ->
        "Please enter an answer above."

      true ->
        ExUnit.start(auto_run: false)
        test_module(test_name, answers)
        ExUnit.run()
    end
  end
end

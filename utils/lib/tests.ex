defmodule Utils.Test do
  @moduledoc """
  Utils.Test defines tests using the `make_test` macro.
  Each `make_test` macro creates an associated function.

  ## Examples

  ```elixir
  make_test :example do
    answer = get_answers()
    assert answer == 5
  end
  ```

  Creates a a Utils.test(:example, answers) function clause.
  """
  Module.register_attribute(Utils.Test, :test_module_names, accumulate: true)
  require Utils.Macros
  import Utils.Macros
  alias Utils.Solutions
  alias Utils.Factory

  # Allows for tests that don't require input
  def test(test_name), do: test(test_name, "")
  def test({:module, _, _, _} = module, test_name), do: test(test_name, module)

  def test(test_name, answers) do
    answers_in_list_provided =
      is_list(answers) and Enum.all?(answers, fn each -> not is_nil(each) end)

    answer_provided = not is_list(answers) and not is_nil(answers)

    if answer_provided or answers_in_list_provided do
      ExUnit.start(auto_run: false)
      test_module(test_name, answers)
      ExUnit.run()
    else
      "Please enter an answer above."
    end
  end

  def test_module(:card_count_four = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        next_count = @answers
        assert next_count == 1
      end
    end
  end

  def test_module(:card_count_king = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        next_count = @answers
        assert next_count === 4
      end
    end
  end

  def test_module(:card_count_random = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        [card, next_count] = @answers

        cond do
          card in 2..6 ->
            assert next_count === 1

          card in 7..9 ->
            assert next_count === 0

          card in 10..14 ->
            assert next_count === -1

          true ->
            raise "something went wrong, please reset the exercise with the help of your teacher."
        end
      end
    end
  end

  def test_module(:created_project = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        path = @answers

        assert File.dir?("../projects/#{path}"),
               "Ensure you create a mix project `#{path}` in the `projects` folder."
      end
    end
  end

  def test_module(:habit_tracker_definition = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        [small, medium, large] = @answers
        assert small = 5
        assert medium = 20
        assert large = 20
      end
    end
  end

  def test_module(:habit_tracker_add = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        total_points = @answers
        assert total_points == 20 + 5
      end
    end
  end

  def test_module(:habit_tracker_percentage = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        percentage = @answers
        assert percentage == (5 + 20) / 40 * 100
      end
    end
  end

  def test_module(:habit_tracker_penalties_1 = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        total_points = @answers
        assert total_points === 5 + 20 + 30 * 0.5
      end
    end
  end

  def test_module(:habit_tracker_penalties_2 = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        total_points = @answers
        assert total_points === 5 / 2 * 3 + 20 / 2 * 3
      end
    end
  end

  def test_module(:habit_tracker_rewards = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        total_points = @answers
        assert total_points === 20 * 1.6 + 5 * 1.6 + 30 * 0.5
      end
    end
  end

  def test_module(:percentage = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        [completed_items, total_items, percentage] = @answers
        assert percentage == completed_items / total_items * 100
      end
    end
  end

  def test_module(:pythagorean_c_square = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        c_square = @answers
        assert c_square == 10 ** 2 + 10 ** 2
      end
    end
  end

  def test_module(:pythagorean_c = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        c = @answers
        assert c == :math.sqrt(200)
      end
    end
  end

  def test_module(:string_concatenation = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        answer = @answers
        assert is_bitstring(answer), "the answer should be a string."
        assert "Hi, " <> _name = answer, "the answer should be in the format: Hi, name."
        assert Regex.match?(~r/Hi, \w+\./, answer), "the answer should end in a period."
      end
    end
  end

  def test_module(:string_interpolation = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        answer = @answers
        assert is_bitstring(answer), "the answer should be a string."

        assert "I have " <> name = answer,
               "the answer should be in the format: I have 10 classmates"

        assert Regex.match?(~r/I have \d+/, answer),
               "the answer should contain an integer for classmates."

        assert Regex.match?(~r/I have \d+ classmates\./, answer) ||
                 answer === "I have 1 classmate.",
               "the answer should end in a period."
      end
    end
  end

  def test_module(:tip_amount = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        [cost_of_the_meal, tip_rate, tip_amount] = @answers
        assert tip_rate === 0.20, "tip rate should be 0.20."
        assert cost_of_the_meal === 55.50, "cost_of_the_meal should be 55.50."

        assert tip_amount === cost_of_the_meal * tip_rate,
               "tip_amount should be cost_of_the_meal * tip_rate."
      end
    end
  end

  def test_module(:rock_paper_scissors_ai = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        [player_choice, ai_choice] = @answers

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
    end
  end

  make_test :rock_paper_scissors_two_player do
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

  make_test :rocket_ship do
    force = get_answers()
    assert force == 20
  end

  make_test :startup_madlib do
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

  make_test :nature_show_madlib do
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

  make_test :boolean_diagram1 do
    answer = get_answers()
    assert answer == false
  end

  make_test :boolean_diagram2 do
    answer = get_answers()
    assert answer == true
  end

  make_test :boolean_diagram3 do
    answer = get_answers()
    assert answer == false
  end

  make_test :boolean_diagram4 do
    answer = get_answers()
    assert answer == false
  end

  make_test :boolean_diagram5 do
    answer = get_answers()
    assert answer == true
  end

  make_test :boolean_diagram6 do
    answer = get_answers()
    assert answer == true
  end

  make_test :guess_the_word do
    [guess, answer, correct] = answers = get_answers()

    assert Enum.all?(answers, &is_bitstring/1),
           "Ensure `guess`, `answer`, and `correct` are all strings"

    if guess == answer do
      assert correct == "Correct!"
    else
      assert correct == "Incorrect."
    end
  end

  make_test :guess_the_number do
    [guess, answer, correct] = answers = get_answers()

    assert is_integer(guess), "Ensure `guess` is an integer"
    assert is_integer(answer), "Ensure `answer` is an integer"
    assert is_bitstring(correct), "Ensure `correct` is a string"

    cond do
      guess == answer -> assert correct == "Correct!"
      guess < answer -> assert correct == "Too low!"
      guess > answer -> assert correct == "Too high!"
    end
  end

  make_test :copy_file do
    file_name = get_answers()
    assert {:ok, "Copy me!"} = File.read("../data/#{file_name}")
  end

  make_test :shopping_list do
    shopping_list = get_answers()
    list = [] ++ ["grapes", "walnuts", "apples"]
    list = list ++ ["blueberries", "chocolate", "pizza"]
    list = list -- ["grapes", "walnuts"]

    assert is_list(shopping_list), "Ensure shopping_list is still a list."

    assert Enum.sort(shopping_list) == Enum.sort(shopping_list),
           "Ensure your shopping list has all of the expected items"

    assert shopping_list == list, "Ensure you add and remove items in the expected order"
  end

  make_test :shopping_list_with_quantities do
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

  make_test :family_tree do
    family_tree = get_answers()
    assert is_map(family_tree), "Ensure `family_tree is a map."
    assert family_tree == Solutions.family_tree()
  end

  make_test :naming_numbers do
    naming_numbers = get_answers()

    assert is_function(naming_numbers),
           "Ensure you bind `naming_numbers` to an anonymous function."

    list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

    Enum.each(1..9, fn integer ->
      assert naming_numbers.(integer) == Enum.at(list, integer)
    end)
  end

  make_test :numbering_names do
    numbering_names = get_answers()

    list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    capital_list = Enum.map(list, &String.capitalize/1)

    assert is_function(numbering_names),
           "Ensure you bind `naming_numbers` to an anonymous function."

    Enum.each(list, fn name ->
      assert numbering_names.(name) ==
               Enum.find_index(list, fn each -> each == String.downcase(name) end)
    end)
  end

  make_test :define_character_struct do
    character_module = get_answers()

    assert Keyword.get(character_module.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`"

    assert match?(%{name: nil, class: nil, weapon: nil}, struct(character_module)),
           "Ensure you use `defstruct` with :name, :class, and :weapon"

    assert_raise ArgumentError, fn ->
      struct!(character_module, %{weapon: "", class: ""})
    end
  end

  make_test :character_structs do
    [arthur, gandalf, jarlaxle] = get_answers()
    assert is_struct(arthur), "Ensure `arthur` is a struct."
    assert is_struct(gandalf), "Ensure `gandalf` is a struct."
    assert is_struct(jarlaxle), "Ensure `jarlaxle` is a struct."

    assert %{name: "Arthur", weapon: "sword", class: "warrior"} = arthur
    assert %{name: "Gandalf", weapon: "staff", class: "wizard"} = gandalf
    assert %{name: "Jarlaxle", weapon: "daggers", class: "rogue"} = jarlaxle
  end

  make_test :character_dialogue do
    dialogue_module = get_answers()

    character_permutations =
      for class <- ["wizard", "rogue", "warrior", nil],
          weapon <- ["daggers", "sword", "staff", nil],
          name <- [Factory.name(), nil] do
        %{class: class, weapon: weapon, name: name}
      end

    enemy = Factory.name()

    Enum.each(character_permutations, fn character ->
      assert apply(dialogue_module, :greet, [character]) ==
               "Hello, my name is #{character.name}."

      assert apply(dialogue_module, :attack, [character, enemy]) ==
               "#{character.name} attacks #{enemy} with a #{character.weapon}."

      relinquish_weapon_dialogue =
        case character.class do
          "rogue" -> "Fine, have my #{character.weapon}. I have more hidden anyway."
          "wizard" -> "You would not part an old man from his walking stick?"
          "warrior" -> "Have my #{character.weapon} then!"
          _ -> "My precious!"
        end

      assert apply(dialogue_module, :relinquish_weapon, [character]) == relinquish_weapon_dialogue

      matching_weapon_dialogue =
        case {character.class, character.weapon} do
          {"wizard", "staff"} -> "My lovely magical staff"
          {"rogue", "daggers"} -> "Hidden and deadly."
          {"warrior", "sword"} -> "My noble sword!"
          {_, nil} -> "I'm unarmed!"
          {_, _} -> "I'm not sure a #{character.weapon} suits a #{character.class}."
        end

      assert apply(dialogue_module, :matching_weapon, [character]) == matching_weapon_dialogue
    end)
  end

  make_test :define_pokemon_struct do
    pokemon_module = get_answers()

    assert Keyword.get(pokemon_module.__info__(:functions), :__struct__),
           "Ensure you use `defstruct`."

    assert match?(%{name: nil, type: nil, speed: nil}, struct(pokemon_module)),
           "Ensure you use `defstruct` with :name, :type, :health, :attack, and :speed."

    assert match?(%{health: 20, attack: 5}, struct(pokemon_module)),
           "Ensure :health has a default value of 20 and :attack has a default value of 5."
  end

  make_test :pokemon_structs do
    [charmander, bulbasaur, squirtle] = get_answers()
    assert is_struct(charmander), "Ensure `charmander` is a struct."
    assert is_struct(squirtle), "Ensure `squirtle` is a struct."
    assert is_struct(bulbasaur), "Ensure `bulbasaur` is a struct."

    assert %{name: "Charmander", type: :fire, attack: 5, health: 20, speed: 20} = charmander
    assert %{name: "Bulbasaur", type: :grass, attack: 5, health: 20, speed: 15} = bulbasaur
    assert %{name: "Squirtle", type: :water, attack: 5, health: 20, speed: 10} = squirtle
  end

  make_test :pokemon_battle do
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
      attacked_pokemon = apply(pokemon_battle_module, :attack, [pokemon1, pokemon2])

      multiplier = Utils.Solutions.PokemonBattle.multiplier(pokemon1, pokemon2)

      assert attacked_pokemon == %{
               pokemon2
               | health: pokemon2.health - pokemon2.attack * multiplier
             }

      assert {battled_pokemon1, battled_pokemon2} =
               apply(pokemon_battle_module, :battle, [pokemon1, pokemon2])

      {expected_battled_pokemon1, expected_battled_pokemon2} =
        Utils.Solutions.PokemonBattle.battle(pokemon1, pokemon2)

      assert battled_pokemon1 == expected_battled_pokemon1
      assert battled_pokemon2 == expected_battled_pokemon2
    end)
  end

  # test modules names must be the last function in this module
  def test_module_names, do: @test_module_names
end

defmodule Utils.Solutions do
  def startup_madlib do
    name_of_company = "a"
    a_defined_offering = "a"
    a_defined_audience = "a"
    solve_a_problem = "a"
    secret_sauce = "a"

    madlib =
      "My company, #{name_of_company} is developing #{a_defined_offering} to help #{a_defined_audience} #{solve_a_problem} with #{secret_sauce}."

    [
      madlib,
      name_of_company,
      a_defined_offering,
      a_defined_audience,
      solve_a_problem,
      secret_sauce
    ]
  end

  def nature_show_madlib do
    animal = "a"
    country = "a"
    plural_noun = "a"
    a_food = "a"
    type_of_screen_device = "a"
    noun = "a"
    verb1 = "a"
    verb2 = "a"
    adjective = "a"

    madlib =
      "The majestic #{animal} has roamed the forests of #{country} for thousands of years. Today she wanders in search of #{plural_noun}. She must find food to survive. While hunting for #{a_food}, she found a/an #{type_of_screen_device} hidden behind a #{noun}. She has never seen anything like this before. What will she do? With the device in her teeth, she tries to #{verb1}, but nothing happens. She takes it back to her family. When her family sees it, they quickly #{verb2}. Soon, the device becomes #{adjective}, and the family decides to put it back where they found it."

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
    ]
  end

  def rocket_ship do
    20
  end

  def rock_paper_scissors_two_player do
    player1_choice = Utils.random(:rock_paper_scissors)
    player2_choice = Utils.random(:rock_paper_scissors)

    winner =
      case {player1_choice, player2_choice} do
        {:rock, :scissors} -> :player1
        {:paper, :rock} -> :player1
        {:scissors, :paper} -> :player1
        {:scissors, :rock} -> :player2
        {:rock, :paper} -> :player2
        {:paper, :scissors} -> :player2
        _ -> :draw
      end

    [player1_choice, player2_choice, winner]
  end

  def boolean_diagram1, do: false
  def boolean_diagram2, do: true
  def boolean_diagram3, do: false
  def boolean_diagram4, do: false
  def boolean_diagram5, do: true
  def boolean_diagram6, do: true

  def guess_the_word do
    guess = Enum.random(["answer", "incorrect answer"])
    answer = "answer"
    correct = (guess == answer && "Correct!") || "Incorrect."
    [guess, answer, correct]
  end

  def guess_the_number do
    guess = Enum.random(1..9)
    answer = Enum.random(1..9)

    correct =
      (guess == answer && "Correct!") || (guess < answer && "Too low!") ||
        (guess > answer && "Too high!")

    [guess, answer, correct]
  end

  def shopping_list do
    shopping_list = [] ++ ["grapes", "walnuts", "apples"]
    shopping_list = shopping_list ++ ["blueberries", "chocolate", "pizza"]
    shopping_list = shopping_list -- ["grapes", "walnuts"]
    shopping_list = shopping_list ++ ["banana", "banana", "banana"]
    shopping_list
  end

  def shopping_list_with_quantities do
    list = [] ++ [milk: 1, eggs: 12]
    list = list ++ [bars_of_butter: 2, candies: 10]
    list = list -- [bars_of_butter: 2]
    list = list -- [candies: 10]
    list = list ++ [candies: 5]
    list
  end

  def copy_file do
    "copy_example"
  end

  def family_tree do
    han = %{
      name: "Han",
      status: :grand_parent,
      age: 81,
      parents: []
    }

    leia = %{
      name: "Leia",
      status: :grand_parent,
      age: 82,
      parents: []
    }

    uther = %{
      name: "Uther",
      status: :parent,
      age: 56,
      parents: [han, leia]
    }

    bob = %{
      name: "Bob",
      status: :grand_parent,
      age: 68,
      parents: []
    }

    bridget = %{
      name: "Bridget",
      status: :grand_parent,
      age: 70
    }

    ygraine = %{
      name: "Ygraine",
      status: :parent,
      age: 45,
      parents: [bob, bridget]
    }

    %{
      name: "Arthur",
      status: :child,
      age: 22,
      parents: [
        uther,
        ygraine
      ]
    }
  end

  def naming_numbers do
    fn integer ->
      list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
      Enum.at(list, integer)
    end
  end

  def numbering_names do
    fn name ->
      list = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
      Enum.find_index(list, fn each -> each == String.downcase(name) end)
    end
  end

  defmodule Character do
    @enforce_keys [:name]
    defstruct @enforce_keys ++ [:class, :weapon]
  end

  alias Utils.Solutions.Character

  def define_character_struct do
    Character
  end

  def character_structs do
    arthur = %Character{name: "Arthur", weapon: "sword", class: "warrior"}
    gandalf = %Character{name: "Gandalf", weapon: "staff", class: "wizard"}
    jarlaxle = %Character{name: "Jarlaxle", weapon: "daggers", class: "rogue"}

    [arthur, gandalf, jarlaxle]
  end

  defmodule Dialogue do
    def greet(character) do
      "Hello, my name is #{character.name}."
    end

    def attack(character, enemy) do
      "#{character.name} attacks #{enemy} with a #{character.weapon}."
    end

    def relinquish_weapon(character) do
      case character.class do
        "rogue" -> "Fine, have my #{character.weapon}. I have more hidden anyway."
        "wizard" -> "You would not part an old man from his walking stick?"
        "warrior" -> "Have my #{character.weapon} then!"
        _ -> "My precious!"
      end
    end

    def matching_weapon(character) do
      case {character.class, character.weapon} do
        {"wizard", "staff"} -> "My lovely magical staff"
        {"rogue", "daggers"} -> "Hidden and deadly."
        {"warrior", "sword"} -> "My noble sword!"
        {_, nil} -> "I'm unarmed!"
        {_, _} -> "I'm not sure a #{character.weapon} suits a #{character.class}."
      end
    end
  end

  def character_dialogue do
    Dialogue
  end

  defmodule Pokemon do
    defstruct [:name, :type, :speed, health: 20, attack: 5]
  end

  def define_pokemon_struct do
    Pokemon
  end

  def pokemon_structs do
    charmander = %Pokemon{name: "Charmander", type: :fire, speed: 20}
    bulbasaur = %Pokemon{name: "Bulbasaur", type: :grass, speed: 15}
    squirtle = %Pokemon{name: "Squirtle", type: :water, speed: 10}
    [charmander, bulbasaur, squirtle]
  end

  defmodule PokemonBattle do
    def multiplier(pokemon1, pokemon2) do
      case {pokemon1, pokemon2} do
        {:fire, :grass} -> 2
        {:water, :fire} -> 2
        {:grass, :water} -> 2
        {:fire, :water} -> 0.5
        {:water, :grass} -> 0.5
        {:grass, :fire} -> 0.5
        _ -> 1
      end
    end

    def attack(pokemon1, pokemon2) do
      %Pokemon{
        pokemon2
        | health: pokemon2.health - pokemon2.attack * multiplier(pokemon1, pokemon2)
      }
    end

    def battle(pokemon1, pokemon2) do
      # pokemon1 faster or same speed as pokemon2
      pokemon2 =
        if pokemon1.speed >= pokemon2.speed, do: attack(pokemon1, pokemon2), else: pokemon2

      pokemon1 =
        if pokemon1.speed >= pokemon2.speed and pokemon2.health > 0,
          do: attack(pokemon2, pokemon1),
          else: pokemon1

      # pokemon2 faster or same speed as pokemon1
      pokemon1 =
        if pokemon1.speed < pokemon2.speed, do: attack(pokemon2, pokemon1), else: pokemon1

      pokemon2 =
        if pokemon1.speed < pokemon2.speed and pokemon1.health > 0,
          do: attack(pokemon1, pokemon2),
          else: pokemon2

      {pokemon1, pokemon2}
    end
  end

  def pokemon_battle do
    [PokemonBattle, Pokemon]
  end

  defmodule RockPaperScissorsLizardSpock do
    defp beats?(p1, p2) do
      {p1, p2} in [
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

    def play(p1, p2) do
      cond do
        beats?(p1, p2) -> "#{p1} beats #{p2}."
        beats?(p2, p1) -> "#{p2} beats #{p1}."
        true -> "tie game, play again?"
      end
    end
  end

  def rock_paper_scissors_lizard_spock do
    RockPaperScissorsLizardSpock
  end

  def card_count_four do
    1
  end

  def card_count_king do
    4
  end

  def card_count_random do
    random_card = Utils.random(2..14)

    count = 0

    next_count = (random_card <= 6 && count + 1) || (random_card >= 10 && count - 1) || count
    [random_card, next_count]
  end

  def rock_paper_scissors_ai do
    player_choice = Enum.random([:rock, :paper, :scissors])

    ai_choice =
      (player_choice == :rock && :paper) || (player_choice == :paper && :scissors) ||
        (player_choice == :scissors && :rock)

    [player_choice, ai_choice]
  end

  def tip_amount do
    cost_of_the_meal = 55.5
    tip_rate = 0.2

    tip_amount = cost_of_the_meal * tip_rate

    [cost_of_the_meal, tip_rate, tip_amount]
  end

  def string_interpolation do
    "I have #{1 - 1} classmates."
  end

  def string_concatenation do
    "Hi, Peter."
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

  def habit_tracker_rewards do
    20 * 1.6 + 5 * 1.6 + 30 * 0.5
  end

  def habit_tracker_penalties_1 do
    5 + 20 + 30 * 0.5
  end

  def habit_tracker_penalties_2 do
    5 / 2 * 3 + 20 / 2 * 3
  end

  def habit_tracker_percentage do
    (5 + 20) / 40 * 100
  end

  def habit_tracker_add do
    20 + 5
  end

  def habit_tracker_definition do
    [5, 20, 30]
  end

  defmodule CustomGame do
    @enforce_keys [:rock, :paper, :scissors]
    defstruct @enforce_keys

    def new(rock, paper, scissors) do
      %__MODULE__{rock: rock, paper: paper, scissors: scissors}
    end

    def convert_choice(game, choice) do
      %{rock: rock, paper: paper, scissors: scissors} = game.rock

      case choice do
        ^rock -> :rock
        ^paper -> :paper
        ^scissors -> :scissors
      end
    end

    def beats?(game, player1, player2) do
      {convert_choice(game, player1), convert_choice(game, player2)} in [
        {:rock, :scissors},
        {:paper, :rock},
        {:scissors, :paper}
      ]
    end

    def play(game, player1, player2) do
      cond do
        beats?(game, player1, player2) ->
          "#{player1} beats #{player2}."

        beats?(game, player2, player1) ->
          "#{player2} beats #{player1}."

        true ->
          "draw"
      end
    end
  end

  def custom_rps do
    CustomGame
  end
end

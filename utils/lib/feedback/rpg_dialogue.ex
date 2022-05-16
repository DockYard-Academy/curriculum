defmodule Utils.Feedback.RpgDialogue do
  use Utils.Feedback.Assertion

  feedback :define_character_struct do
    character_module = get_answers()

    assert defines_struct?(character_module), "Ensure you use `defstruct`"

    assert struct_keys?(character_module, [:name, :class, :weapon]),
           "Ensure you use `defstruct` with :name, :class, and :weapon"

    assert_raise ArgumentError,
                 struct!(character_module, %{weapon: "", class: ""}),
                 "Use @enforce_keys to enforce the :name property."
  end

  feedback :character_structs do
    [arthur, gandalf, jarlaxle] = get_answers()
    assert is_struct(arthur), "Ensure `arthur` is a struct."
    assert is_struct(gandalf), "Ensure `gandalf` is a struct."
    assert is_struct(jarlaxle), "Ensure `jarlaxle` is a struct."
    assert match?(%{name: "Arthur", weapon: "sword", class: "warrior"}, arthur)
    assert match?(%{name: "Gandalf", weapon: "staff", class: "wizard"}, gandalf)
    assert match?(%{name: "Jarlaxle", weapon: "daggers", class: "rogue"}, jarlaxle)
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

  defmodule Character do
    @enforce_keys [:name]
    defstruct @enforce_keys ++ [:class, :weapon]
  end

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
end

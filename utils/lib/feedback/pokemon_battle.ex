defmodule Utils.Feedback.PokemonBattle do
  use Utils.Feedback.Assertion

  feedback :define_pokemon_struct do
    pokemon_module = get_answers()

    assert defines_struct?(pokemon_module), "Ensure you use `defstruct`."

    assert struct_keys?(pokemon_module, [:name, :type, :speed, :health, :attack]),
           "Ensure you use `defstruct` with :name, :type, :health, :attack, and :speed."

    assert match?(%{health: 20, attack: 5}, struct(pokemon_module)),
           "Ensure :health has a default value of 20 and :attack has a default value of 5."
  end

  feedback :pokemon_structs do
    [charmander, bulbasaur, squirtle] = get_answers()
    assert is_struct(charmander), "Ensure `charmander` is a struct."
    assert is_struct(squirtle), "Ensure `squirtle` is a struct."
    assert is_struct(bulbasaur), "Ensure `bulbasaur` is a struct."

    assert Map.from_struct(charmander) == %{
             name: "Charmander",
             type: :fire,
             attack: 5,
             health: 20,
             speed: 20
           }

    assert Map.from_struct(bulbasaur) == %{
             name: "Bulbasaur",
             type: :grass,
             attack: 5,
             health: 20,
             speed: 15
           }

    assert Map.from_struct(squirtle) == %{
             name: "Squirtle",
             type: :water,
             attack: 5,
             health: 20,
             speed: 10
           }
  end

  feedback :pokemon_battle do
    [pokemon_battle_module, pokemon_module] = get_answers()

    assert defines_struct?(pokemon_module),
           "Ensure you complete the `Pokemon` module above first."

    charmander =
      struct(pokemon_module, %{
        name: "Charmander",
        type: :fire,
        speed: 10,
        attack: 10,
        health: 10
      })

    bulbasaur =
      struct(pokemon_module, %{
        name: "Bulbasaur",
        type: :grass,
        speed: 10,
        attack: 10,
        health: 20
      })

    assert pokemon_battle_module.attack(charmander, charmander) ==
             struct(pokemon_module, Map.from_struct(charmander) |> Map.put(:health, 0)),
           "attack/2 should return the second pokemon struct with damage applied to the pokemon's :health."

    assert pokemon_battle_module.attack(charmander, bulbasaur) ==
             struct(pokemon_module, Map.from_struct(bulbasaur) |> Map.put(:health, 0)),
           """
           Ensure you take type advantage into account for attack/2.

           A :fire type pokemon should deal double damage to a :grass type pokemon.
           """

    assert pokemon_battle_module.attack(bulbasaur, charmander) ==
             struct(pokemon_module, Map.from_struct(charmander) |> Map.put(:health, 5)),
           """
           Ensure you take type advantage into account for attack/2.

           A :grass type pokemon should deal half damage to a :fire type pokemon.
           """
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
        | health: pokemon2.health - pokemon1.attack * multiplier(pokemon1.type, pokemon2.type)
      }
    end
  end

  def pokemon_battle do
    [PokemonBattle, Pokemon]
  end
end

defmodule Utils.Test do
  def test(module_name, answers) when is_list(answers) do
    if Enum.all?(answers, fn each -> not is_nil(each) end) do
      ExUnit.start(auto_run: false)
      test_module(module_name, answers)
      ExUnit.run()
    else
      "Please enter an answer above. Replace each `nil` value with your answers."
    end
  end

  def test(module_name, answers) do
    if not is_nil(answers) do
      ExUnit.start(auto_run: false)
      test_module(module_name, answers)
      ExUnit.run()
    else
      "Please enter an answer above. Replace `nil` with your answer."
    end
  end

  def test_module(:example_test = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        assert true
      end
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

  def test_module(:naming_numbers = module_name, answers) do
    :persistent_term.put(:answers, answers)

    defmodule module_name do
      use ExUnit.Case

      test module_name do
        convert_to_named_integer = :persistent_term.get(:answers)

        ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        |> Enum.with_index()
        |> Enum.each(fn {value, key} ->
          assert convert_to_named_integer.(key) == value
        end)
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

  def test_module(:rock_paper_scissors_two_player = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        [player1_choice, player2_choice, winner] = @answers

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
    end
  end

  def test_module(:rocket_ship = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        force = @answers
        assert force == 20
      end
    end
  end

  def test_module(:file_copy_challenge = module_name, answers) do
    defmodule module_name do
      @answers answers
      use ExUnit.Case

      test module_name do
        assert File.read("data/copied_example") === "Copy me!"
      end
    end
  end
end

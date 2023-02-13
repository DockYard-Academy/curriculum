defmodule Faker.Util do
  import Faker, only: [localize: 1]

  @moduledoc """
  Collection of useful functions for your fake data. Functions aware of locale.
  """

  @doc """
  Pick a random element from an enumerable. Can also be provided a blacklist enumerable as a second argument.

  ## Examples

      iex> Faker.Util.pick(10..100)
      79
      iex> Faker.Util.pick([1, 3, 5, 7])
      3
      iex> Faker.Util.pick([true, false, nil])
      true
      iex> Faker.Util.pick(["a", "b", "c"], ["b"])
      "a"
      iex> Faker.Util.pick([1, "2", 3.0], 1..10)
      "2"
  """

  @spec pick(Enum.t(), Enum.t()) :: any
  def pick(enum, blacklist)

  def pick(enum, blacklist) do
    Enum.reject(enum, fn el -> Enum.member?(blacklist, el) end)
    |> pick()
  end

  def pick(enum) do
    Enum.at(enum, Faker.random_between(0, Enum.count(enum) - 1))
  end

  @doc """
  Generate N unique elements

  ## Examples

      iex> Faker.Util.sample_uniq(2, &Faker.Internet.email/0)
      ["conor2058@schiller.com", "elizabeth2056@rolfson.net"]

      iex> Faker.Util.sample_uniq(10, fn -> Faker.String.base64(4) end)
      ["1tmL", "29Te", "Byiy", "Kfp7", "Z7xb", "lk8z", "pI0P", "yGb0", "ye3Q", "yfOB"]

      iex> Faker.Util.sample_uniq(1, &Faker.Phone.EnUs.area_code/0)
      ["825"]

      iex> Faker.Util.sample_uniq(0, &Faker.Internet.email/0)
      ** (FunctionClauseError) no function clause matching in Faker.Util.sample_uniq/3
  """
  @spec sample_uniq(pos_integer, (() -> any), MapSet.t()) :: [any]
  def sample_uniq(count, sampler, acc \\ MapSet.new())
      when is_integer(count) and count > 0 and is_function(sampler, 0) do
    case MapSet.size(acc) do
      ^count ->
        MapSet.to_list(acc)

      _ ->
        acc = MapSet.put(acc, sampler.())

        sample_uniq(count, sampler, acc)
    end
  end

  @doc """
  Execute fun n times with the index as first param and return the results as a list

  ## Examples

      iex> Faker.Util.list(3, &(&1))
      [0, 1, 2]
      iex> Faker.Util.list(3, &(&1 + 1))
      [1, 2, 3]
      iex> Faker.Util.list(5, &(&1 * &1))
      [0, 1, 4, 9, 16]
      iex> Faker.Util.list(3, &(to_string(&1)))
      ["0", "1", "2"]
  """
  @spec list(integer, (integer -> any)) :: [any]
  def list(n, fun) when is_function(fun, 1) do
    Enum.map(0..(n - 1), &fun.(&1))
  end

  @spec list(integer, (() -> any)) :: [any]
  def list(n, fun) when is_function(fun, 0) do
    Enum.map(0..(n - 1), fn _ -> fun.() end)
  end

  @doc """
  Execute fun n times with the index as first param and join the results with joiner

  ## Examples

      iex> Faker.Util.join(3, ", ", &Faker.Code.isbn13/0)
      "9781542646109, 9783297052358, 9790203032090"
      iex> Faker.Util.join(4, "-", fn -> Faker.format("####") end)
      "7337-6033-7459-8109"
      iex> Faker.Util.join(2, " vs ", &Faker.Superhero.name/0)
      "Falcon vs Green Blink Claw"
      iex> Faker.Util.join(2, " or ", &Faker.Color.name/0)
      "Purple or White"
  """
  @spec join(integer, binary, (() -> binary)) :: binary
  def join(n, joiner \\ "", fun) do
    Enum.join(list(n, fun), joiner)
  end

  @doc """
  Get a random digit as a string; one of 0-9

  ## Examples

      iex> Faker.Util.digit()
      "0"
      iex> Faker.Util.digit()
      "1"
      iex> Faker.Util.digit()
      "5"
      iex> Faker.Util.digit()
      "4"
  """
  @spec digit() :: binary
  localize(:digit)

  @doc """
  Converts a list to a string, with "and" before the last item. Uses an Oxford comma.

  ## Examples

      iex> Faker.Util.to_sentence(["Black", "White"])
      "Black and White"
      iex> Faker.Util.to_sentence(["Jon Snow"])
      "Jon Snow"
      iex> Faker.Util.to_sentence(["Oceane", "Angeline", "Nicholas"])
      "Angeline, Nicholas, and Oceane"
      iex> Faker.Util.to_sentence(["One", "Two", "Three", "Four"])
      "Two, Three, Four, and One"
  """
  @spec to_sentence([binary]) :: binary
  def to_sentence(items) do
    Module.concat(__MODULE__, Faker.mlocale()).to_sentence(items)
  end

  @doc """
  Get a random alphabet character as a string; one of a-z or A-Z

  ## Examples

      iex> Faker.Util.letter()
      "E"
      iex> Faker.Util.letter()
      "L"
      iex> Faker.Util.letter()
      "R"
      iex> Faker.Util.letter()
      "C"
      iex> Faker.Util.letter()
      "e"
  """
  @spec letter() :: binary
  localize(:letter)

  @doc """
  Get a random lowercase character as a string; one of a-z

  ## Examples

      iex> Faker.Util.lower_letter()
      "e"
      iex> Faker.Util.lower_letter()
      "l"
      iex> Faker.Util.lower_letter()
      "r"
      iex> Faker.Util.lower_letter()
      "c"
  """
  @spec lower_letter() :: binary
  localize(:lower_letter)

  @doc """
  Get a random uppercase character as a string; one of A-Z

  ## Examples

      iex> Faker.Util.upper_letter()
      "E"
      iex> Faker.Util.upper_letter()
      "L"
      iex> Faker.Util.upper_letter()
      "R"
      iex> Faker.Util.upper_letter()
      "C"
  """
  @spec upper_letter() :: binary
  localize(:upper_letter)

  @doc """
  Start a cycle. See cycle/1
  """
  @spec cycle_start([any]) :: pid
  def cycle_start(items) do
    {:ok, cycle_pid} = Agent.start_link(fn -> {[], items} end)
    cycle_pid
  end

  @doc """
  Cycle randomly through the given list with guarantee every element of the list is used once before
  elements are being picked again. This is done by keeping a list of remaining elements that have
  not been picked yet. The list of remaining element is returned, as well as the randomly picked
  element.
  """
  @spec cycle(pid) :: any
  def cycle(cycle_pid) do
    Agent.get_and_update(cycle_pid, fn
      {[], items} ->
        [h | t] = Enum.shuffle(items)
        {h, {t, items}}

      {[h | t], items} ->
        {h, {t, items}}
    end)
  end

  @doc """
  Format a string with randomly generated data. Format specifiers are replaced by random values. A
  format specifier follows this prototype:

      %[length]specifier

  The following specifier rules are present by default:

    - **d**: digits 0-9
    - **a**: lowercase letter a-z
    - **A**: uppercase letter A-Z
    - **b**: anycase letter a-z, A-Z

  The specifier rules can be overridden using the second argument.

  ## Examples

      iex> Faker.Util.format("%2d-%3d %a%A %2d%%")
      "01-542 aS 61%"
      iex> Faker.Util.format("%8nBATMAN", n: fn() -> "nana " end)
      "nana nana nana nana nana nana nana nana BATMAN"
  """
  @spec format(binary, Keyword.t()) :: binary
  def format(
        format_str,
        rules \\ [d: &digit/0, A: &upper_letter/0, a: &lower_letter/0, b: &letter/0]
      ) do
    Regex.replace(~r/%(?:%|(\d*)([a-zA-Z]))/, format_str, &format_replace(&1, &2, &3, rules))
  end

  defp format_replace("%%", _, _, _), do: "%"

  defp format_replace(_, "", rule_char, rules) do
    format_replace(nil, 1, rule_char, rules)
  end

  defp format_replace(_, length_str, rule_char, rules) when is_binary(length_str) do
    format_replace(nil, String.to_integer(length_str), rule_char, rules)
  end

  defp format_replace(_, n, rule_char, rules) when is_integer(n) do
    rule_key = String.to_existing_atom(rule_char)

    case rules[rule_key] do
      fun when is_function(fun) -> join(n, fun)
      _ -> raise "Rule #{rule_key} not found or not a function"
    end
  end
end

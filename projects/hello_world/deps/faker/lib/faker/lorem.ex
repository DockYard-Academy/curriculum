defmodule Faker.Lorem do
  import Faker, only: [sampler: 2]

  alias Faker.Util

  @moduledoc """
  Functions for generating Lorem Ipsum data
  """

  @doc """
  Returns a random word from @data

  ## Examples

      iex> Faker.Lorem.word()
      "aliquam"
      iex> Faker.Lorem.word()
      "ut"
      iex> Faker.Lorem.word()
      "sint"
      iex> Faker.Lorem.word()
      "deleniti"
  """
  @spec word() :: String.t()
  sampler(:word, [
    "alias",
    "consequatur",
    "aut",
    "perferendis",
    "sit",
    "voluptatem",
    "accusantium",
    "doloremque",
    "aperiam",
    "eaque",
    "ipsa",
    "quae",
    "ab",
    "illo",
    "inventore",
    "veritatis",
    "et",
    "quasi",
    "architecto",
    "beatae",
    "vitae",
    "dicta",
    "sunt",
    "explicabo",
    "aspernatur",
    "aut",
    "odit",
    "aut",
    "fugit",
    "sed",
    "quia",
    "consequuntur",
    "magni",
    "dolores",
    "eos",
    "qui",
    "ratione",
    "voluptatem",
    "sequi",
    "nesciunt",
    "neque",
    "dolorem",
    "ipsum",
    "quia",
    "dolor",
    "sit",
    "amet",
    "consectetur",
    "adipisci",
    "velit",
    "sed",
    "quia",
    "non",
    "numquam",
    "eius",
    "modi",
    "tempora",
    "incidunt",
    "ut",
    "labore",
    "et",
    "dolore",
    "magnam",
    "aliquam",
    "quaerat",
    "voluptatem",
    "ut",
    "enim",
    "ad",
    "minima",
    "veniam",
    "quis",
    "nostrum",
    "exercitationem",
    "ullam",
    "corporis",
    "nemo",
    "enim",
    "ipsam",
    "voluptatem",
    "quia",
    "voluptas",
    "sit",
    "suscipit",
    "laboriosam",
    "nisi",
    "ut",
    "aliquid",
    "ex",
    "ea",
    "commodi",
    "consequatur",
    "quis",
    "autem",
    "vel",
    "eum",
    "iure",
    "reprehenderit",
    "qui",
    "in",
    "ea",
    "voluptate",
    "velit",
    "esse",
    "quam",
    "nihil",
    "molestiae",
    "et",
    "iusto",
    "odio",
    "dignissimos",
    "ducimus",
    "qui",
    "blanditiis",
    "praesentium",
    "laudantium",
    "totam",
    "rem",
    "voluptatum",
    "deleniti",
    "atque",
    "corrupti",
    "quos",
    "dolores",
    "et",
    "quas",
    "molestias",
    "excepturi",
    "sint",
    "occaecati",
    "cupiditate",
    "non",
    "provident",
    "sed",
    "ut",
    "perspiciatis",
    "unde",
    "omnis",
    "iste",
    "natus",
    "error",
    "similique",
    "sunt",
    "in",
    "culpa",
    "qui",
    "officia",
    "deserunt",
    "mollitia",
    "animi",
    "id",
    "est",
    "laborum",
    "et",
    "dolorum",
    "fuga",
    "et",
    "harum",
    "quidem",
    "rerum",
    "facilis",
    "est",
    "et",
    "expedita",
    "distinctio",
    "nam",
    "libero",
    "tempore",
    "cum",
    "soluta",
    "nobis",
    "est",
    "eligendi",
    "optio",
    "cumque",
    "nihil",
    "impedit",
    "quo",
    "porro",
    "quisquam",
    "est",
    "qui",
    "minus",
    "id",
    "quod",
    "maxime",
    "placeat",
    "facere",
    "possimus",
    "omnis",
    "voluptas",
    "assumenda",
    "est",
    "omnis",
    "dolor",
    "repellendus",
    "temporibus",
    "autem",
    "quibusdam",
    "et",
    "aut",
    "consequatur",
    "vel",
    "illum",
    "qui",
    "dolorem",
    "eum",
    "fugiat",
    "quo",
    "voluptas",
    "nulla",
    "pariatur",
    "at",
    "vero",
    "eos",
    "et",
    "accusamus",
    "officiis",
    "debitis",
    "aut",
    "rerum",
    "necessitatibus",
    "saepe",
    "eveniet",
    "ut",
    "et",
    "voluptates",
    "repudiandae",
    "sint",
    "et",
    "molestiae",
    "non",
    "recusandae",
    "itaque",
    "earum",
    "rerum",
    "hic",
    "tenetur",
    "a",
    "sapiente",
    "delectus",
    "ut",
    "aut",
    "reiciendis",
    "voluptatibus",
    "maiores",
    "doloribus",
    "asperiores",
    "repellat"
  ])

  @doc """
  Returns a character list of the given length.

  If a range is provided, the length of the list is random in between the
  specified range.

  Defaults to a range between 15 and 255 (inclusive).

  ## Examples

      iex> Faker.Lorem.characters()
      'ppkQqaIfGqxsjFoNITNnu6eXyJicLJNth88PrhGDhwp4LNQMt5pCFh7XGEZUiBOjqwcnSUTH94vu8a9XKUwNAs48lHzPITbFXSfTS0pHfBSmHkbj9kOsd7qRuGeXKTgCgI1idI3uwENwTqc'
      iex> Faker.Lorem.characters(3..5)
      'EFbv'
      iex> Faker.Lorem.characters(2)
      'vx'
      iex> Faker.Lorem.characters(7)
      'jycADSd'
  """
  @spec characters(integer | Range.t()) :: [char]
  def characters(range_or_length \\ 15..255)

  def characters(first..last) do
    characters(Faker.random_between(first, last))
  end

  def characters(num) do
    char = &character/0

    char
    |> Stream.repeatedly()
    |> Enum.take(num)
  end

  @doc """
  Returns a string with a given amount of sentences.

  If a range is provided, the number of sentences is random in between the
  specified range.

  Defaults to a range between 2 and 5 (inclusive).

  ## Examples

      iex> Faker.Lorem.paragraph()
      "Deleniti consequatur et qui vitae et. Sit aut expedita cumque est necessitatibus beatae ex sunt! Soluta asperiores qui vitae animi et id et vitae. Quisquam corporis quisquam ab harum!"
      iex> Faker.Lorem.paragraph(1..2)
      "Numquam maxime ut aut inventore eius rerum beatae. Qui officia vel quaerat expedita."
      iex> Faker.Lorem.paragraph(1)
      "Perspiciatis rerum nam repellendus inventore nihil."
      iex> Faker.Lorem.paragraph(2)
      "Sequi ducimus qui voluptates magni quisquam sed odio. Vel error non impedit tempora minus."
  """
  @spec paragraph(integer | Range.t()) :: String.t()
  def paragraph(range \\ 2..5)

  def paragraph(first..last) do
    paragraph(Faker.random_between(first, last))
  end

  def paragraph(num) do
    Enum.join(sentences(num), " ")
  end

  @doc """
  Returns a list with a given amount of paragraphs.

  If a range is provided, the number of paragraphs is random in between the
  specified range.

  Defaults to a range between 2 and 5 (inclusive)

  ## Examples

      iex> Faker.Lorem.paragraphs()
      ["Consequatur et qui vitae? Et sit aut expedita cumque est necessitatibus beatae ex. Possimus soluta asperiores qui vitae.", "Et vitae vitae ut quisquam corporis quisquam ab harum ipsa. Numquam maxime ut aut inventore eius rerum beatae. Qui officia vel quaerat expedita. Perspiciatis rerum nam repellendus inventore nihil. Sequi ducimus qui voluptates magni quisquam sed odio.", "Error non impedit tempora minus voluptatem qui fugit. Ab consectetur harum earum possimus. Provident quisquam modi accusantium eligendi numquam illo voluptas. Est non id quibusdam qui omnis?", "Dicta dolores at ut delectus magni atque eos beatae nulla. Laudantium qui dolorem pariatur voluptatibus sed et enim?"]
      iex> Faker.Lorem.paragraphs(2..3)
      ["Voluptate reiciendis repellat et praesentium quia sed nemo. Vero repellat cumque nihil similique repudiandae corrupti rerum? Accusamus suscipit perspiciatis cum et sint dolore et ut. Eos reprehenderit cupiditate omnis et doloremque omnis.", "Quo et est culpa eum ex et veniam aut aut! Labore fuga tenetur alias est provident?", "Illo consequatur maiores illum et quia culpa sunt! Cumque porro ut eum porro est id maxime dolorum animi. Deserunt ipsa consequuntur eveniet asperiores. Quia numquam voluptas vitae repellat tempore."]
      iex> Faker.Lorem.paragraphs(1)
      ["Voluptas harum modi omnis quam dolor a aliquam officiis. Neque voluptas consequatur sed cupiditate dolorum pariatur et."]
      iex> Faker.Lorem.paragraphs(2)
      ["Voluptatem natus amet eius eos non dolorum quaerat dolores pariatur. Aliquam rerum ab voluptatem exercitationem nobis enim delectus tempore eos. Ex enim dolore ut consequuntur eaque expedita dicta eius totam. A eveniet ab magni rerum enim consequatur.", "Nihil laudantium ea veniam necessitatibus qui. Minus ad omnis quaerat quidem impedit sint. Id ut repellat qui repudiandae!"]
  """
  @spec paragraphs(integer | Range.t()) :: list(String.t())
  def paragraphs(range \\ 2..5)

  def paragraphs(first..last) do
    paragraphs(Faker.random_between(first, last))
  end

  def paragraphs(num) do
    paragraph = &paragraph/0

    paragraph
    |> Stream.repeatedly()
    |> Enum.take(num)
  end

  @doc """
  Returns a string with a given amount of words.

  If a range is provided, the number of words is random in between the
  specified range.

  Defaults to a range between 4 and 10 (inclusive).

  ## Examples

      iex> Faker.Lorem.sentence()
      "Sint deleniti consequatur et qui vitae et quibusdam et sit."
      iex> Faker.Lorem.sentence(2..3)
      "Cumque est?"
      iex> Faker.Lorem.sentence(3)
      "Beatae ex sunt."
      iex> Faker.Lorem.sentence(5)
      "Possimus soluta asperiores qui vitae."
  """
  @spec sentence(integer | Range.t()) :: String.t()
  def sentence(range \\ 4..10)

  def sentence(first..last) do
    Faker.random_between(first, last)
    |> sentence(Util.pick([".", ".", ".", "!", "?"]))
  end

  def sentence(num) do
    sentence(num, Util.pick([".", ".", ".", "!", "?"]))
  end

  @doc """
  Returns a string with an amount of words equal to the parameter provided,
  concatenating the specified mark

  ## Examples

      iex> Faker.Lorem.sentence(7, "...")
      "Aliquam ut sint deleniti consequatur et qui..."
      iex> Faker.Lorem.sentence(1, "?")
      "Vitae?"
      iex> Faker.Lorem.sentence(5, ".")
      "Et quibusdam et sit aut."
      iex> Faker.Lorem.sentence(3, ";")
      "Expedita cumque est;"
  """
  @spec sentence(integer, binary) :: String.t()
  def sentence(num, mark) when is_integer(num) and is_binary(mark) do
    tmp =
      num
      |> words()
      |> Enum.join(" ")
      |> String.capitalize()

    tmp <> mark
  end

  @doc """
  Returns a list of strings of the given length, each representing a sentence.

  If a range is provided, the length of the list is random in between the
  specified range.

  Defaults to a range between 2 and 5 (inclusive).

  ## Examples

      iex> Faker.Lorem.sentences()
      ["Deleniti consequatur et qui vitae et.", "Sit aut expedita cumque est necessitatibus beatae ex sunt!", "Soluta asperiores qui vitae animi et id et vitae.", "Quisquam corporis quisquam ab harum!"]
      iex> Faker.Lorem.sentences(3..4)
      ["Numquam maxime ut aut inventore eius rerum beatae.", "Qui officia vel quaerat expedita.", "Perspiciatis rerum nam repellendus inventore nihil.", "Sequi ducimus qui voluptates magni quisquam sed odio."]
      iex> Faker.Lorem.sentences(4)
      ["Vel error non impedit tempora minus.", "Fugit cupiditate fuga ab consectetur harum earum possimus totam.", "Quisquam modi accusantium eligendi numquam.", "Quod blanditiis est non id quibusdam qui omnis alias!"]
      iex> Faker.Lorem.sentences(3)
      ["Dicta dolores at ut delectus magni atque eos beatae nulla.", "Laudantium qui dolorem pariatur voluptatibus sed et enim?", "Minima laudantium voluptate reiciendis repellat."]
  """
  @spec sentences(integer | Range.t()) :: [String.t()]
  def sentences(range \\ 2..5)

  def sentences(first..last) do
    sentences(Faker.random_between(first, last))
  end

  def sentences(num) do
    sentence = &sentence/0

    sentence
    |> Stream.repeatedly()
    |> Enum.take(num)
  end

  @doc """
  Returns a list of strings of the given length, each representing a word.

  If a range is provided, the length of the list is random in between the
  provided range.

  Defaults to a range between 3 and 6.

  ## Examples

      iex> Faker.Lorem.words()
      ["ut", "sint", "deleniti", "consequatur", "et"]
      iex> Faker.Lorem.words(1..2)
      ["vitae"]
      iex> Faker.Lorem.words(2)
      ["et", "quibusdam"]
      iex> Faker.Lorem.words(6)
      ["et", "sit", "aut", "expedita", "cumque", "est"]
  """
  @spec words(integer | Range.t()) :: [String.t()]
  def words(range \\ 3..6)

  def words(first..last) do
    words(Faker.random_between(first, last))
  end

  def words(num) do
    word = &word/0

    word
    |> Stream.repeatedly()
    |> Enum.take(num)
  end

  defp character do
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    Enum.at(alphabet, Faker.random_between(0, Enum.count(alphabet) - 1))
  end
end

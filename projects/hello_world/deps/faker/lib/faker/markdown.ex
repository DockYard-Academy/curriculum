defmodule Faker.Markdown do
  import Faker, only: [random_between: 2]

  alias Faker.Lorem
  alias Faker.Util

  @moduledoc """
  Functions for generating random markdown
  """

  @headers ["#", "##", "###", "####", "#####", "######"]
  @emphasis ["_", "~", "*", "**"]
  @langs ["elixir", "erlang", "ruby", "go", "shell"]

  @doc """
  Returns a random markdown header

  ## Examples

      iex> Faker.Markdown.headers()
      "###### Aliquam"
      iex> Faker.Markdown.headers()
      "### Sint"
      iex> Faker.Markdown.headers()
      "# Consequatur"
      iex> Faker.Markdown.headers()
      "### Qui"
      iex> Faker.Markdown.headers()
      "# Et"
  """
  @spec headers() :: String.t()
  def headers do
    header = Lorem.word() |> String.capitalize()
    "#{Util.pick(@headers)} #{header}"
  end

  @doc """
  Returns a random sentence with random emphasis word

  ## Examples

      iex> Faker.Markdown.emphasis()
      "Deleniti consequatur et qui vitae et. Sit _aut_ expedita cumque est necessitatibus beatae ex sunt!"
      iex> Faker.Markdown.emphasis()
      "Vitae animi *et* id et vitae! Quisquam corporis quisquam ab harum!"
      iex> Faker.Markdown.emphasis()
      "Ut aut inventore eius! Aut doloribus qui officia vel quaerat. Et perspiciatis rerum nam repellendus inventore nihil _dicta_ ipsum."
      iex> Faker.Markdown.emphasis()
      "Quisquam sed odio accusamus et vel error non impedit tempora. _Qui_ fugit cupiditate fuga ab consectetur harum earum! Nobis provident quisquam modi accusantium eligendi numquam!"
  """
  @spec emphasis() :: String.t()
  def emphasis do
    paragraph = Lorem.paragraph(2..3)
    words = String.split(paragraph, " ")
    position = random_between(0, Enum.count(words) - 1)
    formatting = Util.pick(@emphasis)

    words
    |> List.update_at(position, &"#{formatting}#{&1}#{formatting}")
    |> Enum.join(" ")
  end

  @doc """
  Returns a random ordered list

  ## Examples

      iex> Faker.Markdown.ordered_list()
      "1. Deleniti consequatur et qui vitae et."
      iex> Faker.Markdown.ordered_list()
      "1. Aut expedita cumque est necessitatibus beatae ex sunt!"
      iex> Faker.Markdown.ordered_list()
      "1. Asperiores qui vitae animi et id et vitae vitae.\\n2. Corporis quisquam ab harum ipsa sed veritatis.\\n3. Ut aut inventore eius!\\n4. Aut doloribus qui officia vel quaerat.\\n5. Et perspiciatis rerum nam repellendus inventore nihil dicta ipsum.\\n6. Qui voluptates magni quisquam sed odio accusamus et.\\n7. Non impedit tempora minus voluptatem qui fugit?\\n8. Ab consectetur harum earum possimus."
      iex> Faker.Markdown.ordered_list()
      "1. Quisquam modi accusantium eligendi numquam.\\n2. Quod blanditiis est non id quibusdam qui omnis alias!\\n3. Dicta dolores at ut delectus magni atque eos beatae nulla.\\n4. Laudantium qui dolorem pariatur voluptatibus sed et enim?"
  """
  @spec ordered_list() :: String.t()
  def ordered_list do
    list()
  end

  @doc """
  Returns a random unordered list

  ## Examples

      iex> Faker.Markdown.unordered_list()
      "* Deleniti consequatur et qui vitae et."
      iex> Faker.Markdown.unordered_list()
      "* Aut expedita cumque est necessitatibus beatae ex sunt!"
      iex> Faker.Markdown.unordered_list()
      "* Asperiores qui vitae animi et id et vitae vitae.\\n* Corporis quisquam ab harum ipsa sed veritatis.\\n* Ut aut inventore eius!\\n* Aut doloribus qui officia vel quaerat.\\n* Et perspiciatis rerum nam repellendus inventore nihil dicta ipsum.\\n* Qui voluptates magni quisquam sed odio accusamus et.\\n* Non impedit tempora minus voluptatem qui fugit?\\n* Ab consectetur harum earum possimus."
      iex> Faker.Markdown.unordered_list()
      "* Quisquam modi accusantium eligendi numquam.\\n* Quod blanditiis est non id quibusdam qui omnis alias!\\n* Dicta dolores at ut delectus magni atque eos beatae nulla.\\n* Laudantium qui dolorem pariatur voluptatibus sed et enim?"
  """
  @spec unordered_list() :: String.t()
  def unordered_list do
    list("*")
  end

  @spec list(nil | String.t()) :: String.t()
  defp list(marker \\ nil) do
    number = random_between(1, 10)

    1..number
    |> Stream.map(fn num ->
      marker = if is_nil(marker), do: "#{num}.", else: marker
      "#{marker} #{Lorem.sentence()}"
    end)
    |> Enum.join("\n")
  end

  @doc """
  Returns random inline code

  ## Examples

      iex> Faker.Markdown.inline_code()
      "`Sint deleniti consequatur et qui vitae et quibusdam et sit.`"
      iex> Faker.Markdown.inline_code()
      "`Cumque est necessitatibus beatae ex sunt soluta?`"
      iex> Faker.Markdown.inline_code()
      "`Asperiores qui vitae animi et id et vitae vitae.`"
      iex> Faker.Markdown.inline_code()
      "`Corporis quisquam ab harum ipsa sed veritatis.`"
  """
  @spec inline_code() :: String.t()
  def inline_code do
    "`#{Lorem.sentence()}`"
  end

  @doc """
  Returns random inline code

  ## Examples

      iex> Faker.Markdown.block_code()
      "```elixir\\nDeleniti consequatur et qui vitae et.\\n```"
      iex> Faker.Markdown.block_code()
      "```elixir\\nAut expedita cumque est necessitatibus beatae ex sunt!\\n```"
      iex> Faker.Markdown.block_code()
      "```ruby\\nAsperiores qui vitae animi et id et vitae vitae.\\n```"
      iex> Faker.Markdown.block_code()
      "```go\\nQuisquam ab harum ipsa sed veritatis numquam.\\n```"
  """
  @spec block_code() :: String.t()
  def block_code do
    """
    ```#{Util.pick(@langs)}
    #{Lorem.sentence()}
    ```\
    """
  end

  @doc """
  Returns random markdown table

  ## Examples

      iex> Faker.Markdown.table()
      "sint | deleniti | consequatur\\n---- | ---- | ----\\net | qui | vitae\\net | quibusdam | et\\nsit | aut | expedita\\ncumque | est | necessitatibus\\nbeatae | ex | sunt"
      iex> Faker.Markdown.table()
      "soluta | asperiores\\n---- | ----\\nqui | vitae\\nanimi | et\\nid | et\\nvitae | vitae\\nut | quisquam\\ncorporis | quisquam"
      iex> Faker.Markdown.table()
      "ipsa | sed | veritatis | numquam | maxime\\n---- | ---- | ---- | ---- | ----\\nut | aut | inventore | eius | rerum\\nbeatae | aut | doloribus | qui | officia\\nvel | quaerat | expedita | ut | et\\nperspiciatis | rerum | nam | repellendus | inventore"
      iex> Faker.Markdown.table()
      "ipsum | sequi | ducimus | qui | voluptates\\n---- | ---- | ---- | ---- | ----\\nmagni | quisquam | sed | odio | accusamus\\net | vel | error | non | impedit\\ntempora | minus | voluptatem | qui | fugit"
  """
  @spec table() :: String.t()
  def table do
    separator = " | "
    m_rows = random_between(2, 5) + 1
    n_cols = random_between(2, 5)

    header =
      "----"
      |> List.duplicate(n_cols)
      |> Enum.join(separator)

    0..m_rows
    |> Enum.map(fn _ ->
      Enum.map_join(1..n_cols, separator, fn _ -> Lorem.word() end)
    end)
    |> List.insert_at(1, header)
    |> Enum.join("\n")
  end

  @doc """
  Returns random markdown

  ## Examples

      iex> Faker.Markdown.markdown()
      "cumque | est | necessitatibus\\n---- | ---- | ----\\nbeatae | ex | sunt\\nsoluta | possimus | soluta\\nasperiores | qui | vitae\\n\\n* Et vitae vitae ut quisquam corporis quisquam ab harum ipsa.\\n* Numquam maxime ut aut inventore eius rerum beatae.\\n* Qui officia vel quaerat expedita.\\n* Perspiciatis rerum nam repellendus inventore nihil.\\n\\n`Sequi ducimus qui voluptates magni quisquam sed odio.`\\n\\n```elixir\\nError non impedit tempora minus voluptatem qui fugit.\\n```\\n\\n### Cupiditate"
      iex> Faker.Markdown.markdown()
      "_Illo_ voluptas quod blanditiis est non id quibusdam qui omnis. Odit dicta dolores at ut delectus magni atque eos? Labore voluptate laudantium qui.\\n\\n### Voluptatibus\\n\\nullam | similique | minima | laudantium\\n---- | ---- | ---- | ----\\nvoluptate | reiciendis | repellat | et\\npraesentium | quia | sed | nemo\\nminus | ea | vero | repellat\\ncumque | nihil | similique | repudiandae\\ncorrupti | rerum | sed | similique\\naccusamus | suscipit | perspiciatis | cum"
      iex> Faker.Markdown.markdown()
      "```erlang\\nSit delectus possimus quo et est culpa eum ex?\\n```\\n\\n1. Aut aut quisquam labore fuga tenetur alias.\\n2. Esse dicta ea illo consequatur!\\n3. Et quia culpa sunt sit eius cumque porro ut eum.\\n4. Id maxime dolorum animi!\\n5. Deserunt ipsa consequuntur eveniet asperiores.\\n6. Quia numquam voluptas vitae repellat tempore.\\n7. Harum voluptas harum modi omnis quam dolor a aliquam officiis?\\n8. Neque voluptas consequatur sed cupiditate dolorum pariatur et.\\n9. Aut voluptatem natus amet eius eos non dolorum.\\n\\n`Pariatur ex illo aliquam rerum ab voluptatem exercitationem nobis enim.`\\n\\nCorporis **unde** ex enim dolore ut consequuntur eaque! Eius totam nobis est."
      iex> Faker.Markdown.markdown()
      "Qui iusto quisquam minus ad omnis quaerat quidem _impedit!_ Qui id ut repellat qui repudiandae quia cumque excepturi laudantium.\\n\\n`Non consequatur molestiae laboriosam sit!`\\n\\n## Aperiam"
  """
  @spec markdown() :: String.t()
  def markdown do
    [
      :headers,
      :emphasis,
      :ordered_list,
      :unordered_list,
      :inline_code,
      :block_code,
      :table
    ]
    |> Enum.filter(fn _ ->
      Util.pick([true, false])
    end)
    |> Enum.shuffle()
    |> Stream.map(fn fun ->
      apply(__MODULE__, fun, [])
    end)
    |> Enum.join("\n\n")
  end
end

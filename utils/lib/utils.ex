defmodule Utils do
  @moduledoc """
  Documentation for `Utils`.
  """
  alias Kino.ValidatedForm

  defdelegate visual(visual_name, params), to: Utils.Visual

  def form(form_name), do: ValidatedForm.new(apply(Utils.Form, form_name, []))
  def constants(constant), do: apply(Utils.Constants, constant, [])
  def graph(graph_name), do: apply(Utils.Graph, graph_name, [])

  def random(:rock_paper_scissors), do: Enum.random([:rock, :paper, :scissors])
  defdelegate random(range), to: Enum

  def slide(slide_name), do: apply(Utils.Slide, slide_name, [])

  def table(:users_and_photos) do
    Kino.DataTable.new([[id: 1, image: "daily-bugel-photo.jpg"]], name: "Photos") |> Kino.render()
    Kino.DataTable.new([[id: 2, name: "Peter Parker"]], name: "Users")
  end

  def table(:user_photo_foreign_key) do
    Kino.DataTable.new([[id: 1, image: "daily-bugel-photo.jpg", user_id: 2]], name: "Photos")
    |> Kino.render()

    Kino.DataTable.new([[id: 2, name: "Peter Parker"]], name: "Users")
  end

  def table(table_name), do: Kino.DataTable.new(apply(Utils.Table, table_name, []))

  def feedback(description, answers) do
    Utils.Feedback.feedback(description, answers)
  rescue
    FunctionClauseError ->
      "Something went wrong, feedback does not exist for #{description}. Please speak to your teacher and/or reset the exercise."
  end
end

defmodule BlogWeb.PostHTML do
  use BlogWeb, :html

  embed_templates "post_html/*"

  @doc """
  Renders a post form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :current_user, :map, required: true
  attr :tag_options, :list, required: true
  attr :tag_ids, :list, required: true

  def post_form(assigns)
end

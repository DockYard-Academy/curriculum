defmodule BlogWeb.TagController do
  use BlogWeb, :controller

  alias Blog.Tags
  alias Blog.Tags.Tag

  plug :page_title

  def index(conn, _params) do
    tags = Tags.list_tags()
    render(conn, :index, tags: tags)
  end

  def new(conn, _params) do
    changeset = Tags.change_tag(%Tag{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Tags.create_tag(tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: ~p"/tags/#{tag}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    render(conn, :show, tag: tag)
  end

  def edit(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    changeset = Tags.change_tag(tag)
    render(conn, :edit, tag: tag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    case Tags.update_tag(tag, tag_params) do
      {:ok, tag} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: ~p"/tags/#{tag}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, tag: tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    {:ok, _tag} = Tags.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: ~p"/tags")
  end

  defp page_title(conn, _params), do: assign(conn, :page_title, "Tags")
end

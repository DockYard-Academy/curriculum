defmodule BlogWeb.TagControllerTest do
  use BlogWeb.ConnCase

  import Blog.TagsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all tags", %{conn: conn} do
      conn = get(conn, ~p"/tags")
      assert html_response(conn, 200) =~ "Listing Tags"
    end
  end

  describe "new tag" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/tags/new")
      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "create tag" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/tags", tag: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/tags/#{id}"

      conn = get(conn, ~p"/tags/#{id}")
      assert html_response(conn, 200) =~ "Tag #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/tags", tag: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "edit tag" do
    setup [:create_tag]

    test "renders form for editing chosen tag", %{conn: conn, tag: tag} do
      conn = get(conn, ~p"/tags/#{tag}/edit")
      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "redirects when data is valid", %{conn: conn, tag: tag} do
      conn = put(conn, ~p"/tags/#{tag}", tag: @update_attrs)
      assert redirected_to(conn) == ~p"/tags/#{tag}"

      conn = get(conn, ~p"/tags/#{tag}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, tag: tag} do
      conn = put(conn, ~p"/tags/#{tag}", tag: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "deletes chosen tag", %{conn: conn, tag: tag} do
      conn = delete(conn, ~p"/tags/#{tag}")
      assert redirected_to(conn) == ~p"/tags"

      assert_error_sent 404, fn ->
        get(conn, ~p"/tags/#{tag}")
      end
    end
  end

  defp create_tag(_) do
    tag = tag_fixture()
    %{tag: tag}
  end
end

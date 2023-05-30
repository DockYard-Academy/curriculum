defmodule BlogWeb.CommentControllerTest do
  use BlogWeb.ConnCase

  import Blog.AccountsFixtures
  import Blog.CommentsFixtures
  import Blog.PostsFixtures

  describe "create comment" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      create_attrs = %{content: "some content", post_id: post.id, user_id: user.id}

      conn = log_in_user(conn, user)

      conn = post(conn, ~p"/comments", comment: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert String.to_integer(id) == post.id
      assert redirected_to(conn) == ~p"/posts/#{id}"

      conn = get(conn, ~p"/posts/#{id}")
      assert html_response(conn, 200) =~ "some content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      invalid_attrs = %{content: nil, post_id: post.id, user_id: user.id}
      conn = conn |> log_in_user(user) |> post(~p"/comments", comment: invalid_attrs)
      assert html_response(conn, 200) =~ "can&#39;t be blank"
    end
  end

  describe "update comment" do
    test "redirects when data is valid", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      comment = comment_fixture(post_id: post.id, user_id: user.id)
      update_attrs = %{content: "some updated content", post_id: post.id}

      conn = log_in_user(conn, user)

      conn = put(conn, ~p"/comments/#{comment}", comment: update_attrs)
      assert redirected_to(conn) == ~p"/posts/#{post.id}"

      conn = get(conn, ~p"/posts/#{post.id}")
      assert html_response(conn, 200) =~ update_attrs.content
    end

    test "a user cannot update another user's comment", %{conn: conn} do
      post_user = user_fixture()
      other_user = user_fixture()
      post = post_fixture(user_id: post_user.id)
      comment = comment_fixture(post_id: post.id, user_id: post_user.id)
      update_attrs = %{content: "some updated content", post_id: post.id}

      conn = log_in_user(conn, other_user)

      conn = put(conn, ~p"/comments/#{comment}", comment: update_attrs)

      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~
               "You can only edit or delete your own comments"

      assert redirected_to(conn) == ~p"/posts/#{post.id}"
    end
  end

  describe "delete comment" do
    test "deletes chosen comment", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)

      comment =
        comment_fixture(content: "some comment content", post_id: post.id, user_id: user.id)

      conn = log_in_user(conn, user)

      conn = delete(conn, ~p"/comments/#{comment}")
      assert redirected_to(conn) == ~p"/posts/#{post.id}"

      conn = get(conn, ~p"/posts/#{post.id}")
      refute html_response(conn, 200) =~ "some comment content"
    end

    test "a user cannot delete another user's comment", %{conn: conn} do
      comment_user = user_fixture()
      other_user = user_fixture()
      post = post_fixture(user_id: comment_user.id)

      comment =
        comment_fixture(
          content: "some comment content",
          post_id: post.id,
          user_id: comment_user.id
        )

      conn = log_in_user(conn, other_user)
      conn = delete(conn, ~p"/comments/#{comment}")

      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~
               "You can only edit or delete your own comments"

      assert redirected_to(conn) == ~p"/posts/#{post.id}"
    end
  end
end

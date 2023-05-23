defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  alias Blog.Posts
  alias Blog.Posts.CoverImage

  import Blog.AccountsFixtures
  import Blog.CommentsFixtures
  import Blog.PostsFixtures
  import Blog.TagsFixtures

  @update_attrs %{
    content: "some updated content",
    title: "some updated title"
  }
  @invalid_attrs %{content: nil, title: nil}

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, ~p"/posts")
      assert html_response(conn, 200) =~ "Listing Posts"
    end

    test "search for posts - non-matching", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(title: "some title", user_id: user.id)
      conn = get(conn, ~p"/posts", title: "Non-Matching")
      refute html_response(conn, 200) =~ post.title
    end

    test "search for posts - exact match", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(title: "some title", user_id: user.id)
      conn = get(conn, ~p"/posts", title: "some title")
      assert html_response(conn, 200) =~ post.title
    end

    test "search for posts - partial match", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(title: "some title", user_id: user.id)
      conn = get(conn, ~p"/posts", title: "itl")
      assert html_response(conn, 200) =~ post.title
    end
  end

  describe "show post" do
    test "renders post information", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)

      conn = conn |> get(~p"/posts/#{post}/")
      response = html_response(conn, 200)

      assert response =~ post.title
      assert response =~ user.username
    end

    test "renders post comments", %{conn: conn} do
      post_user = user_fixture()
      comment_user = user_fixture()
      post = post_fixture(user_id: post_user.id)

      comment =
        comment_fixture(
          content: "some comment content",
          user_id: comment_user.id,
          post_id: post.id
        )

      conn = conn |> get(~p"/posts/#{post}/")
      response = html_response(conn, 200)

      assert response =~ comment.content
      assert response =~ comment_user.username
    end
  end

  describe "new post" do
    test "renders form", %{conn: conn} do
      user = user_fixture()
      conn = conn |> log_in_user(user) |> get(~p"/posts/new")
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "create post" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      create_attrs = %{
        content: "some content",
        title: "some title",
        visible: true,
        published_on: DateTime.utc_now(),
        user_id: user.id
      }

      conn = post(conn, ~p"/posts", post: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/posts/#{id}"

      conn = get(conn, ~p"/posts/#{id}")
      assert html_response(conn, 200) =~ "Post #{id}"
    end

    test "with cover image", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      create_attrs = %{
        content: "some content",
        title: "some title",
        visible: true,
        published_on: DateTime.utc_now(),
        user_id: user.id,
        cover_image: %{
          url: "https://www.example.com/image.png"
        }
      }

      conn = post(conn, ~p"/posts", post: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/posts/#{id}"

      conn = get(conn, ~p"/posts/#{id}")
      assert %CoverImage{url: "https://www.example.com/image.png"} = Posts.get_post!(id).cover_image
      assert html_response(conn, 200) =~ "https://www.example.com/image.png"
    end

    test "with tags", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      tag1 = tag_fixture(name: "tag 1 name")
      tag2 = tag_fixture(name: "tag 2 name")

      create_attrs = %{
        content: "some content",
        title: "some title",
        visible: true,
        published_on: DateTime.utc_now(),
        user_id: user.id,
        tag_ids: [tag1.id, tag2.id]
      }

      conn = post(conn, ~p"/posts", post: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/posts/#{id}"

      assert Posts.get_post!(id).tags == [tag1, tag2]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)
      conn = post(conn, ~p"/posts", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Post"
    end
  end

  describe "edit post" do
    test "renders form for editing chosen post", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      conn = conn |> log_in_user(user) |> get(~p"/posts/#{post}/edit")
      assert html_response(conn, 200) =~ "Edit Post"
    end

    test "a user cannot edit another user's post", %{conn: conn} do
      post_user = user_fixture()
      other_user = user_fixture()
      post = post_fixture(user_id: post_user.id)
      conn = conn |> log_in_user(other_user) |> get(~p"/posts/#{post}/edit")

      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~
               "You can only edit or delete your own posts."

      assert redirected_to(conn) == ~p"/posts/#{post}"
    end
  end

  describe "update post" do
    test "redirects when data is valid", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      conn = put(conn, ~p"/posts/#{post}", post: @update_attrs)
      assert redirected_to(conn) == ~p"/posts/#{post}"

      conn = get(conn, ~p"/posts/#{post}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "with cover image", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      conn = put(conn, ~p"/posts/#{post}", post: %{cover_image: %{url: "https://www.example.com/image.png"}})
      assert redirected_to(conn) == ~p"/posts/#{post}"

      conn = get(conn, ~p"/posts/#{post}")
      assert %CoverImage{url: "https://www.example.com/image.png"} = Posts.get_post!(post.id).cover_image
      assert html_response(conn, 200) =~ "https://www.example.com/image.png"
    end


    test "with tags", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      tag1 = tag_fixture(name: "tag 1 name")
      tag2 = tag_fixture(name: "tag 2 name")

      conn = log_in_user(conn, user)

      conn = put(conn, ~p"/posts/#{post}", post: %{tag_ids: [tag1.id, tag2.id]})
      assert redirected_to(conn) == ~p"/posts/#{post}"

      assert Blog.Repo.preload(post, :tags, force: true).tags == [tag1, tag2]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      conn = conn |> log_in_user(user) |> put(~p"/posts/#{post}", post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Post"
    end

    test "a user cannot update another user's post", %{conn: conn} do
      post_user = user_fixture()
      other_user = user_fixture()
      post = post_fixture(user_id: post_user.id)
      conn = conn |> log_in_user(other_user) |> put(~p"/posts/#{post}", post: @update_attrs)

      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~
               "You can only edit or delete your own posts."

      assert redirected_to(conn) == ~p"/posts/#{post}"
    end
  end

  describe "delete post" do
    test "deletes chosen post", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      conn = conn |> log_in_user(user) |> delete(~p"/posts/#{post}")
      assert redirected_to(conn) == ~p"/posts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/posts/#{post}")
      end
    end

    test "deletes chosen post with cover image", %{conn: conn} do
      user = user_fixture()
      post = post_fixture(user_id: user.id, cover_image: %{url: "https://www.example.com/image.png"})
      conn = conn |> log_in_user(user) |> delete(~p"/posts/#{post}")
      assert redirected_to(conn) == ~p"/posts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/posts/#{post}")
      end
    end

    test "a user cannot delete another user's post", %{conn: conn} do
      post_user = user_fixture()
      other_user = user_fixture()
      post = post_fixture(user_id: post_user.id)
      conn = conn |> log_in_user(other_user) |> delete(~p"/posts/#{post}")

      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~
               "You can only edit or delete your own posts."

      assert redirected_to(conn) == ~p"/posts/#{post}"
    end
  end
end

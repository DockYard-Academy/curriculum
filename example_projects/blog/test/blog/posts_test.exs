defmodule Blog.PostsTest do
  use Blog.DataCase

  alias Blog.Posts
  alias Blog.Comments

  describe "posts" do
    alias Blog.Posts.Post

    import Blog.AccountsFixtures
    import Blog.CommentsFixtures
    import Blog.PostsFixtures

    @invalid_attrs %{content: nil, title: nil}

    test "list_posts/1 with no filter returns all posts" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert Posts.list_posts() == [post]
    end

    test "list_posts/1 ignores non visible posts" do
      user = user_fixture()
      post = post_fixture(visible: false, user_id: user.id)
      assert Posts.list_posts() == []
      assert Posts.list_posts(post.title) == []
    end

    test "list_posts/1 ignores future posts and sorts posts by date" do
      user = user_fixture()
      past_post = post_fixture(title: "some title1", published_on: DateTime.utc_now() |> DateTime.add(-1, :day), user_id: user.id)
      present_post = post_fixture(title: "some title2", published_on: DateTime.utc_now(), user_id: user.id)
      _future_post = post_fixture(title: "some title3", published_on: DateTime.utc_now() |> DateTime.add(1, :day), user_id: user.id)
      assert Posts.list_posts() == [present_post, past_post]
      assert Posts.list_posts("some title") == [present_post, past_post]
    end

    test "list_posts/1 filters posts by title" do
      user = user_fixture()
      post = post_fixture(title: "Title", user_id: user.id)
      assert Posts.list_posts("Non-Matching") == []
      assert Posts.list_posts("Title") == [post]
      assert Posts.list_posts("") == [post]
      assert Posts.list_posts("title") == [post]
      assert Posts.list_posts("itl") == [post]
      assert Posts.list_posts("ITL") == [post]
    end

    test "get_post!/1 returns the post given post" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      retrieved_post = Posts.get_post!(post.id)
      assert retrieved_post.id == post.id
      assert retrieved_post.title == post.title
      assert retrieved_post.visible == post.visible
      assert retrieved_post.published_on == post.published_on
    end

    test "get_post!/1 loads the user association" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert Posts.get_post!(post.id).user == user
    end

    test "get_post!/1 loads the comments sorted by creation time" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      old_comment = comment_fixture(post_id: post.id, user_id: user.id) |> Repo.preload(:user)
      new_comment = comment_fixture(post_id: post.id, user_id: user.id) |> Repo.preload(:user)
      assert Posts.get_post!(post.id).comments == [new_comment, old_comment]
    end

    test "create_post/1 with valid data creates a post" do
      user = user_fixture()
      now = DateTime.utc_now()
      valid_attrs = %{content: "some content", title: "some title", visible: true, published_on: now, user_id: user.id}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.content == "some content"
      assert post.title == "some title"
      assert post.visible
      assert post.user_id == user.id
      # convert to unix to avoid issues with :utc_datetime vs :utc_datetime_usec
      assert DateTime.to_unix(post.published_on) == DateTime.to_unix(now)
    end

    test "create_post/1 post titles must be unique" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(%{content: "some content", title: post.title})
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)

      update_attrs = %{
        content: "some updated content",
        title: "some updated title",
        visible: false,
        published_on: DateTime.add(DateTime.utc_now(), 1, :day)
      }

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.content == "some updated content"
      assert post.title == "some updated title"
      assert post.user_id == user.id
      assert DateTime.to_unix(post.published_on) == DateTime.to_unix(update_attrs.published_on)
    end

    test "update_post/2 with invalid data returns error changeset" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post.content == Posts.get_post!(post.id).content
    end

    test "delete_post/1 deletes the post" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "delete_post/1 deletes the post and associated comments" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      comment = comment_fixture(post_id: post.id, user_id: user.id)
      assert {:ok, %Post{}} = Posts.delete_post(post)

      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "change_post/1 returns a post changeset" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end

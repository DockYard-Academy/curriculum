defmodule Blog.PostsTest do
  use Blog.DataCase

  alias Blog.Comments
  alias Blog.Posts
  alias Blog.Posts.CoverImage
  alias Blog.Posts.Post
  alias Blog.Tags

  import Blog.AccountsFixtures
  import Blog.CommentsFixtures
  import Blog.PostsFixtures
  import Blog.TagsFixtures

  describe "posts" do
    @invalid_attrs %{content: nil, title: nil}

    test "list_posts/1 with no filter returns all posts" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert Posts.list_posts() |> Enum.map(& &1.id) == [post] |> Enum.map(& &1.id)
    end

    test "list_posts/1 ignores non visible posts" do
      user = user_fixture()
      post = post_fixture(visible: false, user_id: user.id)
      assert Posts.list_posts() == []
      assert Posts.list_posts(post.title) == []
    end

    test "list_posts/1 ignores future posts and sorts posts by date" do
      user = user_fixture()

      past_post =
        post_fixture(
          title: "some title1",
          published_on: DateTime.utc_now() |> DateTime.add(-1, :day),
          user_id: user.id
        )

      present_post =
        post_fixture(title: "some title2", published_on: DateTime.utc_now(), user_id: user.id)

      _future_post =
        post_fixture(
          title: "some title3",
          published_on: DateTime.utc_now() |> DateTime.add(1, :day),
          user_id: user.id
        )

      # comparing ids to avoid issues with comparing associations
      assert Posts.list_posts() |> Enum.map(& &1.id) == [present_post.id, past_post.id]

      assert Posts.list_posts("some title") |> Enum.map(& &1.id) == [
               present_post.id,
               past_post.id
             ]
    end

    test "list_posts/1 filters posts by title" do
      user = user_fixture()
      post = post_fixture(title: "Title", user_id: user.id)
      post_id = post.id
      assert [] = Posts.list_posts("Non-Matching")
      assert [%{id: ^post_id}] = Posts.list_posts("Title")
      assert [%{id: ^post_id}] = Posts.list_posts("")
      assert [%{id: ^post_id}] = Posts.list_posts("title")
      assert [%{id: ^post_id}] = Posts.list_posts("itl")
      assert [%{id: ^post_id}] = Posts.list_posts("ITL")
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

    test "get_post!/1 loads the cover_image association" do
      user = user_fixture()
      post = post_fixture(user_id: user.id, cover_image: %{url: "http://www.example.com/image.png"})
      assert %CoverImage{url: "http://www.example.com/image.png"} = Posts.get_post!(post.id).cover_image
    end

    test "get_post!/1 loads the tags association" do
      user = user_fixture()
      tag = tag_fixture()

      post =
        post_fixture(%{
          title: "some title",
          content: "some content",
          user_id: user.id,
          tags: [tag]
        })

      assert Posts.get_post!(post.id).tags == [tag]
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

      valid_attrs = %{
        content: "some content",
        title: "some title",
        visible: true,
        published_on: now,
        user_id: user.id
      }

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.content == "some content"
      assert post.title == "some title"
      assert post.visible
      assert post.user_id == user.id
      # convert to unix to avoid issues with :utc_datetime vs :utc_datetime_usec
      assert DateTime.to_unix(post.published_on) == DateTime.to_unix(now)
    end

    test "create_post/1 with image" do
      valid_attrs = %{
        content: "some content",
        title: "some title",
        cover_image: %{
          url: "https://www.example.com/image.png"
        },
        visible: true,
        published_on: DateTime.utc_now(),
        user_id: user_fixture().id
      }

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert %CoverImage{url: "https://www.example.com/image.png"} = Repo.preload(post, :cover_image).cover_image
    end

    test "create_post/1 with tags" do
      user = user_fixture()
      tag1 = tag_fixture()
      tag2 = tag_fixture()

      valid_attrs1 = %{content: "some content", title: "post 1", user_id: user.id}
      valid_attrs2 = %{content: "some content", title: "post 2", user_id: user.id}

      assert {:ok, %Post{} = post1} = Posts.create_post(valid_attrs1, [tag1, tag2])
      assert {:ok, %Post{} = post2} = Posts.create_post(valid_attrs2, [tag1])

      # posts have many tags
      assert Repo.preload(post1, :tags).tags == [tag1, tag2]
      assert Repo.preload(post2, :tags).tags == [tag1]

      # tags have many posts
      # we preload posts: [:tags] because posts contain the list of tags when created
      assert Repo.preload(tag1, posts: [:tags]).posts == [post1, post2]
      assert Repo.preload(tag2, posts: [:tags]).posts == [post1]
    end

    test "create_post/1 post titles must be unique" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)

      assert {:error, %Ecto.Changeset{}} =
               Posts.create_post(%{content: "some content", title: post.title})
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

    test "update_post/1 add an image" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)

      assert {:ok, %Post{} = post} = Posts.update_post(post, %{cover_image: %{url: "https://www.example.com/image2.png"}})
      assert post.cover_image.url == "https://www.example.com/image2.png"
    end

    test "update_post/1 update existing image" do
      user = user_fixture()
      post = post_fixture(user_id: user.id, cover_image: %{url: "https://www.example.com/image.png"})

      assert {:ok, %Post{} = post} = Posts.update_post(post, %{cover_image: %{url: "https://www.example.com/image2.png"}})
      assert post.cover_image.url == "https://www.example.com/image2.png"
    end

    test "update_post/1 with tags" do
      user = user_fixture()
      tag1 = tag_fixture()
      tag2 = tag_fixture()
      post = post_fixture(user_id: user.id, tags: [tag1])

      assert {:ok, %Post{} = post} = Posts.update_post(post, %{}, [tag2])

      # posts have many tags
      assert Repo.preload(post, :tags).tags == [tag2]
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

    test "delete_post/1 deletes post and cover image" do
      user = user_fixture()
      post = post_fixture(user_id: user.id, cover_image: %{url: "https://www.example.com/image.png"})
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
      assert_raise Ecto.NoResultsError, fn -> Repo.get!(CoverImage, post.cover_image.id) end
    end

    test "delete_post/1 deletes the post and associated comments" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      comment = comment_fixture(post_id: post.id, user_id: user.id)
      assert {:ok, %Post{}} = Posts.delete_post(post)

      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
      assert_raise Ecto.NoResultsError, fn -> Comments.get_comment!(comment.id) end
    end

    test "delete_post/1 deletes the post and does not delete tags" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      tag1 = tag_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)

      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
      assert Tags.get_tag!(tag1.id) == tag1
    end

    test "change_post/1 returns a post changeset" do
      user = user_fixture()
      post = post_fixture(user_id: user.id)
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end

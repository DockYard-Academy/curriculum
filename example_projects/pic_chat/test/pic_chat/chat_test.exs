defmodule PicChat.ChatTest do
  use PicChat.DataCase

  alias PicChat.Chat

  describe "messages" do
    alias PicChat.Chat.Message

    import PicChat.ChatFixtures
    import PicChat.AccountsFixtures

    @invalid_attrs %{content: nil}

    test "list_messages/0 returns all messages" do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      assert Chat.list_messages() == [message]
    end

    test "list_messages/0 returns ordered messages" do
      user = user_fixture()
      old = message_fixture(user_id: user.id)
      new = message_fixture(user_id: user.id)
      assert Chat.list_messages() == [new, old]
    end

    test "list_messages/1 returns paginated messages" do
      user = user_fixture()
      message1 = message_fixture(user_id: user.id)
      _message2 = message_fixture(user_id: user.id)
      assert Chat.list_messages(limit: 1, offset: 1) == [message1]
    end

    test "get_message!/1 returns the message with given id" do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      user = user_fixture()
      valid_attrs = %{content: "some content", user_id: user.id, picture: "images/picture.png"}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
      assert message.content == "some content"
      assert message.user_id == user.id
      assert message.picture == "images/picture.png"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Message{} = message} = Chat.update_message(message, update_attrs)
      assert message.content == "some updated content"
    end

    test "update_message/2 with invalid data returns error changeset" do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      assert {:error, %Ecto.Changeset{}} = Chat.update_message(message, @invalid_attrs)
      assert message == Chat.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      assert {:ok, %Message{}} = Chat.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end

    test "todays_messages/0" do
      user = user_fixture()
      today_message = message_fixture(user_id: user.id)

      yesterday =
        NaiveDateTime.add(NaiveDateTime.utc_now(), -1, :day) |> NaiveDateTime.truncate(:second)

      yesterday_message =
        PicChat.Repo.insert!(%Message{
          content: "some content",
          user_id: user.id,
          inserted_at: yesterday
        })

      assert Chat.todays_messages() == [today_message]
    end
  end
end

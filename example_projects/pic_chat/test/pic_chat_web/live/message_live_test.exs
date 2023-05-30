defmodule PicChatWeb.MessageLiveTest do
  use PicChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import PicChat.ChatFixtures
  import PicChat.AccountsFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  describe "Index" do
    test "lists all messages", %{conn: conn} do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      {:ok, _index_live, html} = live(conn, ~p"/messages")

      assert html =~ "Listing Messages"
      assert html =~ message.content
    end

    test "infinite load 10 messages at a time", %{conn: conn} do
      user = user_fixture()

      messages =
        Enum.map(1..20, fn n ->
          message_fixture(user_id: user.id, content: "message-content-#{n}")
        end)
        |> Enum.reverse()

      page_one_message = Enum.at(messages, 0)
      page_two_message = Enum.at(messages, 10)

      {:ok, index_live, html} = live(conn, ~p"/messages")

      assert html =~ "Listing Messages"

      assert html =~ page_one_message.content
      refute html =~ page_two_message.content
      assert render_hook(index_live, "load-more", %{}) =~ page_two_message.content
    end

    test "saves new message", %{conn: conn} do
      user = user_fixture()
      conn = conn |> log_in_user(user)
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      {:ok, new_live, html} =
        index_live |> element("a", "New Message") |> render_click() |> follow_redirect(conn)

      assert_redirected(index_live, ~p"/messages/new")
      assert html =~ "New Message"

      assert new_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert new_live
             |> form("#message-form", message: @create_attrs)
             |> render_submit()

      assert_patch(new_live, ~p"/messages")

      html = render(new_live)
      assert html =~ "Message created successfully"
      assert html =~ "some content"
    end

    test "updates message in listing", %{conn: conn} do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      {:ok, edit_live, html} =
        index_live
        |> element("#messages-#{message.id} a", "Edit")
        |> render_click()
        |> follow_redirect(conn)

      assert html =~ "Edit Message"
      assert_redirect(index_live, ~p"/messages/#{message}/edit")

      assert edit_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert edit_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert_patch(edit_live, ~p"/messages")

      html = render(edit_live)
      assert html =~ "Message updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes message in listing", %{conn: conn} do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      assert index_live |> element("#messages-#{message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#messages-#{message.id}")
    end
  end

  describe "Show" do
    test "displays message", %{conn: conn} do
      user = user_fixture()
      message = message_fixture(user_id: user.id)

      {:ok, _show_live, html} = live(conn, ~p"/messages/#{message}")

      assert html =~ "Show Message"
      assert html =~ message.content
    end

    test "updates message within modal", %{conn: conn} do
      user = user_fixture()
      message = message_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      {:ok, show_live, _html} = live(conn, ~p"/messages/#{message}")

      {:ok, edit_live, html} =
        show_live |> element("a", "Edit") |> render_click() |> follow_redirect(conn)

      assert html =~ "Edit Message"
      assert_redirected(show_live, ~p"/messages/#{message}/show/edit")

      assert edit_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert edit_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert_patch(edit_live, ~p"/messages/#{message}")

      html = render(edit_live)
      assert html =~ "Message updated successfully"
      assert html =~ "some updated content"
    end
  end

  describe "PubSub" do
    test "creating a message updates subscribers", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)
      {:ok, subscriber_live, _html} = live(conn, ~p"/messages")
      {:ok, publisher_live, _html} = live(conn, ~p"/messages/new")

      assert publisher_live
             |> form("#message-form", message: @create_attrs)
             |> render_submit()

      assert render(subscriber_live) =~ "some content"
    end

    test "updating a message updates subscribers", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)
      message = message_fixture(user_id: user.id)
      {:ok, subscriber_live, _html} = live(conn, ~p"/messages")
      {:ok, publisher_live, _html} = live(conn, ~p"/messages/#{message}/edit")

      assert publisher_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert render(subscriber_live) =~ "some updated content"
    end

    test "deleting a message updates subscribers", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)
      message = message_fixture(user_id: user.id)
      {:ok, subscriber_live, _html} = live(conn, ~p"/messages")
      {:ok, publisher_live, _html} = live(conn, ~p"/messages/#{message}/edit")

      assert publisher_live |> element("#messages-#{message.id} a", "Delete") |> render_click()

      refute render(subscriber_live) =~ "some content"
    end
  end
end

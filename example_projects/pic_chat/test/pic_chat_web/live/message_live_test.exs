defmodule PicChatWeb.MessageLiveTest do
  use PicChatWeb.ConnCase

  import Phoenix.LiveViewTest
  import PicChat.ChatFixtures

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  defp create_message(_) do
    message = message_fixture()
    %{message: message}
  end

  describe "Index" do
    setup [:create_message]

    test "lists all messages", %{conn: conn, message: message} do
      {:ok, _index_live, html} = live(conn, ~p"/messages")

      assert html =~ "Listing Messages"
      assert html =~ message.content
    end

    test "saves new message", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      assert index_live |> element("a", "New Message") |> render_click() =~
               "New Message"

      assert_patch(index_live, ~p"/messages/new")

      assert index_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#message-form", message: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/messages")

      html = render(index_live)
      assert html =~ "Message created successfully"
      assert html =~ "some content"
    end

    test "updates message in listing", %{conn: conn, message: message} do
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      assert index_live |> element("#messages-#{message.id} a", "Edit") |> render_click() =~
               "Edit Message"

      assert_patch(index_live, ~p"/messages/#{message}/edit")

      assert index_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/messages")

      html = render(index_live)
      assert html =~ "Message updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes message in listing", %{conn: conn, message: message} do
      {:ok, index_live, _html} = live(conn, ~p"/messages")

      assert index_live |> element("#messages-#{message.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#messages-#{message.id}")
    end
  end

  describe "Show" do
    setup [:create_message]

    test "displays message", %{conn: conn, message: message} do
      {:ok, _show_live, html} = live(conn, ~p"/messages/#{message}")

      assert html =~ "Show Message"
      assert html =~ message.content
    end

    test "updates message within modal", %{conn: conn, message: message} do
      {:ok, show_live, _html} = live(conn, ~p"/messages/#{message}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Message"

      assert_patch(show_live, ~p"/messages/#{message}/show/edit")

      assert show_live
             |> form("#message-form", message: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#message-form", message: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/messages/#{message}")

      html = render(show_live)
      assert html =~ "Message updated successfully"
      assert html =~ "some updated content"
    end
  end
end

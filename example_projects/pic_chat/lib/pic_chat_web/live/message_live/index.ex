defmodule PicChatWeb.MessageLive.Index do
  use PicChatWeb, :live_view

  alias PicChat.Chat
  alias PicChat.Chat.Message

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket) do
      PicChatWeb.Endpoint.subscribe("messages")
    end

    {:ok, stream(socket, :messages, Chat.list_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Chat.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Message")
    |> assign(:message, %Message{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_info({PicChatWeb.MessageLive.FormComponent, {:new, message}}, socket) do
    {:noreply, stream_insert(socket, :messages, message, at: 0)}
  end

  @impl true
  def handle_info({PicChatWeb.MessageLive.FormComponent, {:edit, message}}, socket) do
    {:noreply, stream_insert(socket, :messages, message)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "messages", event: "new", payload: message}, socket) do
    {:noreply, stream_insert(socket, :messages, message, at: 0)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "messages", event: "edit", payload: message}, socket) do
    {:noreply, stream_insert(socket, :messages, message)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "messages", event: "delete", payload: message}, socket) do
    {:noreply, stream_delete(socket, :messages, message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Chat.get_message!(id)

    if message.user_id == socket.assigns.current_user.id do
      {:ok, _} = Chat.delete_message(message)
      PicChatWeb.Endpoint.broadcast_from(self(), "messages", "delete", message)
      {:noreply, stream_delete(socket, :messages, message)}
    else
      {:noreply,
       Phoenix.LiveView.put_flash(
         socket,
         :error,
         "You are not authorized to delete this message."
       )}
    end
  end
end

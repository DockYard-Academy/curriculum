defmodule PicChat.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PicChat.Chat` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> PicChat.Chat.create_message()

    message
  end
end

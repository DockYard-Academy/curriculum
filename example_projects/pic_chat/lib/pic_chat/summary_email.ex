defmodule PicChat.SummaryEmail do
  import Swoosh.Email

  @sender_name "sender"
  @sender_email "sender@email.com"

  def send_to_subscribers do
    messages = PicChat.Chat.todays_messages()
    subscribers = PicChat.Accounts.subscriber_emails()

    for subscriber <- subscribers do
      PicChat.Mailer.deliver(build(subscriber, messages))
    end
  end

  def build(receiver_email, messages) do
    new()
    |> to(receiver_email)
    |> from({@sender_name, @sender_email})
    |> subject("PicChat Summary Report")
    |> html_body("""
    <h1>Summary Report</h1>
    #{Enum.map(messages, &render_message/1)}
    """)
    |> text_body("""
    Summary Report
    #{messages |> Enum.map(& &1.content) |> Enum.join("\n")}
    """)
  end

  defp render_message(message) do
    """
    <p>#{message.content}</p>
    """
  end
end

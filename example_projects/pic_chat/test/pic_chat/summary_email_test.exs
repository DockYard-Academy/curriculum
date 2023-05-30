defmodule PicChat.SummaryEmailTest do
  use PicChat.DataCase
  alias PicChat.SummaryEmail

  import Swoosh.TestAssertions
  import PicChat.AccountsFixtures
  import PicChat.ChatFixtures

  test "send_to_subscribers/0" do
    user = user_fixture(email: "test@test.test", subscribed: true)
    message1 = message_fixture(user_id: user.id)
    message2 = message_fixture(user_id: user.id)

    SummaryEmail.send_to_subscribers()

    assert_email_sent(SummaryEmail.build(user.email, [message1, message2]))
  end

  test "build/2" do
    user = user_fixture(email: "test@test.test", subscribed: true)
    message1 = message_fixture(user_id: user.id, content: "message 1")
    message2 = message_fixture(user_id: user.id, content: "message 2")
    html_body = SummaryEmail.build(user.email, [message1, message2]).html_body

    assert String.trim(html_body) ==
             String.trim("""
             <h1>Summary Report</h1>
             <p>#{message1.content}</p>
             <p>#{message2.content}</p>
             """)
  end
end

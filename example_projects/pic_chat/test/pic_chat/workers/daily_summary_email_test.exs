defmodule PicChat.Workers.DailySummaryEmailTest do
  use PicChat.DataCase
  use Oban.Testing, repo: PicChat.Repo

  alias PicChat.Workers.DailySummaryEmail
  alias PicChat.SummaryEmail

  import Swoosh.TestAssertions
  import PicChat.AccountsFixtures
  import PicChat.ChatFixtures

  test "perform/1 sends daily summary emails" do
    user = user_fixture(email: "test@test.test", subscribed: true)
    message1 = message_fixture(user_id: user.id)
    message2 = message_fixture(user_id: user.id)

    assert :ok = DailySummaryEmail.perform(%{})

    assert_email_sent(SummaryEmail.build(user.email, [message2, message1]))
  end
end

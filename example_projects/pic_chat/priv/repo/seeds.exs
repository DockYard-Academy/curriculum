# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PicChat.Repo.insert!(%PicChat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, user} =
  PicChat.Accounts.register_user(%{
    email: "test@test.test",
    password: "testtesttest",
    subscribed: true
  })

for n <- 1..100 do
  PicChat.Chat.create_message(%{user_id: user.id, content: "message #{n}"})
end

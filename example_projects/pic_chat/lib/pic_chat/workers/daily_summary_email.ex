defmodule PicChat.Workers.DailySummaryEmail do
  use Oban.Worker, queue: :default, max_attempts: 1

  @impl true
  def perform(_params) do
    PicChat.SummaryEmail.send_to_subscribers()

    :ok
  end
end

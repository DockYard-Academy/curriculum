defmodule PicChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PicChatWeb.Telemetry,
      # Start the Ecto repository
      PicChat.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PicChat.PubSub},
      # Start Finch
      {Finch, name: PicChat.Finch},
      # Start the Endpoint (http/https)
      PicChatWeb.Endpoint,
      # Start a worker by calling: PicChat.Worker.start_link(arg)
      # {PicChat.Worker, arg}
      # Added Oban
      {Oban, Application.fetch_env!(:pic_chat, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PicChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PicChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

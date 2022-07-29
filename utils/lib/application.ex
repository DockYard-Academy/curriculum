defmodule Utils.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Kino.SmartCell.register(Utils.SmartCell.HiddenCell)
    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

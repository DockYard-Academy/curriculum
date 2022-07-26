defmodule Utils.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Enum.each(Utils.SmartCell.Exercise.smart_cells(), &Kino.SmartCell.register/1)
    Kino.SmartCell.register(Utils.SmartCell.HiddenCell)
    Kino.SmartCell.register(Utils.SmartCell.TestedCell)
    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule Utils.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp exercise_modules do
    [
      Utils.SmartCell.Exercise.MadLibs
    ]
  end

  @impl true
  def start(_type, _args) do
    Enum.each(exercise_modules(), &Kino.SmartCell.register/1)
    Kino.SmartCell.register(Utils.SmartCell.HiddenCell)
    Kino.SmartCell.register(Utils.SmartCell.TestedCell)
    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule Games.ScoreTracker do
  use GenServer

  def init(init_arg) do
    {:ok, 0}
  end

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def current_score(pid \\ __MODULE__) do
    GenServer.call(__MODULE__, :current_score)
  end

  def handle_call(:current_score, _from, state) do
    {:reply, state, state}
  end

  def add_points(pid \\ __MODULE__, points) do
    GenServer.cast(__MODULE__, {:add_points, points})
  end

  def handle_cast({:add_points, points}, state) do
    {:noreply, state + points}
  end
end

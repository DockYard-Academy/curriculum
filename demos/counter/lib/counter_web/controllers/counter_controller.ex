defmodule CounterWeb.CounterController do
  use CounterWeb, :controller

  def count(conn, params) do
    count =
      case params["count"] do
        nil -> 0
        value -> String.to_integer(value)
      end

    render(conn, :count, count: count)
  end

  def increment(conn, params) do
    current_count = String.to_integer(params["count"])
    increment_by = String.to_integer(params["increment_by"])
    render(conn, :count, count: current_count + increment_by)
  end
end

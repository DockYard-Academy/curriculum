defmodule LiveViewCounterWeb.CounterLiveTest do
  use LiveViewCounterWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "increment count", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Count: 0"

    assert view
           |> element("#increment-button", "Increment")
           |> render_click() =~ "Count: 1"
  end

  test "increment by count", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Count: 0"

    assert view
           |> form("#increment-form")
           |> render_submit(%{increment_by: "3"}) =~ "Count: 3"
  end
end

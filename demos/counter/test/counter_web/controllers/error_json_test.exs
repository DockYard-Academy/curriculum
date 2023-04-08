defmodule CounterWeb.ErrorJSONTest do
  use CounterWeb.ConnCase, async: true

  test "renders 404" do
    assert CounterWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert CounterWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

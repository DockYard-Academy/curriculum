defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false, page_title: "Home")
  end
end

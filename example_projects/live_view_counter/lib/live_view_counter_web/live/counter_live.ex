defmodule LiveViewCounterWeb.CounterLive do
  use LiveViewCounterWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0, form: to_form(%{"increment_by" => 1}))}
  end

  def render(assigns) do
    ~H"""
    <h1>Counter</h1>
    <p>Count: <%= @count %></p>
    <.button id="increment-button" phx-click="increment">Increment</.button>
    <.simple_form id="increment-form" for={@form} phx-change="validate" phx-submit="increment_by">
      <.input type="number" field={@form[:increment_by]} label="Increment Count"/>
      <:actions>
        <.button>Increment</.button>
      </:actions>
    </.simple_form>
    """
  end

  def handle_event("increment", _, socket) do
    {:noreply, assign(socket, count: socket.assigns.count + 1)}
  end

  def handle_event("validate", params, socket) do
    socket =
      case Integer.parse(params["increment_by"]) do
        :error ->
          assign(socket,
            form: to_form(params, errors: [increment_by: {"Must be a valid integer", []}])
          )

        _ ->
          assign(socket, form: to_form(params))
      end

    {:noreply, socket}
  end

  def handle_event("increment_by", params, socket) do
    socket =
      case Integer.parse(params["increment_by"]) do
        :error ->
          assign(socket,
            form: to_form(params, errors: [increment_by: {"Must be a valid integer", []}])
          )

        {int, _rest} ->
          assign(socket, count: socket.assigns.count + int)
      end

    {:noreply, socket}
  end
end

defmodule Utils.SmartCell.TestedCell do
  use Kino.JS, assets_path: "lib/assets/tested_cell"
  use Kino.JS.Live
  use Kino.SmartCell, name: "Tested cell"
  @enabled false

  @impl true
  def init(attrs, ctx) do
    assertions = attrs["assertions"] || ""
    hint = attrs["hint"] || ""
    hint_html = attrs["hint_html"] || ""
    default_source = attrs["default_source"] || ""

    {:ok,
     assign(ctx,
       attempt: 0,
       assertions: assertions,
       hint: hint,
       hint_html: hint_html,
       hide: @enabled
     ),
     editor: [
       attribute: "code",
       language: "elixir",
       default_source: default_source
     ]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok,
     %{
       assertions: ctx.assigns.assertions,
       hint: ctx.assigns.hint,
       hint_html: Makeup.highlight(String.trim(ctx.assigns.hint)),
       hide: ctx.assigns.hide,
       attempt: 0
     }, ctx}
  end

  @impl true
  def handle_event("update_assertions", %{"assertions" => assertions}, ctx) do
    broadcast_event(ctx, "update_assertions", %{"assertions" => assertions})
    {:noreply, assign(ctx, assertions: assertions)}
  end

  @impl true
  def handle_event("update_hint", %{"hint" => hint}, ctx) do
    broadcast_event(ctx, "update_hint", %{"hint" => hint})

    {:noreply,
     assign(ctx, hint: hint, hint_html: Makeup.highlight(String.trim(ctx.assigns.hint)))}
  end

  @impl true
  def handle_info(:attempt, ctx) do
    broadcast_event(ctx, "attempt", %{"attempt" => ctx.assigns.attempt + 1})
    {:noreply, assign(ctx, attempt: ctx.assigns.attempt + 1)}
  end

  @impl true
  def to_attrs(ctx) do
    %{
      "assertions" => ctx.assigns.assertions,
      "hint" => ctx.assigns.hint,
      "attempt" => ctx.assigns.attempt,
      "hint_html" => ctx.assigns.hint_html
    }
  end

  @impl true
  def to_source(attrs) do
    [p, i, d] =
      Regex.scan(~r/\d+/, inspect(self()))
      |> Enum.map(fn [id] -> String.to_integer(id) end)

    """
    send(:c.pid(#{p}, #{i}, #{d}), :attempt)

    ExUnit.start(auto_run: false)
    defmodule Assertion do
      use ExUnit.Case

      test "" do
        #{attrs["code"]}
        #{attrs["assertions"]}
      end
    end

    ExUnit.run()

    # Make variables and modules defined in the test available.
    # Also allows for exploration using the output of the cell.
    #{attrs["code"]}
    """
  end
end

defmodule Utils.SmartCell.HiddenCell do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Hidden Cell"

  @impl true
  def init(attrs, ctx) do
    source = attrs["source"] || ""
    {:ok, assign(ctx, source: source, display_editors: Flags.get(:display_editors))}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{source: ctx.assigns.source, display_editors: ctx.assigns.display_editors}, ctx}
  end

  @impl true
  def handle_event("update", %{"source" => source}, ctx) do
    broadcast_event(ctx, "update", %{"source" => source})
    {:noreply, assign(ctx, source: source)}
  end

  @impl true
  def to_attrs(ctx) do
    %{"source" => ctx.assigns.source}
  end

  @impl true
  def to_source(attrs) do
    attrs["source"]
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");

      ctx.root.innerHTML = `
        <textarea id="source"></textarea>
      `;


      const textarea = ctx.root.querySelector("#source");

      if (!payload.display_editors) {
        textarea.style.display = "none"
      }

      textarea.value = payload.source;

      textarea.addEventListener("change", (event) => {
        ctx.pushEvent("update", { source: event.target.value });
      });

      ctx.handleEvent("update", ({ source }) => {
        textarea.value = source;
      });

      ctx.handleSync(() => {
        // Synchronously invokes change listeners
        document.activeElement &&
          document.activeElement.dispatchEvent(new Event("change"));
      });
    }
    """
  end

  asset "main.css" do
    """
    #source {
      box-sizing: border-box;
      width: 100%;
      min-height: 100px;
    }
    """
  end
end

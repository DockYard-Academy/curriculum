defmodule Utils.SmartCell.Exercise do
  @callback default_source :: String.t()
  @callback feedback :: String.t()
  @callback expected_solution :: String.t()
  defmacro __using__(_opts) do
    quote do
      use Kino.JS
      use Kino.JS.Live
      use Kino.SmartCell, name: "Mad Libs"

      @behaviour Utils.SmartCell.Exercise

      def default_source do
        raise "default_source/0 not implemented"
      end

      def feedback do
        raise "feedback/0 not implemented"
      end

      def expected_solution do
        raise "expected_solution/0 not implemented"
      end

      defoverridable feedback: 0
      defoverridable default_source: 0
      defoverridable expected_solution: 0

      @impl true
      def init(attrs, ctx) do
        {:ok, ctx,
         editor: [attribute: "code", language: "elixir", default_source: default_source()]}
      end

      @impl true
      def to_source(attrs) do
        """
        ExUnit.start(auto_run: false)
        defmodule Test do
          use ExUnit.Case
          test "test" do
            #{attrs["code"]}
            #{feedback()}
          end
        end
        ExUnit.run()
        """
      end

      @impl true
      def handle_connect(ctx) do
        # I'd like to display the expected solution as a hint, but can't seem to get the styling working.
        {:ok, %{expected_solution: expected_solution()}, ctx}
      end

      @impl true
      def to_attrs(ctx) do
        %{}
      end

      asset "main.js" do
        """
        export function init(ctx, payload) {
          ctx.importCSS("/css/app.css");

          ctx.root.innerHTML = `
          <div class="w-full">
            <div class="markdown">
              <h3>Solution:</h3>
            </div>
          </div>
            `;
          }
        """
      end
    end
  end
end

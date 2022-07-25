defmodule Utils.SmartCell.Exercise do
  @callback default_source :: String.t()
  @callback feedback :: String.t()
  @callback possible_solution :: String.t()
  defmacro __using__(_opts) do
    quote do
      use Kino.JS, assets_path: "lib/assets/exercise"
      use Kino.JS.Live
      use Kino.SmartCell, name: "Mad Libs"

      @behaviour Utils.SmartCell.Exercise

      def default_source do
        raise "default_source/0 not implemented"
      end

      def feedback do
        raise "feedback/0 not implemented"
      end

      def possible_solution do
        raise "possible_solution/0 not implemented"
      end

      defoverridable feedback: 0
      defoverridable default_source: 0
      defoverridable possible_solution: 0

      @impl true
      def init(attrs, ctx) do
        {:ok, assign(ctx, attempt: 0),
         editor: [
           attribute: "code",
           language: "elixir",
           default_source: String.trim(default_source()),
           placement: :top
         ]}
      end

      @impl true
      def handle_info(:attempt, ctx) do
         broadcast_event(ctx, "attempt", %{"attempt" => ctx.assigns.attempt + 1})
        {:noreply, assign(ctx, attempt: ctx.assigns.attempt + 1)}
      end

      @impl true
      def to_source(attrs) do
        [p, i, d] =
          Regex.scan(~r/\d+/, inspect(self()))
          |> Enum.map(fn [id] -> String.to_integer(id) end)

        """
        send(:c.pid(#{p}, #{i}, #{d}), :attempt)
        ExUnit.start(auto_run: false)
        defmodule Test do
          use ExUnit.Case
          test "test" do
            #{attrs["code"]}
            #{feedback()}
          end
        end
        ExUnit.run()

        # Make variables and modules defined in the test available.
        # Also allows for exploration using the output of the cell.
        #{attrs["code"]}
        """
      end

      @impl true
      def handle_connect(ctx) do
        # I'd like to display the expected solution as a hint, but can't seem to get the styling working.
        {:ok, %{possible_solution: Makeup.highlight(String.trim(possible_solution()))}, ctx}
      end

      @impl true
      def to_attrs(ctx) do
        %{}
      end
    end
  end
end

defmodule Mix.Tasks.SpellCheck do
  @moduledoc "Run codespell on the curriculum"
  @shortdoc @moduledoc

  use Mix.Task

  @impl true
  def run(_) do
    IO.puts("Running: mix spell_check")

    System.cmd(
      "codespell",
      [
        "--skip=./.git,./utils/.credo.exs,./utils/deps/*,./.git/*,./utils/lib/assets/*,./example_projects/*",
        "-w"
      ],
      cd: "../"
    )
  end
end

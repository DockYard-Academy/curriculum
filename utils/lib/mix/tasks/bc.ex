defmodule Mix.Tasks.Bc do
  @moduledoc "Run all Mix tasks."
  @shortdoc @moduledoc

  use Mix.Task
  require Logger

  @requirements ["all_tasks"]

  @impl true
  @deprecated "mix bc is deprecated. Use mix all_tasks instead."
  def run(_) do
    Logger.warn(@deprecated)
  end
end

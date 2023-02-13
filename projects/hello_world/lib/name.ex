defmodule HelloWorld.Name do
  @names ["Alice", "Bob", "Christina"]
  def random do
    Enum.random(@names)
  end
end

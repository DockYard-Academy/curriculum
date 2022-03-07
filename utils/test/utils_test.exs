defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils

  test "greets the world" do
    assert Utils.hello() == :world
  end
end

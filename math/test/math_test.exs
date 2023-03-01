ExUnit.start(auto_run: false)

defmodule MathTest do
  use ExUnit.Case

  @moduletag :math

  describe "add/2" do
    @describetag :add

    @tag :int
    test "1 + 1 -> 2" do
      assert Math.add(1, 1) == {:ok, 2}
    end

    @tag :int
    test "2 + 7 -> 9" do
      assert Math.add(2, 7) == {:ok, 9}
    end

    @tag :str
    test '"abc" <> "def" -> "abcdef"' do
      assert Math.add("abc", "def") == {:ok, "abcdef"}
    end

    @tag :str
    test '"Matt " <> "and Caitlyn" -> "Matt and Caitlyn"' do
      assert Math.add("Matt ", "and Caitlyn") == {:ok, "Matt and Caitlyn"}
    end

  end

  describe "subtract/2" do
    @describetag :subtract

    @tag :int
    test "3 - 4 -> -1" do
      assert Math.subtract(3, 4) == {:ok, -1}
    end

    @tag :str
    test "abcdef - abc -> def" do
      assert Math.subtract("abcdef", "abc") == {:ok, "def"}
    end
  end
end

ExUnit.run()

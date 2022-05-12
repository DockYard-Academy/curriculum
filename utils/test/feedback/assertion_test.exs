defmodule Utils.Feedback.AssertionTest do
  use ExUnit.Case
  doctest Utils.Feedback.Assertion
  alias Utils.Feedback.Assertion

  require Utils.Feedback.Assertion
  import ExUnit.CaptureIO

  test "assert all checks passed" do
    assert capture_io(fn ->
             assert Assertion.assert(1 == 1) == :ok
           end) =~ "."

    assert capture_io(fn ->
             assert Assertion.assert(1 === 1) === :ok
           end) =~ "."

    assert capture_io(fn ->
             assert Assertion.assert(1 <= 1) == :ok
           end) =~ "."

    assert capture_io(fn ->
             assert Assertion.assert(1 >= 1) == :ok
           end) =~ "."

    assert capture_io(fn ->
             assert Assertion.assert(2 > 1) == :ok
           end) =~ "."

    assert capture_io(fn ->
             assert Assertion.assert(1 < 2) == :ok
           end) =~ "."
  end

  test "assert == _ failed" do
    assert capture_io(fn ->
             assert Assertion.assert(1 == 2) == :error
           end) =~
             """
             Solution Failed.
               Code: assert Assertion.assert(1 == 2) == :error
               Expected: 2
               To Equal: 1
             """
  end

  # test "assert <= _ failed" do
  #   assert capture_io(fn ->
  #            assert Assertion.assert(2 <= 1) == :error
  #          end) =~
  #            """
  #            Solution Failed.
  #              Code: assert Assertion.assert(1 == 2) == :error
  #              Expected: 2
  #              To Be Less Than Or Equal To: 1
  #            """
  # end

  test "assert == _ failed with variable" do
    assert capture_io(fn ->
             small = 1
             assert Assertion.assert(small == 2) == :error
           end) =~
             """
             Solution Failed.
               Code: assert Assertion.assert(small == 2) == :error
               Expected: 2
               To Equal: 1
             """
  end

  test "assert truthy passed" do
    assert capture_io(fn ->
             assert Assertion.assert(1)
           end) =~ "."
  end

  test "assert truthy failed" do
    assert capture_io(fn ->
             assert Assertion.assert(false)
           end) =~
             """
             Solution Failed.
               Expected truthy, got false
             """
  end

  test "assert Truthy variable passed" do
    assert capture_io(fn ->
             small = true
             assert Assertion.assert(small)
           end) =~ "."
  end

  test "assert Truthy variable failed" do
    assert capture_io(fn ->
             small = false
             Assertion.assert(small)
           end) =~
             """
             Solution Failed.
               Code: Assertion.assert(small)
               Expected: truthy
               Recieved: false
             """
  end

  test "assert Truthy called fn failed" do
    assert capture_io(fn ->
             small = fn -> false end
             Assertion.assert(small.())
           end) =~
             """
             Solution Failed.
               Code: #{"Assertion.assert(small.())"}
               Expected: truthy
               Recieved: false
             """
  end

  test "assert Truthy bound is_integer" do
    assert capture_io(fn ->
             not_int = "hello"
             Assertion.assert(is_integer(not_int))
           end) =~
             """
             Solution Failed.
               Code: #{"Assertion.assert(is_integer(not_int))"}
               Expected: truthy
               Recieved: false
             """
  end

  test "assert Truthy is_integer" do
    assert capture_io(fn ->
             Assertion.assert(is_integer("hello"))
           end) =~
             """
             Solution Failed.
               Code: #{"Assertion.assert(is_integer(\"hello\"))"}
               Expected: truthy
               Recieved: false
             """
  end

  test "assert Truthy is_integer called function" do
    assert capture_io(fn ->
             int = fn -> "hello" end
             Assertion.assert(is_integer(int.()))
           end) =~
             """
             Solution Failed.
               Code: #{"Assertion.assert(is_integer(int.()))"}
               Expected: truthy
               Recieved: false
             """
  end
end

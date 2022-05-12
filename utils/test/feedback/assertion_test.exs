defmodule Utils.Feedback.AssertionTest do
  use ExUnit.Case
  doctest Utils.Feedback.Assertion
  alias Utils.Feedback.Assertion
  import ExUnit.CaptureIO

  require Utils.Feedback.Assertion

  test "assert all checks passed" do
    assert Assertion.assert(1 == 1) == :ok

    assert Assertion.assert(1 === 1) === :ok

    assert Assertion.assert(1 <= 1) == :ok

    assert Assertion.assert(1 >= 1) == :ok

    assert Assertion.assert(2 > 1) == :ok

    assert Assertion.assert(1 < 2) == :ok
  end

  test "assert == _ failed" do
    expected = """
    Assertion with == failed.
      code: Assertion.assert(1 == 2)
      left: 1
      right: 2
    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert(1 == 2)
    end
  end

  test "assert === _ failed" do
    expected = """
    Assertion with === failed.
      code: Assertion.assert(1 === 2)
      left: 1
      right: 2
    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert(1 === 2)
    end
  end

  test "assert == _ failed with nil" do
    expected = """
    Assertion with == failed.
      code: Assertion.assert(nil == 2)
      left: nil
      right: 2
    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert(nil == 2)
    end
  end

  test "assert == _ failed with message" do
    expected = """
    Assertion with == failed.
      code: Assertion.assert(1 == 2)
      left: 1
      right: 2

    Message Feedback
    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert(1 == 2, "Message Feedback")
    end
  end

  describe "feedback" do
    defmodule Example do
      use Utils.Feedback.Assertion
      alias Utils.Feedback.Assertion

      feedback :example do
        answer = get_answers()
        Assertion.assert(answer == true)
      end
    end

    test "feedback _ solution failed" do
      assert capture_io(fn ->
               Example.feedback(:example, false)
             end) =~
               """
               Assertion with == failed.
                 code: Assertion.assert(answer == true)
                 left: false
                 right: true
               """
    end

    test "feedback _ passed" do
      assert capture_io(fn ->
               Example.feedback(:example, true)
             end) =~
               "Solved!"
    end

    test "feedback _ given nil" do
      assert capture_io(fn ->
               Example.feedback(:example, nil)
             end) =~
               "Please enter an answer above."
    end

    test "feedback _ given list with all nil values" do
      assert capture_io(fn ->
               Example.feedback(:example, [nil, nil])
             end) =~
               "Please enter an answer above."
    end

    test "feedback _ given list with any non nil value" do
      refute capture_io(fn ->
               Example.feedback(:example, [nil, false])
             end) =~
               "Please enter an answer above."
    end
  end
end

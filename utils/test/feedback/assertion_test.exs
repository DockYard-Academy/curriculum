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

  test "assert === _ failed with list" do
    expected = """
    Assertion with === failed.
      code: Assertion.assert([1, 2] === 2)
      left: [1, 2]
      right: 2
    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert([1, 2] === 2)
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
      code: Assertion.assert(1 == 2, "Message Feedback")
      left: 1
      right: 2

    Message Feedback
    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert(1 == 2, "Message Feedback")
    end
  end

  test "assert == _ failed with same-line multi-line message" do
    expected = """
    Assertion with == failed.
      code: Assertion.assert(1 == 2)
      left: 1
      right: 2

    Multi Line
    Message Feedback

    """

    assert_raise RuntimeError, expected, fn ->
      Assertion.assert(1 == 2, """
      Multi Line
      Message Feedback
      """)
    end
  end

  describe "feedback" do
    defmodule Example do
      use Utils.Feedback.Assertion
      alias Utils.Feedback.Assertion

      feedback :boolean do
        answer = get_answers()
        Assertion.assert(answer == true)
      end

      feedback :list do
        answer = get_answers()
        Assertion.assert(answer == true)
      end
    end

    test "feedback _ solution failed" do
      assert capture_io(fn ->
               Example.feedback(:boolean, false)
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
               Example.feedback(:boolean, true)
             end) =~
               "Solved!"
    end

    test "feedback _ given nil" do
      assert capture_io(fn ->
               Example.feedback(:boolean, nil)
             end) =~
               "Please enter an answer above."
    end

    test "feedback _ given list with all nil values" do
      assert capture_io(fn ->
               Example.feedback(:boolean, [nil, nil])
             end) =~
               "Please enter an answer above."
    end

    test "feedback _ given list with any non nil value" do
      assert capture_io(fn ->
               Example.feedback(:boolean, [nil, false])
             end) =~
               """
               Assertion with == failed.
                 code: Assertion.assert(answer == true)
                 left: [nil, false]
                 right: true
               """
    end
  end
end

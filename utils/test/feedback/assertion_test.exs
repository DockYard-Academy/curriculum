defmodule Utils.Feedback.AssertionTest do
  use ExUnit.Case
  doctest Utils.Feedback.Assertion
  alias Utils.Feedback.Assertion
  import ExUnit.CaptureIO

  require Utils.Feedback.Assertion

  describe "assert" do
    test "all operators passing" do
      assert Assertion.assert(1 == 1) == :ok

      assert Assertion.assert(1 === 1) === :ok

      assert Assertion.assert(1 <= 1) == :ok

      assert Assertion.assert(1 >= 1) == :ok

      assert Assertion.assert(2 > 1) == :ok

      assert Assertion.assert(1 < 2) == :ok
    end

    test "all operators failing" do
      assert_raise AssertionError, fn ->
        Assertion.assert(1 == 2)
      end

      assert_raise AssertionError, fn ->
        Assertion.assert(1 === 2)
      end

      assert_raise AssertionError, fn ->
        Assertion.assert(2 <= 1)
      end

      assert_raise AssertionError, fn ->
        Assertion.assert(1 >= 2)
      end

      assert_raise AssertionError, fn ->
        Assertion.assert(1 > 2)
      end

      assert_raise AssertionError, fn ->
        Assertion.assert(2 < 1)
      end
    end

    test "assert == _ failed" do
      expected = """
      Assertion with == failed.
        code: Assertion.assert(1 == 2)
        left: 1
        right: 2
      """

      assert_raise AssertionError, expected, fn ->
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

      assert_raise AssertionError, expected, fn ->
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

      assert_raise AssertionError, expected, fn ->
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

      assert_raise AssertionError, expected, fn ->
        Assertion.assert(nil == 2)
      end
    end

    test "assert == _ module failed with single param" do
      expected = """
      Assertion with == failed.
        code: Assertion.assert(MyModule.call(2) == 2)
        called_with: 2
        left: 3
        right: 2
      """

      defmodule MyModule do
        def call(a) do
          a + 1
        end
      end

      assert_raise AssertionError, expected, fn ->
        Assertion.assert(MyModule.call(2) == 2)
      end
    end

    test "assert Enum.any? displays code line" do
      expected = """
      Assertion with == failed.
        code: Assertion.assert(Enum.any?([1, 2, 3]) == false)
        called_with: [1, 2, 3]
        left: true
        right: false
      """

      assert_raise AssertionError, expected, fn ->
        Assertion.assert(Enum.any?([1, 2, 3]) == false)
      end
    end

    test "assert == _ module failed with multi param" do
      expected = """
      Assertion with == failed.
        code: Assertion.assert(MyModule.call(a, b, c) == 2)
        called_with: [1], [2], [3]
        left: 6
        right: 2
      """

      defmodule MyModule do
        def call(a, b, c) do
          [a, b, c]
          |> List.flatten()
          |> Enum.sum()
        end
      end

      assert_raise AssertionError, expected, fn ->
        a = [1]
        b = [2]
        c = [3]
        Assertion.assert(MyModule.call(a, b, c) == 2)
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

      assert_raise AssertionError, expected, fn ->
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

      assert_raise AssertionError, expected, fn ->
        Assertion.assert(1 == 2, """
        Multi Line
        Message Feedback
        """)
      end
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

      feedback :module_call do
        module = get_answers()
        Assertion.assert(module.call() == true)
      end

      feedback :crash do
        raise "error"
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

    test "feedback _ crashed" do
      assert capture_io(fn ->
               Example.feedback(:crash, 1)
             end) =~
               """
               Assertion crashed.
                 code: raise "error"
                 error: "error"
               """
    end
  end
end

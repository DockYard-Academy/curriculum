defmodule Utils.NotebooksTest do
  use ExUnit.Case, async: true
  alias Utils.Notebooks
  doctest Utils.Notebooks

  test "init student progress json file" do
    outline = """
    ## Section 1
    * Reading
      * [Lesson 1](reading/file_name1.livemd)
    * Exercises
      * [Lesson 2](exercises/file_name1.livemd)

    ## Section 2
    * Reading
      * [Lesson 3](reading/file_name2.livemd)
    * Exercises
      * [Lesson 4](exercises/file_name2.livemd)
    """

    expected = %{
      "file_name1_reading" => false,
      "file_name1_exercise" => false,
      "file_name2_reading" => false,
      "file_name2_exercise" => false
    }

    assert Notebooks.student_progress_map(outline) == expected
  end

  test "can create navigation for every outline path" do
    outline = File.read!("../start.livemd")
    navigation_map = Notebooks.navigation_blocks(outline)

    Regex.scan(~r/reading\/\w+.livemd|exercises\/\w+.livemd/, outline)
    |> List.flatten()
    |> Enum.each(fn file_name ->
      assert Notebooks.navigation(navigation_map, file_name)
    end)
  end

  test "navigation" do
    outline = """
    ## Section 1
    * Reading
      * [Lesson 1](reading/file_name1.livemd)
      * [Lesson 2](reading/file_name2.livemd)
    * Exercises
      * [Exercise 1](exercises/file_name3.livemd)
    """

    navigation_map = Notebooks.navigation_blocks(outline)

    assert navigation_map ==
             %{
               "reading/file_name1.livemd" => %{
                 prev: "-",
                 next: "[Lesson 2](../reading/file_name2.livemd)"
               },
               "reading/file_name2.livemd" => %{
                 prev: "[Lesson 1](../reading/file_name1.livemd)",
                 next: "[Exercise 1](../exercises/file_name3.livemd)"
               },
               "exercises/file_name3.livemd" => %{
                 prev: "[Lesson 2](../reading/file_name2.livemd)",
                 next: "-"
               }
             }

    assert Notebooks.navigation(navigation_map, "reading/file_name1.livemd") == """
           ## Up Next

           | Previous | Next |
           | :------- | ----:|
           | - | [Lesson 2](../reading/file_name2.livemd) |
           """

    assert Notebooks.navigation(navigation_map, "reading/file_name2.livemd") == """
           ## Up Next

           | Previous | Next |
           | :------- | ----:|
           | [Lesson 1](../reading/file_name1.livemd) | [Exercise 1](../exercises/file_name3.livemd) |
           """

    assert Notebooks.navigation(navigation_map, "exercises/file_name3.livemd") == """
           ## Up Next

           | Previous | Next |
           | :------- | ----:|
           | [Lesson 2](../reading/file_name2.livemd) | - |
           """
  end
end

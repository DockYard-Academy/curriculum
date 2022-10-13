defmodule Mix.Tasks.Bc.UpdateReadmeOutlineTest do
  use ExUnit.Case
  doctest Mix.Tasks.Bc.UpdateReadmeOutline
  alias Mix.Tasks.Bc.UpdateReadmeOutline

  test "split_on_outline/1" do
    readme = """
    start
    <!-- course-outline-start -->
    ## Section 1
    ### SubSection 2
    * Reading
      * Topic
    * Exercises
      * Exercise
    ### SubSection 3
    <!-- course-outline-end -->
    finish
    """

    [start, outline, finish] = UpdateReadmeOutline.split_on_outline(readme)

    assert start == "start\n"

    assert outline ==
             "\n## Section 1\n### SubSection 2\n* Reading\n  * Topic\n* Exercises\n  * Exercise\n### SubSection 3\n"

    assert finish == "\nfinish\n"
  end

  test "sections/1" do
    outline = """
    ## Overview
    ## Section 1
    ### SubSection 2
    * Reading
      * Topic
    * Exercises
      * Exercise
    ### SubSection 3
    """

    assert UpdateReadmeOutline.sections(outline) == """
           ## Section 1
           * SubSection 2
           * SubSection 3
           """
  end
end

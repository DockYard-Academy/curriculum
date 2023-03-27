defmodule Mix.Tasks.UpdateReadmeOutlineTest do
  use ExUnit.Case
  doctest Mix.Tasks.UpdateReadmeOutline
  alias Mix.Tasks.UpdateReadmeOutline

  test "outline_snippet/1" do
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

    assert UpdateReadmeOutline.outline_snippet(outline) == """
           ## Section 1
           * SubSection 2
           * SubSection 3
           """
  end
end

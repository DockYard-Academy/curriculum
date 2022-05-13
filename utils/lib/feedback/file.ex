defmodule Utils.Feedback.File do
  use Utils.Feedback.Assertion

  feedback :copy_file, ignore: true do
    file_name = get_answers()
    assert {:ok, "Copy me!"} == File.read("../data/#{file_name}")
  end
end

defmodule Utils do
  @moduledoc """
  Documentation for `Utils`.
  """

  def feedback(description, answers) do
    Utils.Feedback.feedback(description, answers)
  rescue
    FunctionClauseError ->
      "Something went wrong, feedback does not exist for #{description}. Please speak to your teacher and/or reset the exercise."
  end
end

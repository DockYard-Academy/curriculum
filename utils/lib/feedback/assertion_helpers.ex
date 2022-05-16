defmodule Utils.Feedback.AssertionHelpers do
  def arity(function) do
    :erlang.fun_info(function)[:arity]
  end
end

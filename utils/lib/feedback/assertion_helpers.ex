defmodule Utils.Feedback.AssertionHelpers do
  def arity(function) do
    :erlang.fun_info(function)[:arity]
  end

  def defines_struct?(module) do
    Keyword.has_key?(module.__info__(:functions), :__struct__)
  end

  def struct_keys?(module, keys) do
    module_struct = struct(module)
    Enum.all?(keys, fn key -> Map.has_key?(module_struct, key) end)
  end
end

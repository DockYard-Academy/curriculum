defmodule Example do
  def test(arg) do
    test_value = "THING"
    dbg(%{key: "value"})
    test_value = "THING2"
    dbg(%{key: "value2"})

    internal() |> dbg()
  end

  def internal do
    test_value = "INTERNAL"
    dbg(%{key: "VALUE"})
    test_value
  end
end

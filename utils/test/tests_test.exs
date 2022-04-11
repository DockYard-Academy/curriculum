defmodule Utils.TestTest do
  use ExUnit.Case
  alias Utils.Test
  alias Utils.Solutions

  test "all tests have working solutions" do
    Enum.each(Utils.Test.test_module_names(), fn each ->
      assert Keyword.has_key?(Solutions.__info__(:functions), each),
             "define a Solutions.#{Atom.to_string(each)} function."

      Utils.test(each, apply(Solutions, each, []))
    end)
  end
end

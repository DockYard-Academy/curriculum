defmodule UtilsTest do
  use ExUnit.Case
  doctest Utils

  describe "visual/2" do
    test ":loading_bar" do
      %Kino.Markdown{} = Utils.visual(:loading_bar, true)
    end

    test ":light_control" do
      %Kino.Image{} = Utils.visual(:light_control, true)
    end
  end
end

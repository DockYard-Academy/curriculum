defmodule Utils.Constants do
  def string_maze do
    put_in(
      %{},
      Enum.map(
        [
          "west",
          "south",
          "east",
          "north",
          "east",
          "south",
          "east",
          "south",
          "east",
          "south",
          "west",
          "north"
        ],
        &Access.key(&1, %{})
      ),
      "Exit!"
    )
  end

  def atom_maze do
    put_in(
      %{},
      Enum.map(
        [
          :south,
          :east,
          :north,
          :east,
          :south,
          :west,
          :north,
          :east,
          :south,
          :east,
          :north,
          :west,
          :south,
          :west,
          :south,
          :west,
          :north,
          :west,
          :south,
          :west,
          :south,
          :west,
          :south,
          :east,
          :north,
          :east,
          :south,
          :east,
          :south
        ],
        &Access.key(&1, %{})
      ),
      "Exit!"
    )
  end
end

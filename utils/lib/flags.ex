defmodule Flags do
  @flags %{
    # Display Teacher-only editors in smart cells. Students should not see these editors when we launch.
    display_editors: false
  }

  def get(key) do
    @flags[key]
  end
end

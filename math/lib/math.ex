defmodule Math do
  @type input() :: list() | integer() | binary()

  @spec add(input(), input()) :: {:ok, input()} | {:error, :invalid_data}
  def add(x, y) do
    cond do
      is_integer(x) and is_integer(y) -> {:ok, x + y}
      is_binary(x) and is_binary(y) -> {:ok, x <> y }
      is_list(x) and is_list(y) -> {:ok, x ++ y}
      true -> {:error, :invalid_data}
    end
  end

  @spec subtract(input(), input()) :: {:ok, input()} | {:error, :invalid_data}
  def subtract(x, y) do
    cond do
      is_integer(x) and is_integer(y) -> {:ok, x - y}
      is_binary(x) and is_binary(y) -> {:ok, String.replace(x, y, "", global: false)}
      is_list(x) and is_list(y) -> {:ok, x -- y}
      true -> {:error, :invalid_data}
    end
  end

end

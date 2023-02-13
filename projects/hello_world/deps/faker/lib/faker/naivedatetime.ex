defmodule Faker.NaiveDateTime do
  @moduledoc false

  @doc """
  Returns a random date in the past up to N days, today not included

  ## Examples

      iex> Faker.NaiveDateTime.backward(4)
      #=> ~N[2016-12-20 06:02:17.922180]
  """
  @spec backward(integer) :: NaiveDateTime.t()
  def backward(days) do
    forward(-days)
  end

  @doc """
  Returns a random date in the future up to N days, today not included

  ## Examples

      iex> Faker.NaiveDateTime.forward(4)
      #=> ~N[2016-12-25 06:02:17.922180]
  """
  @spec forward(integer) :: NaiveDateTime.t()
  def forward(days) do
    days
    |> Faker.DateTime.forward()
    |> DateTime.to_naive()
  end

  @doc """
  Returns a random `NaiveDateTime.t` between two `NaiveDateTime.t`'s

  ## Examples

      iex> Faker.NaiveDateTime.between(~N[2016-12-20 00:00:00], ~N[2016-12-25 00:00:00])
      #=> ~N[2016-12-23 06:02:17.922180]
  """
  @spec between(NaiveDateTime.t(), NaiveDateTime.t()) :: NaiveDateTime.t()
  def between(from, to) do
    from
    |> Faker.DateTime.between(to)
    |> DateTime.to_naive()
  end
end

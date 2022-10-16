defmodule Schemer.Seasoned do
  @doc ~S"""
    Tests if list contains a repeated element

    iex> Schemer.Seasoned.two_in_a_row?([])
    false

    iex> Schemer.Seasoned.two_in_a_row?([1])
    false

    iex> Schemer.Seasoned.two_in_a_row?([1, 2])
    false

    iex> Schemer.Seasoned.two_in_a_row?([1, 1])
    true

    iex> Schemer.Seasoned.two_in_a_row?([1, 1, 2, 3])
    true

    iex> Schemer.Seasoned.two_in_a_row?([1, 2, 2, 3])
    true

    iex> Schemer.Seasoned.two_in_a_row?([1, 2, 3, 3])
    true

    iex> Schemer.Seasoned.two_in_a_row?([1, 2, 3, 4])
    false
  """
  def two_in_a_row?([]), do: false

  def two_in_a_row?([head | tail]), do: two_in_a_row_b?(head, tail)

  def two_in_a_row_b?(_, []), do: false

  def two_in_a_row_b?(preceding, [preceding | _]), do: true

  def two_in_a_row_b?(_, [head | tail]), do: two_in_a_row_b?(head, tail)
end


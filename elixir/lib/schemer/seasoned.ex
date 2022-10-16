defmodule Schemer.Seasoned do
  import Schemer.Little

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

  def two_in_a_row?([head | tail]), do: two_in_a_row(head, tail)

  def two_in_a_row(_, []), do: false

  def two_in_a_row(preceding, [preceding | _]), do: true

  def two_in_a_row(_, [head | tail]), do: two_in_a_row(head, tail)

  @doc ~S"""
    iex> Schemer.Seasoned.sum_of_prefixes([])
    []

    iex> Schemer.Seasoned.sum_of_prefixes([7])
    [7]

    iex> Schemer.Seasoned.sum_of_prefixes([1, 2, 3, 4])
    [1, 3, 6, 10]
  """
  def sum_of_prefixes(tup), do: sum_of_prefixes(0, tup)

  def sum_of_prefixes(_, []), do: []

  def sum_of_prefixes(sonssf, [head | tail]), do: [sonssf + head | sum_of_prefixes(sonssf + head, tail)]

  @doc ~S"""
    iex> Schemer.Seasoned.scramble([])
    []

    iex> Schemer.Seasoned.scramble([1, 1, 1, 3, 4, 2, 1, 1, 9, 2])
    [1, 1, 1, 1, 1, 4, 1, 1, 1, 9]
  """
  def scramble(tup), do: scramble(tup, [])

  def scramble([], _), do: []

  def scramble([ head | tail ], rev_pre), do: [ pick(head, [ head | rev_pre ]) | scramble(tail, [ head | rev_pre ])]
end


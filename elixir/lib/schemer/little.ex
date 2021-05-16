defmodule Schemer.Little do
  @doc ~S"""
    Tests if a is an atom (not a list)

    iex> Schemer.Little.atom?(:turkey)
    true

    iex> Schemer.Little.atom?(1492)
    true

    iex> Schemer.Little.atom?("u")
    true

    iex> Schemer.Little.atom?([:turkey])
    false

    iex> Schemer.Little.atom?([1, 4, 9, 2])
    false
  """
  def atom?(a), do: !is_list(a)

  @doc ~S"""
    Tests if a list is empty

    iex> Schemer.Little.empty?(12)
    false

    iex> Schemer.Little.empty?([])
    true

    iex> Schemer.Little.empty?([1, 2])
    false
  """
  def empty?([_ | _]), do: false

  def empty?([]), do: true

  def empty?(_), do: false

  @doc ~S"""
    Returns the first item in a list

    iex> Schemer.Little.car([0, 1])
    0

    iex> Schemer.Little.car([[0], 1])
    [0]
  """
  def car([head | _]), do: head

  @doc ~S"""
    Returns everything but the first item in a list

    iex> Schemer.Little.cdr([0, 1])
    [1]

    iex> Schemer.Little.cdr([[0], 1, 2])
    [1, 2]
  """
  def cdr([_ | tail]), do: tail

  @doc ~S"""
    Tests if a list contains only atoms

    iex> Schemer.Little.lat?([:Jack, :Sprat, :could, :eat, :no, :chicken, :fat])
    true

    iex> Schemer.Little.lat?([[:Jack], :Sprat, :could, :eat, :no, :chicken, :fat])
    false
  """
  def lat?([]), do: true

  def lat?([ head | tail]), do: atom?(head) && lat?(tail)

  @doc ~S"""
    Tests if a list contains the specified atom

    iex> Schemer.Little.member?(:tea, [:coffee, :tea, :or, :milk])
    true

    iex> Schemer.Little.member?(:poached, [:fried, :eggs, :and, :scrambled, :eggs])
    false
  """
  def member?(_, []), do: false

  def member?(a, [head | tail]), do: head == a || member?(a, tail)

  @doc ~S"""
    Removes the first matching atom from the list

    iex> Schemer.Little.rember(:and, [:bacon, :lettuce, :and, :tomato])
    [:bacon, :lettuce, :tomato]
  """
  def rember(_, []), do: []

  def rember(a, [a | tail]), do: tail

  def rember(a, [head | tail]), do: [head | rember(a, tail)]

  @doc ~S"""
    Returns the first column from a two dimensional array

    iex> Schemer.Little.firsts([[:a, :b], [:c, :d], [:e, :f]])
    [:a, :c, :e]
  """
  def firsts([]), do: []

  def firsts([head | tail]), do: [car(head) | firsts(tail)]

  @doc ~S"""
    Inserts the new atom to the right of the first matching old atom in the list

    iex> Schemer.Little.insert_right(:topping, :fudge, [:ice, :cream, :with, :fudge, :for, :dessert])
    [:ice, :cream, :with, :fudge, :topping, :for, :dessert]
  """
  def insert_right(_, _, []), do: []

  def insert_right(new, old, [old | tail]), do: [old | [new | tail]]

  def insert_right(new, old, [head | tail]), do: [head | insert_right(new, old, tail)]

  @doc ~S"""
    Inserts the new atom to the left of the first matching old atom in the list

    iex> Schemer.Little.insert_left(:chocolate, :fudge, [:ice, :cream, :with, :fudge, :for, :dessert])
    [:ice, :cream, :with, :chocolate, :fudge, :for, :dessert]
  """
  def insert_left(_, _, []), do: []

  def insert_left(new, old, [old | tail]), do: [new | [old | tail]]

  def insert_left(new, old, [head | tail]), do: [head | insert_left(new, old, tail)]

  @doc ~S"""
    Replaces the first matching old atom in the list with the new atom

    iex> Schemer.Little.subst(:topping, :fudge, [:ice, :cream, :with, :fudge, :for, :dessert])
    [:ice, :cream, :with, :topping, :for, :dessert]
  """
  def subst(_, _, []), do: []

  def subst(new, old, [old | tail]), do: [new | tail]

  def subst(new, old, [head | tail]), do: [head | subst(new, old, tail)]

  @doc ~S"""
    Replaces the first of the matching old atoms in the list with the new atom

    iex> Schemer.Little.subst2(:vanilla, :chocolate, :banana, [:banana, :ice, :cream, :with, :chocolate, :topping])
    [:vanilla, :ice, :cream, :with, :chocolate, :topping]
  """
  def subst2(_, _, _, []), do: []

  def subst2(new, o1, _, [o1 | tail]), do: [new | tail]

  def subst2(new, _, o2, [o2 | tail]), do: [new | tail]

  def subst2(new, o1, o2, [head | tail]), do: [head | subst2(new, o1, o2, tail)]

  @doc ~S"""
    Removes the all matching atoms from the list

    iex> Schemer.Little.multi_rember(:cup, [:coffee, :cup, :tea, :cup, :and, :hick, :cup])
    [:coffee, :tea, :and, :hick]
  """
  def multi_rember(_, []), do: []

  def multi_rember(a, [a | tail]), do: multi_rember(a, tail)

  def multi_rember(a, [head | tail]), do: [head | multi_rember(a, tail)]

  @doc ~S"""
    Inserts the new atom to the right of the all matching old atoms in the list

    iex> Schemer.Little.multi_insert_right(:fudge, :chocolate, [:chocolate, :ice, :cream, :with, :chocolate, :topping])
    [:chocolate, :fudge, :ice, :cream, :with, :chocolate, :fudge, :topping]
  """
  def multi_insert_right(_, _, []), do: []

  def multi_insert_right(new, old, [old | tail]), do: [old | [new | multi_insert_right(new, old, tail)]]

  def multi_insert_right(new, old, [head | tail]), do: [head | multi_insert_right(new, old, tail)]

  @doc ~S"""
    Inserts the new atom to the left of all matching old atoms in the list

    iex> Schemer.Little.multi_insert_left(:chocolate, :fudge, [:fudge, :ice, :cream, :with, :fudge, :for, :dessert])
    [:chocolate, :fudge, :ice, :cream, :with, :chocolate, :fudge, :for, :dessert]
  """
  def multi_insert_left(_, _, []), do: []

  def multi_insert_left(new, old, [old | tail]), do: [new | [old | multi_insert_left(new, old, tail)]]

  def multi_insert_left(new, old, [head | tail]), do: [head | multi_insert_left(new, old, tail)]

  @doc ~S"""
    Replaces the all matching old atoms in the list with the new atom

    iex> Schemer.Little.multi_subst(:vanilla, :chocolate, [:chocolate, :ice, :cream, :with, :chocolate, :topping])
    [:vanilla, :ice, :cream, :with, :vanilla, :topping]
  """
  def multi_subst(_, _, []), do: []

  def multi_subst(new, old, [old | tail]), do: [new | multi_subst(new, old, tail)]

  def multi_subst(new, old, [head | tail]), do: [head | multi_subst(new, old, tail)]
end

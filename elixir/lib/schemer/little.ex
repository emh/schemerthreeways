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

    iex> Schemer.Little.rember([:and], [:bacon, :lettuce, [:and], :tomato])
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

  @doc ~S"""
    Adds 1 to n

    iex> Schemer.Little.add1(67)
    68
  """
  def add1(n), do: n + 1

  @doc ~S"""
    Subtracts 1 from n

    iex> Schemer.Little.sub1(67)
    66
  """
  def sub1(n), do: n - 1


  @doc ~S"""
    Tests if n is zero

    iex> Schemer.Little.zero?(0)
    true

    iex> Schemer.Little.zero?(67)
    false
  """
  def zero?(0), do: true

  def zero?(_), do: false

  @doc ~S"""
    Adds two numbers

    iex> Schemer.Little.plus(46, 12)
    58
  """
  def plus(n, 0), do: n

  def plus(n, m), do: add1(plus(n, sub1(m)))

  @doc ~S"""
    Subtracts two numbers

    iex> Schemer.Little.minus(17, 9)
    8
  """
  def minus(n, 0), do: n

  def minus(n, m), do: sub1(minus(n, sub1(m)))

  @doc ~S"""
    Sums the values in a tup

    iex> Schemer.Little.add_tup([3, 5, 2, 8])
    18
  """
  def add_tup([]), do: 0

  def add_tup([ head | tail ]), do: plus(head, add_tup(tail))

  @doc ~S"""
    Multiplies two numbers

    iex> Schemer.Little.mult(13, 4)
    52
  """
  def mult(_, 0), do: 0

  def mult(n, m), do: plus(n, mult(n, sub1(m)))

  @doc ~S"""
    Sums two tups

    iex> Schemer.Little.tup_plus([3, 6, 9, 11, 4], [8, 5, 2, 0, 7])
    [11, 11, 11, 11, 11]

    iex> Schemer.Little.tup_plus([3, 7, 8, 1], [4, 6])
    [7, 13, 8, 1]
  """
  def tup_plus([], tup2), do: tup2

  def tup_plus(tup1, []), do: tup1

  def tup_plus([h1 | t1], [h2 | t2]), do: [plus(h1, h2) | tup_plus(t1, t2)]

  @doc ~S"""
    Tests if one number is bigger than another

    iex> Schemer.Little.greater?(12, 133)
    false

    iex> Schemer.Little.greater?(120, 11)
    true

    iex> Schemer.Little.greater?(3, 3)
    false
  """
  def greater?(0, _), do: false

  def greater?(_, 0), do: true

  def greater?(n, m), do: greater?((sub1 n), (sub1 m))

  @doc ~S"""
    Tests if one number is smaller than another

    iex> Schemer.Little.less?(4, 6)
    true

    iex> Schemer.Little.less?(8, 3)
    false

    iex> Schemer.Little.less?(6, 6)
    false
  """
  def less?(_, 0), do: false

  def less?(0, _), do: true

  def less?(n, m), do: less?((sub1 n), (sub1 m))

  @doc ~S"""
    Tests if one number is the same as another

    iex> Schemer.Little.equal?(0, 0)
    true

    iex> Schemer.Little.equal?(1, 83)
    false

    iex> Schemer.Little.equal?(23, 2)
    false

    iex> Schemer.Little.equal?(42, 42)
    true
  """
  def equal?(m, m), do: true

  def equal?(_, _), do: false

  @doc ~S"""
    Raises one number to the power of another

    iex> Schemer.Little.expt(1, 1)
    1

    iex> Schemer.Little.expt(2, 3)
    8

    iex> Schemer.Little.expt(5, 3)
    125
  """
  def expt(_, 0), do: 1;

  def expt(n, m), do: mult(n, expt(n, sub1(m)));

  @doc ~S"""
    Divides one number by another

    iex> Schemer.Little.divide(15, 4)
    3
  """
  def divide(n, m) when n < m, do: 0

  def divide(n, m), do: add1(div(minus(n, m), m))

  @doc ~S"""
    Returns the number of items in the list

    iex> Schemer.Little.len([:hotdogs, :with, :mustard, :sauerkraut, :and, :pickles])
    6

    iex> Schemer.Little.len([:ham, :and, :cheese, :on, :rye])
    5
  """
  def len([]), do: 0

  def len(lat), do: add1(len(cdr(lat)))

  @doc ~S"""
    Picks the nth atom from the list

    iex> Schemer.Little.pick(4, [:lasagna, :spaghetti, :ravioli, :macaroni, :meatballs])
    :macaroni
  """
  def pick(1, [head | _]), do: head

  def pick(n, [_ | tail]), do: pick(sub1(n), tail)

  @doc ~S"""
    Removes the nth atom from the list

    iex> Schemer.Little.remove_pick(3, [:hotdogs, :and, :hot, :mustard])
    [:hotdogs, :and, :mustard]
  """
  def remove_pick(1, [_ | tail]), do: tail

  def remove_pick(n, [head | tail]), do: [head | remove_pick(sub1(n), tail)]

  @doc ~S"""
    Removes all numbers from a list

    iex> Schemer.Little.no_nums([5, :pears, 6, :prunes, 9, :dates])
    [:pears, :prunes, :dates]
  """
  def no_nums([]), do: []

  def no_nums([ head | tail]) when is_number(head), do: no_nums(tail)

  def no_nums([ head | tail ]), do: [head | no_nums(tail)]

  @doc ~S"""
    Removes all non numbers from a list

    iex> Schemer.Little.all_nums([5, :pears, 6, :prunes, 9, :dates])
    [5, 6, 9]
  """
  def all_nums([]), do: []

  def all_nums([ head | tail]) when is_number(head), do: [head | all_nums(tail)]

  def all_nums([ _ | tail ]), do: all_nums(tail)

  @doc ~S"""
    Counts occurrences of an atom in a list

    iex> Schemer.Little.occur(:macaroni, [:lasagna, :spaghetti, :ravioli, :macaroni, :meatballs, :macaroni])
    2

    iex> Schemer.Little.occur(:fettuccine, [:lasagna, :spaghetti, :ravioli, :macaroni, :meatballs, :macaroni])
    0
  """
  def occur(_, []), do: 0

  def occur(a, [ a | tail]), do: add1(occur(a, tail))

  def occur(a, [ _ | tail ]), do: occur(a, tail)

  @doc ~S"""
    Removes all occurrences of an atom from a nested list

    iex> Schemer.Little.rember_all(:cup, [[:coffee], :cup, [[:tea], :cup], [:and, [:hick]], :cup])
    [[:coffee], [[:tea]], [:and, [:hick]]]

    iex> Schemer.Little.rember_all(:sauce, [[[:tomato, :sauce]], [[:bean], :sauce], [:and, [[:flying]], :sauce]])
    [[[:tomato]], [[:bean]], [:and, [[:flying]]]]
  """
  def rember_all(_, []), do: []

  def rember_all(a, [a | tail]), do: rember_all(a, tail)

  def rember_all(a, [head | tail]) do
    cond do
      atom?(head) -> [head | rember_all(a, tail)]
      true -> [rember_all(a, head) | rember_all(a, tail)]
    end
  end

  @doc ~S"""
    Inserts the new atom to the right of all old atoms in a nested list

    iex> Schemer.Little.insert_right_all(2, 1, [1, 3, 4])
    [1, 2, 3, 4]

    iex> Schemer.Little.insert_right_all(:roast, :chuck, [[:how, :much, [:wood]], :could, [[:a, [:wood], :chuck]], [[[:chuck]]], [:if, [:a], [[:wood, :chuck]]], :could, :chuck, :wood])
    [[:how, :much, [:wood]], :could, [[:a, [:wood], :chuck, :roast]], [[[:chuck, :roast]]], [:if, [:a], [[:wood, :chuck, :roast]]], :could, :chuck, :roast, :wood]
  """
  def insert_right_all(_, _, []), do: []

  def insert_right_all(new, old, [old | tail]), do: [old | [new | insert_right_all(new, old, tail)]]

  def insert_right_all(new, old, [head | tail]) do
    cond do
      atom?(head) -> [head | insert_right_all(new, old, tail)]
      true -> [insert_right_all(new, old, head) | insert_right_all(new, old, tail)]
    end
  end

  @doc ~S"""
    Counts all occurrences of an atom in a nested list

    iex> Schemer.Little.occur_all(:banana, [[:banana], [:split, [[[[:banana, :ice]]], [:cream, [:banana]], :sherbet]], [:banana], [:bread], [:banana, :brandy]])
    5
  """
  def occur_all(_, []), do: 0

  def occur_all(a, [a | tail]), do: add1(occur_all(a, tail))

  def occur_all(a, [head | tail]) do
    cond do
      atom?(head) -> occur_all(a, tail)
      true -> plus(occur_all(a, head), occur_all(a, tail))
    end
  end

  @doc ~S"""
    Replaces all occurrences of an atom in a nested list with a new atom

    iex> Schemer.Little.subst_all(:orange, :banana, [[:banana], [:split, [[[[:banana, :ice]]], [:cream, [:banana]], :sherbet]], [:banana], [:bread], [:banana, :brandy]])
    [[:orange], [:split, [[[[:orange, :ice]]], [:cream, [:orange]], :sherbet]], [:orange], [:bread], [:orange, :brandy]]
  """
  def subst_all(_, _, []), do: []

  def subst_all(new, old, [old | tail]), do: [new | subst_all(new, old, tail)]

  def subst_all(new, old, [head | tail]) do
    cond do
      atom?(head) -> [head | subst_all(new, old, tail)]
      true -> [subst_all(new, old, head) | subst_all(new, old, tail)]
    end
  end

  @doc ~S"""
    Inserts the new atom to the left of all old atoms in a nested list

    iex> Schemer.Little.insert_left_all(1, 2, [2, 3, 4])
    [1, 2, 3, 4]

    iex> Schemer.Little.insert_left_all(:pecker, :chuck, [[:how, :much, [:wood]], :could, [[:a, [:wood], :chuck]], [[[:chuck]]], [:if, [:a], [[:wood, :chuck]]], :could, :chuck, :wood])
    [[:how, :much, [:wood]], :could, [[:a, [:wood], :pecker, :chuck]], [[[:pecker, :chuck]]], [:if, [:a], [[:wood, :pecker, :chuck]]], :could, :pecker, :chuck, :wood]
  """
  def insert_left_all(_, _, []), do: []

  def insert_left_all(new, old, [old | tail]), do: [new | [old | insert_left_all(new, old, tail)]]

  def insert_left_all(new, old, [head | tail]) do
    cond do
      atom?(head) -> [head | insert_left_all(new, old, tail)]
      true -> [insert_left_all(new, old, head) | insert_left_all(new, old, tail)]
    end
  end

  @doc ~S"""
    Tests if an atom occurs anywhere in a nested list

    iex> Schemer.Little.member_all(:chips, [[:potato], [:chips, [[:with], :fish], [:chips]]])
    true
  """
  def member_all(_, []), do: false

  def member_all(a, [a | _]), do: true

  def member_all(a, [head | tail]) do
    cond do
      atom?(head) -> member_all(a, tail)
      true -> member_all(a, head) || member_all(a, tail)
    end
  end

  @doc ~S"""
    Returns the left most atom in a nested list

    iex> Schemer.Little.left_most([[:potato], [:chips, [[:with], :fish], [:chips]]])
    :potato

    iex> Schemer.Little.left_most([[[:hot], [:tuna, [:and]]], :cheese])
    :hot
  """
  def left_most([head | _]) do
    cond do
      atom?(head) -> head
      true -> left_most(head)
    end
  end
end

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

  @doc ~S"""
    Tests that an arithmetic expression contains only numbers

    iex> Schemer.Little.numbered?([1, :+, 3])
    true

    iex> Schemer.Little.numbered?([2, :*, :sausage])
    false

    iex> Schemer.Little.numbered?([3, :+, [4, :*, 5]])
    true

    iex> Schemer.Little.numbered?([2, :*, [:sausage, :and, :cheese]])
    false
  """
  def numbered?([a | [_ | [b]]]), do: numbered?(a) && numbered?(b)

  def numbered?(aexp), do: is_number(aexp)

  @doc ~S"""
    Calculates the value of a numeric expression

    iex> Schemer.Little.value([1, :+, 3])
    4

    iex> Schemer.Little.value([1, :+, [3, :^, 4]])
    82

    iex> Schemer.Little.value([[3, :*, 6], :+, [8, :^, 2]])
    82
  """
  def value([first_sexp | [:+ | [second_sexp]]]), do: plus(value(first_sexp), value(second_sexp))

  def value([first_sexp | [:- | [second_sexp]]]), do: minus(value(first_sexp), value(second_sexp))

  def value([first_sexp | [:* | [second_sexp]]]), do: mult(value(first_sexp), value(second_sexp))

  def value([first_sexp | [:^ | [second_sexp]]]), do: expt(value(first_sexp), value(second_sexp))

  def value(nexp), do: nexp

  @doc ~S"""
    Detrermines if a list is also a set

    iex> Schemer.Little.set?([:apple, :peaches, :apple, :plum])
    false

    iex> Schemer.Little.set?([:apples, :peaches, :pears, :plums])
    true

    iex> Schemer.Little.set?([])
    true

    iex> Schemer.Little.set?([:apple, 3, :pear, 4, 9, :apple, 3, 4])
    false


    iex> Schemer.Little.set?([:apple, 3, :pear, 4, 9])
    true
  """
  def set?([]), do: true

  def set?([head | tail]) do
    cond do
      member?(head, tail) -> false
      true -> set?(tail)
    end
  end

  @doc ~S"""
    Creates a set from a list

    iex> Schemer.Little.make_set([:apple, :peach, :pear, :peach, :plum, :apple, :lemon, :peach])
    [:pear, :plum, :apple, :lemon, :peach]
  """
  def make_set([]), do: []

  def make_set([head | tail]) do
    cond do
      member?(head, tail) -> make_set(tail)
      true -> [head | make_set(tail)]
    end
  end

  @doc ~S"""
    Creates a set from a list

    iex> Schemer.Little.make_set2([:apple, :peach, :pear, :peach, :plum, :apple, :lemon, :peach])
    [:apple, :peach, :pear, :plum, :lemon]

    iex> Schemer.Little.make_set2([:apple, 3, :pear, 4, 9, :apple, 3, 4])
    [:apple, 3, :pear, 4, 9]
  """
  def make_set2([]), do: []

  def make_set2([head | tail]), do: [head | multi_rember(head, make_set2(tail))]

  @doc ~S"""
    Tests if one set is a subset of another

    iex> Schemer.Little.subset?([5, :chicken, :wings], [5, :hamburgers, 2, :pieces, :fried, :chicken, :and, :light, :duckling, :wings])
    true

    iex> Schemer.Little.subset?([4, :pounds, :of, :horseradish], [:four, :pounds, :chicken, :and, 5, :ounces, :horseradish])
    false
  """
  def subset?([], _), do: true

  def subset?([head | tail], set2), do: member?(head, set2) && subset?(tail, set2)

  @doc ~S"""
    Tests if two sets havbe the same members

    iex> Schemer.Little.equal_sets?([6, :large, :chickens, :with, :wings], [6, :chickens, :with, :large, :wings])
    true
  """
  def equal_sets?(set1, set2), do: subset?(set1, set2) && subset?(set2, set1)

  @doc ~S"""
    Tests if at least one atom from one list is a member of another list

    iex> Schemer.Little.intersect?([:stewed, :tomatoes, :and, :macaroni], [:macaroni, :and, :cheese])
    true
  """
  def intersect?([], _), do: true

  def intersect?([head | tail], set2), do: member?(head, set2) || intersect?(tail, set2)

  @doc ~S"""
    Returns the intersection of two sets

    iex> Schemer.Little.intersect([:stewed, :tomatoes, :and, :macaroni], [:macaroni, :and, :cheese])
    [:and, :macaroni]
  """
  def intersect([], _), do: []

  def intersect([head | tail], set2) do
    cond do
      member?(head, set2) -> [head | intersect(tail, set2)]
      true -> intersect(tail, set2)
    end
  end

  @doc ~S"""
    Returns the union of two sets

    iex> Schemer.Little.union([:stewed, :tomatoes, :and, :macaroni, :casserole], [:macaroni, :and, :cheese])
    [:stewed, :tomatoes, :casserole, :macaroni, :and, :cheese]
  """
  def union([], set2), do: set2

  def union([head | tail], set2) do
    cond do
      member?(head, set2) -> union(tail, set2)
      true -> [head | union(tail, set2)]
    end
  end

  @doc ~S"""
    Returns the elements of set1 that are not present in set2

    iex> Schemer.Little.difference([:stewed, :tomatoes, :and, :macaroni, :casserole], [:macaroni, :and, :cheese])
    [:stewed, :tomatoes, :casserole]
  """
  def difference([], _), do: []

  def difference([head | tail], set2) do
    cond do
      member?(head, set2) -> difference(tail, set2)
      true -> [head | difference(tail, set2)]
    end
  end

  @doc ~S"""
    Returns the intersection of a list of sets

    iex> Schemer.Little.intersect_all([[:a, :b, :c], [:c, :a, :d, :e], [:e, :f, :g, :h, :a, :b]])
    [:a]

    iex> Schemer.Little.intersect_all([[6, :pears, :and], [3, :peaches, :and, 6, :peppers], [8, :pears, :and, 6, :plums], [:and, 6, :prunes, :with, :some, :apples]])
    [6, :and]
  """
  def intersect_all([head | []]), do: head

  def intersect_all([head | tail]), do: intersect(head, intersect_all(tail))

  @doc ~S"""
    Tests if a list has just two items

    iex> Schemer.Little.a_pair?([:pear, :pear])
    true

    iex> Schemer.Little.a_pair?([3, 7])
    true

    iex> Schemer.Little.a_pair?([[2], [:pair]])
    true

    iex> Schemer.Little.a_pair?([:full, [:house]])
    true

    iex> Schemer.Little.a_pair?([])
    false

    iex> Schemer.Little.a_pair?([1])
    false

    iex> Schemer.Little.a_pair?([1, 2, 3])
    false
  """
  def a_pair?([]), do: false

  def a_pair?([_ | []]), do: false

  def a_pair?([_, _ | []]), do: true

  def a_pair?([_ | [_ | _]]), do: false

  def a_pair(_), do: false

  @doc ~S"""
    Tests if a relation is a function (first items of all pairs are unique)

    iex> Schemer.Little.fun?([[4, 3], [4, 2], [7, 6], [6, 2], [3, 4]])
    false

    iex> Schemer.Little.fun?([[4, 3], [8, 2], [7, 6], [6, 2], [3, 4]])
    true
  """
  def fun?(rel), do:
    rel
    |> firsts
    |> set?

  def build(s1, s2), do: [s1, s2]

  def second([_, b | _]), do: b

  def rev_pair([a, b]), do: [b, a]

  @doc ~S"""
    Flips the pairs in a relation

    iex> Schemer.Little.rev_rel([[8, :a], [:pumpkin, :pie], [:got, :sick]])
    [[:a, 8], [:pie, :pumpkin], [:sick, :got]]
  """
  def rev_rel([]), do: []

  def rev_rel([head | tail]), do: [rev_pair(head) | rev_rel(tail)]

  def seconds([]), do: []

  def seconds([head | tail]), do: [second(head) | seconds(tail)]

  @doc ~S"""
    tests if a function is a full function

    iex> Schemer.Little.full_fun?([[8, 3], [4, 2], [7, 6], [6, 2], [3, 4]])
    false

    iex> Schemer.Little.full_fun?([[8, 3], [4, 8], [7, 6], [6, 2], [3, 4]])
    true

    iex> Schemer.Little.full_fun?([[:grape, :raisin], [:plum, :prune], [:stewed, :prune]])
    false

    iex> Schemer.Little.full_fun?([[:grape, :raisin], [:plum, :prune], [:stewed, :grape]])
    true
  """
  def full_fun?(fun), do:
    fun
    |> seconds
    |> set?

  @doc ~S"""
    tests if a function is a full function

    iex> Schemer.Little.one_to_one?([[8, 3], [4, 2], [7, 6], [6, 2], [3, 4]])
    false

    iex> Schemer.Little.one_to_one?([[8, 3], [4, 8], [7, 6], [6, 2], [3, 4]])
    true

    iex> Schemer.Little.one_to_one?([[:grape, :raisin], [:plum, :prune], [:stewed, :prune]])
    false

    iex> Schemer.Little.one_to_one?([[:grape, :raisin], [:plum, :prune], [:stewed, :grape]])
    true
  """
  def one_to_one?(fun), do:
    fun
    |> rev_rel
    |> fun?

  @doc ~S"""
    removes the first member of the list that matches the supplied atom using the suplied test function

    iex> Schemer.Little.remove_member_fn(&Schemer.Little.equal?/2, 5, [6, 2, 5, 3])
    [6, 2, 3]

    iex> Schemer.Little.remove_member_fn(&Schemer.Little.equal?/2, :jelly, [:jelly, :beans, :are, :good])
    [:beans, :are, :good]

    iex> Schemer.Little.remove_member_fn(&Schemer.Little.equal?/2, [:pop, :corn], [:lemonade, [:pop, :corn], :and, [:cake]])
    [:lemonade, :and, [:cake]]
  """
  def remove_member_fn(_, _, []), do: []

  def remove_member_fn(fun, a, [head | tail]) do
    cond do
      fun.(head, a) -> tail
      true -> [head | remove_member_fn(fun, a, tail)]
    end
  end

  @doc ~S"""
    creates an equality function for a fixed value

    iex> Schemer.Little.equal_c?('salad').('salad')
    true

    iex> Schemer.Little.equal_c?('salad').('tuna')
    false
  """
  def equal_c?(a), do: fn(x) -> a == x end

  @doc ~S"""
    generates a remove_member function that uses the specified test function

    iex> Schemer.Little.remove_member_fn2(&Schemer.Little.equal?/2).(5, [6, 2, 5, 3])
    [6, 2, 3]

    iex> Schemer.Little.remove_member_fn2(&Schemer.Little.equal?/2).(:jelly, [:jelly, :beans, :are, :good])
    [:beans, :are, :good]

    iex> Schemer.Little.remove_member_fn2(&Schemer.Little.equal?/2).([:pop, :corn], [:lemonade, [:pop, :corn], :and, [:cake]])
    [:lemonade, :and, [:cake]]
  """
  def remove_member_fn2(fun) do
    fn
      (_, []) -> []
      (a, [head | tail]) ->
        cond do
          fun.(head, a) -> tail
          true -> [head | remove_member_fn2(fun).(a, tail)]
        end
    end
  end

  def insert_g(seq_fn) do
    fn
      (_, _, []) -> []
      (a, b, [b | tail]) -> seq_fn.(a, b, tail)
      (a, b, [head | tail]) -> [head | insert_g(seq_fn).(a, b, tail)]
    end
  end

  @doc ~S"""
    uses insert_g and a sequence function to generate a new inssert_right function

    iex> Schemer.Little.insert_right(:topping, :fudge, [:ice, :cream, :with, :fudge, :for, :dessert])
    [:ice, :cream, :with, :fudge, :topping, :for, :dessert]
  """
  def insert_right2(a, b, l), do: insert_g(&([&2 | [&1 | &3]])).(a, b, l)

  @doc ~S"""
    uses insert_g and a sequence function to generate a new inssert_left function

    iex> Schemer.Little.insert_left2(:chocolate, :fudge, [:ice, :cream, :with, :fudge, :for, :dessert])
    [:ice, :cream, :with, :chocolate, :fudge, :for, :dessert]
  """
  def insert_left2(a, b, l), do: insert_g(&([&1 | [&2 | &3]])).(a, b, l)

  @doc ~S"""
    uses insert_g and a sequence function to generate a new subst function

    iex> Schemer.Little.subst3(:topping, :fudge, [:ice, :cream, :with, :fudge, :for, :dessert])
    [:ice, :cream, :with, :topping, :for, :dessert]
  """
  def subst3(a, b, l), do: insert_g(fn(a, _, l) -> [a | l] end).(a, b, l)

  @doc ~S"""
    uses insert_g and a sequence function to generate a new rember function

    iex> Schemer.Little.rember3(:and, [:bacon, :lettuce, :and, :tomato])
    [:bacon, :lettuce, :tomato]

    iex> Schemer.Little.rember3([:and], [:bacon, :lettuce, [:and], :tomato])
    [:bacon, :lettuce, :tomato]
  """
  def rember3(a, l), do: insert_g(fn(_, _, l) -> l end).(false, a, l)

  def atom_to_fn(:+), do: &plus/2
  def atom_to_fn(:-), do: &minus/2
  def atom_to_fn(:*), do: &mult/2
  def atom_to_fn(_), do: &expt/2

  @doc ~S"""
    Calculates the value of a numeric expression

    iex> Schemer.Little.value2([1, :+, 3])
    4

    iex> Schemer.Little.value2([1, :+, [3, :^, 4]])
    82

    iex> Schemer.Little.value2([[3, :*, 6], :+, [8, :^, 2]])
    82
  """
  def value2([first_sexp, op, second_sexp]), do: atom_to_fn(op).(value(first_sexp), value(second_sexp))

  def value2(nexp), do: nexp

  @doc ~S"""
    Divides the list into one list of items that match and one list of items that don't and then calls the collector function with those two lists

    iex> Schemer.Little.multi_rember_co(:tuna, [:strawberries, :tuna, :and, :swordfish], (fn (x, _) -> x end))
    [:strawberries, :and, :swordfish]

    iex> Schemer.Little.multi_rember_co(:tuna, [:strawberries, :tuna, :and, :swordfish], (fn (x, _) -> length(x) end))
    3
  """
  def multi_rember_co(_, [], col), do: col.([], [])

  def multi_rember_co(a, [a | tail], col), do: multi_rember_co(a, tail, (fn (newlat, seen) -> col.(newlat, [a | seen]) end))

  def multi_rember_co(a, [head | tail], col), do: multi_rember_co(a, tail, (fn (newlat, seen) -> col.([head | newlat], seen) end))

  @doc ~S"""
    inserts the new item to the left or right of the matching old items in a list and passes the new list and a count of the insertions to the collector function

    iex> Schemer.Little.multi_insert_leftright_co(:salty, :fish, :chips, [:chips, :and, :fish, :or, :fish, :and, :chips], (fn (newlat, _, _) -> newlat end))
    [:chips, :salty, :and, :salty, :fish, :or, :salty, :fish, :and, :chips, :salty]
  """
  def multi_insert_leftright_co(_, _, _, [], col), do: col.([], 0, 0)

  def multi_insert_leftright_co(new, old_l, old_r, [old_l | tail], col), do: multi_insert_leftright_co(new, old_l, old_r, tail, (fn (newlat, num_left, num_right) -> col.([new | [old_l | newlat]], add1(num_left), num_right) end))

  def multi_insert_leftright_co(new, old_l, old_r, [old_r | tail], col), do: multi_insert_leftright_co(new, old_l, old_r, tail, (fn (newlat, num_left, num_right) -> col.([old_r | [new | newlat]], num_left, add1(num_right)) end))

  def multi_insert_leftright_co(new, old_l, old_r, [head | tail], col), do: multi_insert_leftright_co(new, old_l, old_r, tail, (fn (newlat, num_left, num_right) -> col.([head | newlat], num_left, num_right) end))

  @doc ~S"""
    Returns all the even numbers in a nested list

    iex> Schemer.Little.evens_only_all([[9, 1, 2, 8], 3, 10, [[9, 9], 7, 6], 2])
    [[2, 8], 10, [[], 6], 2]
  """
  defguard is_even(value) when is_integer(value) and rem(value, 2) == 0

  def evens_only_all([]), do: []

  def evens_only_all([head | tail]) when is_even(head), do: [head | evens_only_all(tail)]

  def evens_only_all([head | tail]) when is_number(head), do: evens_only_all(tail)

  def evens_only_all([head | tail]), do: [evens_only_all(head) | evens_only_all(tail)]

  @doc ~S"""
    Returns all the even numbers in a nested list and calculates their product and the sum of all the odd numbers that were removed and passes that all to a collector function

    iex> Schemer.Little.evens_only_all_co([[9, 1, 2, 8], 3, 10, [[9, 9], 7, 6], 2], (fn (l, p, s) -> [s | [p | l]] end))
    [38, 1920, [2, 8], 10, [[], 6], 2]
  """
  def evens_only_all_co([], col), do: col.([], 1, 0)

  def evens_only_all_co([head | tail], col) when is_list(head), do: evens_only_all_co(head, (fn (al, ap, as) -> evens_only_all_co(tail, (fn (dl, dp, ds) -> col.([al | dl], ap * dp, as + ds) end)) end))

  def evens_only_all_co([head | tail], col) when is_even(head), do: evens_only_all_co(tail, (fn (nl, p, s) -> col.([head | nl], p * head, s) end))

  def evens_only_all_co([head | tail], col) when is_number(head), do: evens_only_all_co(tail, (fn (nl, p, s) -> col.(nl, p, s + head) end))

  def keep_looking(a, sorn, lat) when is_number(sorn), do: keep_looking(a, pick(sorn, lat), lat);

  def keep_looking(a, sorn, _), do: sorn == a

  @doc ~S"""
    Finds an item in a list using a sequence of indexes also in the list

    iex> Schemer.Little.looking(:caviar, [6, 2, 4, :caviar, 5, 7, 3])
    true

    iex> Schemer.Little.looking(:caviar, [6, 2, :grits, :caviar, 5, 7, 3])
    false
  """
  def looking(a, lat), do: keep_looking(a, pick(1, lat), lat)

  @doc ~s"""
    iex> Schemer.Little.shift([[:a, :b], :c])
    [:a, [:b, :c]]

    iex> Schemer.Little.shift([[:a, :b], [:c, :d]])
    [:a, [:b, [:c, :d]]]
  """
  def shift([[a, b], c]), do: build(a, build(b, c))

  @doc ~S"""
    iex> Schemer.Little.weight_all([[:a, :b], :c])
    7

    iex> Schemer.Little.weight_all([:a, [:b, :c]])
    5
  """
  def weight_all([a, b]), do: (weight_all(a) * 2) + weight_all(b)

  def weight_all(_), do: 1

  def part_fac(f) do
    (fn
      (0) -> 1
      (n) -> n * f.(n - 1)
    end)
  end

  @doc ~S"""
    iex> (Schemer.Little.y(&Schemer.Little.part_fac/1)).(5)
    120
  """
  def y(le), do: (fn (f) -> f.(f) end).((fn (f) -> le.((fn (x) -> (f.(f)).(x) end)) end))

  @doc ~S"""
    Finds the value for a given name in an entry

    iex> Schemer.Little.lookup_in_entry(:entree, [[:appetizer, :entree, :beverage], [:food, :tastes, :good]], (fn (n) -> n end))
    :tastes

    iex> Schemer.Little.lookup_in_entry(:dessert, [[:appetizer, :entree, :beverage], [:food, :tastes, :good]], (fn (n) -> n end))
    :dessert
  """
  def lookup_in_entry(name, [names, values], entry_fn), do: lookup_in_entry_help(name, names, values, entry_fn)

  def lookup_in_entry_help(name, [], _, entry_fn), do: entry_fn.(name)

  def lookup_in_entry_help(name, [name | _], [value | _], _), do: value

  def lookup_in_entry_help(name, [_ | names], [_ | values], entry_fn), do: lookup_in_entry_help(name, names, values, entry_fn)

  @doc ~S"""
    Finds the value for a given name in a table of entries

    iex> Schemer.Little.lookup_in_table(:entree, [[[:entree, :dessert], [:spaghetti, :spumoni]], [[:appetizer, :entree, :beverage], [:food, :tastes, :good]]], (fn (n) -> n end))
    :spaghetti

    iex> Schemer.Little.lookup_in_table(:beverage, [[[:entree, :dessert], [:spaghetti, :spumoni]], [[:appetizer, :entree, :beverage], [:food, :tastes, :good]]], (fn (n) -> n end))
    :good
  """
  def lookup_in_table(name, [], table_fn), do: table_fn.(name)

  def lookup_in_table(name, [head | tail], table_fn), do: lookup_in_entry(name, head, (fn (name) -> lookup_in_table(name, tail, table_fn) end))
end

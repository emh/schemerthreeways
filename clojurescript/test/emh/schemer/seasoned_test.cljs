(ns emh.schemer.seasoned-test
  (:require
    [cljs.test :refer-macros [deftest is testing run-tests]]
    [emh.schemer.seasoned :refer [two-in-a-row? sum-of-prefixes scramble]]))

(deftest two-in-a-row?-test
  (is (= (two-in-a-row? '()) false))
  (is (= (two-in-a-row? '(1)) false))
  (is (= (two-in-a-row? '(1 2)) false))
  (is (= (two-in-a-row? '(1 1)) true))
  (is (= (two-in-a-row? '(1 1 2 3)) true))
  (is (= (two-in-a-row? '(1 2 2 3)) true))
  (is (= (two-in-a-row? '(1 2 3 3)) true))
  (is (= (two-in-a-row? '(1 2 3 4)) false)))

(deftest sum-of-prefixes-test
  (is (= (sum-of-prefixes '()) '()))
  (is (= (sum-of-prefixes '(7)) '(7)))
  (is (= (sum-of-prefixes '(1 2 3 4)) '(1 3 6 10))))

(deftest scramble-test
  (is (= (scramble '()) '()))
  (is (= (scramble '(1 1 1 3 4 2 1 1 9 2)) '(1 1 1 1 1 4 1 1 1 9))))

(run-tests)


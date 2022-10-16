(ns emh.schemer.seasoned-test
  (:require
    [cljs.test :refer-macros [deftest is testing run-tests]]
    [emh.schemer.seasoned :refer [two-in-a-row?]]))

(deftest two-in-a-row?-test
  (is (= (two-in-a-row? '()) false))
  (is (= (two-in-a-row? '(1)) false))
  (is (= (two-in-a-row? '(1 2)) false))
  (is (= (two-in-a-row? '(1 1)) true))
  (is (= (two-in-a-row? '(1 1 2 3)) true))
  (is (= (two-in-a-row? '(1 2 2 3)) true))
  (is (= (two-in-a-row? '(1 2 3 3)) true))
  (is (= (two-in-a-row? '(1 1 3 4)) false)))

(run-tests)


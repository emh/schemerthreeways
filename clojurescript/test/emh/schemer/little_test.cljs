(ns emh.schemer.little-test
  (:require
    [cljs.test :refer-macros [deftest is testing run-tests]]
    [emh.schemer.little :refer [atom? lat? member? rember firsts insert-right insert-left subst subst2 multi-rember multi-insert-right multi-insert-left multi-subst]]))

(deftest atom?-test
  (is (= (atom? :turkey) true))
  (is (= (atom? 1492) true))
  (is (= (atom? "u") true))
  (is (= (atom? "*abc$") true))
  (is (= (atom? '(:turkey)) false))
  (is (= (atom? '(1 4 9 2)) false)))

(deftest lat?-test
  (is (= (lat? '(:Jack :Sprat :could :eat :no :chicken :fat)) true))
  (is (= (lat? '('(:Jack) :Sprat :could :eat :no :chicken :fat)) false)))

(deftest member?-test
  (is (= (member? :tea '(:coffee :tea :or :milk)) true))
  (is (= (member? :poached '(:fried :eggs :and :scrambled :eggs)) false)))

(deftest rember-test
  (is (= (rember :and '(:bacon :lettuce :and :tomato)) '(:bacon :lettuce :tomato))))

(deftest firsts-test
  (is (= (firsts '((:a :b) (:c :d) (:e :f))) '(:a :c :e))))

(deftest insert-right-test
  (is (= (insert-right :topping :fudge '(:ice :cream :with :fudge :for :dessert)) '(:ice :cream :with :fudge :topping :for :dessert))))

(deftest insert-left-test
  (is (= (insert-left :chocolate :fudge '(:ice :cream :with :fudge :for :dessert)) '(:ice :cream :with :chocolate :fudge :for :dessert))))

(deftest subst-test
  (is (= (subst :topping :fudge '(:ice :cream :with :fudge :for :dessert)) '(:ice :cream :with :topping :for :dessert))))

(deftest subst2-test
  (is (= (subst2 :vanilla :chocolate :banana '(:banana :ice :cream :with :chocolate :topping)) '(:vanilla :ice :cream :with :chocolate :topping))))

(deftest multi-rember-test
  (is (= (multi-rember :cup '(:coffee :cup :tea :cup :and :hick :cup)) '(:coffee :tea :and :hick))))

(deftest multi-insert-right-test
  (is (= (multi-insert-right :fudge :chocolate '(:chocolate :ice :cream :with :chocolate :topping)) '(:chocolate :fudge :ice :cream :with :chocolate :fudge :topping))))

(deftest multi-insert-left-test
  (is (= (multi-insert-left :chocolate :fudge '(:fudge :ice :cream :with :fudge :for :dessert)) '(:chocolate :fudge :ice :cream :with :chocolate :fudge :for :dessert))))

(deftest multi-subst-test
  (is (= (multi-subst :vanilla :chocolate '(:chocolate :ice :cream :with :chocolate :topping)) '(:vanilla :ice :cream :with :vanilla :topping))))

(run-tests)

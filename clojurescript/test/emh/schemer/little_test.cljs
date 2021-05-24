(ns emh.schemer.little-test
  (:require
    [cljs.test :refer-macros [deftest is testing run-tests]]
    [emh.schemer.little :refer [atom? lat? member? rember firsts insert-right insert-left subst subst2 multi-rember multi-insert-right multi-insert-left multi-subst add1 sub1 plus minus add-tup mult tup-plus greater? less? equal? expt div length pick remove-pick no-nums all-nums occur rember* insert-right* occur* subst* insert-left* member* leftmost rember2, numbered?, value, set??, makeset, makeset2, subset?, eqset?, intersect?, intersect, union, difference, intersect-all, a-pair?, fun?, rev-rel, full-fun?, one-to-one?]]))

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

(deftest add1-test
  (is (= (add1 67) 68)))

(deftest sub1-test
  (is (= (sub1 67) 66)))

(deftest plus-test
  (is (= (plus 46 12) 58)))

(deftest minus-test
  (is (= (minus 17 9) 8)))

(deftest add-tup-test
  (is (= (add-tup '(3 5 2 8)) 18)))

(deftest mult-test
  (is (= (mult 13 4) 52)))

(deftest tup-plus-test
  (is (= (tup-plus '(3 6 9 11 4) '(8 5 2 0 7)) '(11 11 11 11 11)))
  (is (= (tup-plus '(3 7 8 1) '(4 6)) '(7 13 8 1))))

(deftest greater?-test
  (is (= (greater? 12 133) false))
  (is (= (greater? 120 11) true))
  (is (= (greater? 3 3) false)))

(deftest less?-test
  (is (= (less? 4 6) true))
  (is (= (less? 8 3) false))
  (is (= (less? 6 6) false)))

(deftest equal?-test
  (is (= (equal? 0 0) true))
  (is (= (equal? 1 83) false))
  (is (= (equal? 23 2) false))
  (is (= (equal? 42 42) true)))

(deftest expt-test
  (is (= (expt 1 1) 1))
  (is (= (expt 2 3) 8))
  (is (= (expt 5 3) 125)))

(deftest div-test
  (is (= (div 15 4) 3)))

(deftest length-test
  (is (= (length '(:hotdogs :with :mustard :sauerkraut :and :pickles)) 6))
  (is (= (length '(:ham :and :cheese :on :rye)) 5)))

(deftest pick-test
  (is (= (pick 4 '(:lasagna :spaghetti :ravioli :macaroni :meatball)) :macaroni)))

(deftest remove-pick-test
  (is (= (remove-pick 3 '(:hotdogs :with :hot :mustard)) '(:hotdogs :with :mustard))))

(deftest no-nums-test
  (is (= (no-nums '(5 :pears 6 :prunes 9 :dates)) '(:pears :prunes :dates))))

(deftest all-nums-test
  (is (= (all-nums '(5 :pears 6 :prunes 9 :dates)) '(5 6 9))))

(deftest occur-test
  (is (= (occur :macaroni '(:lasagna :spaghetti :ravioli :macaroni :meatball :macaroni)) 2))
  (is (= (occur :fettuccine '(:lasagna :spaghetti :ravioli :macaroni :meatball :macaroni)) 0)))

(deftest rember*-test
  (is (= (rember* :cup '((:coffee) :cup ((:tea) :cup) (:and (:hick)) :cup)) '((:coffee) ((:tea)) (:and (:hick)))))
  (is (= (rember* :sauce '(((:tomato :sauce)) ((:bean) :sauce) (:and ((:flying)) :sauce))) '(((:tomato)) ((:bean)) (:and ((:flying)))))))

(deftest insert-right*-test
  (is (= (insert-right* 2 1 '(1 3 4)) '(1 2 3 4)))
  (is (= (insert-right* :roast :chuck '((:how :much (:wood)) :could ((:a (:wood) :chuck)) (((:chuck))) (:if (:a) ((:wood :chuck))) :could :chuck :wood)) '((:how :much (:wood)) :could ((:a (:wood) :chuck :roast)) (((:chuck :roast))) (:if (:a) ((:wood :chuck :roast))) :could :chuck :roast :wood))))

(deftest occur*-test
  (is (= (occur* :banana '((:banana) (:split ((((:banana :ice))) (:cream (:banana)) :sherbet)) (:banana) (:bread) (:banana :brandy))) 5)))

(deftest subst*-test
  (is (= (subst* :orange :banana '((:banana) (:split ((((:banana :ice))) (:cream (:banana)) :sherbet)) (:banana) (:bread) (:banana :brandy))) '((:orange) (:split ((((:orange :ice))) (:cream (:orange)) :sherbet)) (:orange) (:bread) (:orange :brandy)))))

(deftest insert-left*-test
  (is (= (insert-left* :pecker
                       :chuck
                       '(
                          (:how :much (:wood))
                          :could
                          ((:a (:wood) :chuck))
                          (((:chuck)))
                          (:if (:a) ((:wood :chuck)))
                          :could :chuck :wood
                        ))
      '(
        (:how :much (:wood))
        :could
        ((:a (:wood) :pecker :chuck))
        (((:pecker :chuck)))
        (:if (:a) ((:wood :pecker :chuck)))
        :could :pecker :chuck :wood
      ))))

(deftest member*-test
  (is (= (member* :chips '((:potato) (:chips ((:with) :fish) (:chips)))) true)))

(deftest leftmost-test
  (is (= (leftmost '((:potato) (:chips ((:with) :fish) (:chips)))) :potato))
  (is (= (leftmost '(((:hot) (:tuna (:and))) :cheese)) :hot)))

(deftest rember2-test
  (is (= (rember2 :and '(:bacon :lettuce :and :tomato)) '(:bacon :lettuce :tomato)))
  (is (= (rember2 '(:and) '(:bacon :lettuce (:and) :tomato)) '(:bacon :lettuce :tomato))))

(deftest numbered?-test
  (is (= (numbered? '(1 :+ 3)) true))
  (is (= (numbered? '(2 :* :sausage)) false))
  (is (= (numbered? '(3 :+ (4 :* 5))) true))
  (is (= (numbered? '(2 :* (:sausage :and :cheese))) false)))

(deftest value-test
  (is (= (value '(1 :+ 3)) 4))
  (is (= (value '(1 :+ (3 :** 4))) 82))
  (is (= (value '((3 :* 6) :+ (8 :** 2))) 82)))

(deftest set??-test
  (is (= (set?? '(:apple :peaches :apple :plum)) false))
  (is (= (set?? '(:apples :peaches :pears :plums)) true))
  (is (= (set?? '()) true))
  (is (= (set?? '(:apple 3 :pear 4 9 :apple 3 4)) false))
  (is (= (set?? '(:apple 3 :pear 4 9)) true)))

(deftest makeset-test
  (is (= (makeset '(:apple :peach :pear :peach :plum :apple :lemon :peach)) '(:pear :plum :apple :lemon :peach))))

(deftest makeset2-test
  (is (= (makeset2 '(:apple :peach :pear :peach :plum :apple :lemon :peach)) '(:apple :peach :pear :plum :lemon)))
  (is (= (makeset2 '(:apple 3 :pear 4 9 :apple 3 4)) '(:apple 3 :pear 4 9))))

(deftest subset?-test
  (is (= (subset? '(5 :chicken :wings) '(5 :hamburgers 2 :pieces :fried :chicken :and :light :duckling :wings)) true))
  (is (= (subset? '(4 :pounds :of :horseradish) '(:four :pounds :chicken :and 5 :ounces :horseradish)) false)))

(deftest eqset?-test
  (is (= (eqset? '(6 :large :chickens :with :wings) '(6 :chickens :with :large :wings)) true)))

(deftest intersect?-test
  (is (= (intersect? '(:stewed :tomatoes :and :macaroni) '(:macaroni :and :cheese)), true)))

(deftest intersect-test
  (is (= (intersect '(:stewed :tomato :and :macaroni) '(:macaroni :and :cheese)) '(:and :macaroni))))

(deftest union-test
  (is (= (union '(:stewed :tomatoes :and :macaroni :casserole) '(:macaroni :and :cheese)) '(:stewed :tomatoes :casserole :macaroni :and :cheese))))

(deftest difference-test
  (is (= (difference '(:stewed :tomatoes :and :macaroni :casserole) '(:macaroni :and :cheese)) '(:stewed :tomatoes :casserole))))

(deftest inmtersect-all
  (is (= (intersect-all '((:a :b :c) (:c :a :d :e) (:e :f :g :h :a :b))) '(:a)))
  (is (= (intersect-all '((6 :pears :and) (3 :peaches :and 6 :peppers) (8 :pears :and 6 :plums) (:and 6 :prunes :with :some :apples))) '(6 :and))))

(deftest a-pair?-test
  (is (= (a-pair? '(:pear :pear)) true))
  (is (= (a-pair? '(3 7)) true))
  (is (= (a-pair? '((2) (:pair))) true))
  (is (= (a-pair? '(:full (:house))) true))
  (is (= (a-pair? '()) false))
  (is (= (a-pair? '(1)) false))
  (is (= (a-pair? '(1 2 3)) false)))

(deftest fun?-test
  (is (= (fun? '((4 3) (4 2) (7 6) (6 2) (3 4))) false))
  (is (= (fun? '((8 3) (4 2) (7 6) (6 2) (3 4))) true))
  (is (= (fun? '((:d 4) (:b 0) (:b 9) (:e 5) (:g 4))) false)))

(deftest rev-rel-test
  (is (= (rev-rel '((8 :a) (:pumpkin :pie) (:got :sick))) '((:a 8) (:pie :pumpkin) (:sick :got)))))

(deftest full-fun?-test
  (is (= (full-fun? '((8 3) (4 2) (7 6) (6 2) (3 4))) false))
  (is (= (full-fun? '((8 3) (4 8) (7 6) (6 2) (3 4))) true))
  (is (= (full-fun? '((:grape :raisin) (:plum :prune) (:stewed :prune))) false))
  (is (= (full-fun? '((:grape :raisin) (:plum :prune) (:stewed :grape))) true)))

(deftest one-to-one?-test
  (is (= (one-to-one? '((8 3) (4 2) (7 6) (6 2) (3 4))) false))
  (is (= (one-to-one? '((8 3) (4 8) (7 6) (6 2) (3 4))) true))
  (is (= (one-to-one? '((:grape :raisin) (:plum :prune) (:stewed :prune))) false))
  (is (= (one-to-one? '((:grape :raisin) (:plum :prune) (:stewed :grape))) true)))

(run-tests)


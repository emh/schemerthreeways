(ns emh.schemer.little)

(defn atom? [x]
  (not (list? x)))

(defn lat? [l]
  (cond
    (empty? l) true
    (atom? (first l)) (lat? (rest l))
    :else false))

(defn member? [a lat]
  (cond
    (empty? lat) false
    :else (or (= (first lat) a) (member? a (rest lat)))))

(defn rember [a lat]
  (cond
    (empty? lat) '()
    (= (first lat) a) (rest lat)
    :else (cons (first lat) (rember a (rest lat)))))

(defn firsts [lat]
  (cond
    (empty? lat) '()
    :else (cons (first (first lat)) (firsts (rest lat)))))

(defn insert-right [new old lat]
  (cond
    (empty? lat) '()
    (= (first lat) old) (cons old (cons new (rest lat)))
    :else (cons (first lat) (insert-right new old (rest lat)))))

(defn insert-left [new old lat]
  (cond
    (empty? lat) '()
    (= (first lat) old) (cons new lat)
    :else (cons (first lat) (insert-left new old (rest lat)))))

(defn subst [new old lat]
  (cond
    (empty? lat) '()
    (= (first lat) old) (cons new (rest lat))
    :alse (cons (first lat) (subst new old (rest lat)))))

(defn subst2 [new o1 o2 lat]
  (cond
    (empty? lat) '()
    (or (= (first lat) o1) (= (first lat) o2)) (cons new (rest lat))
    :alse (cons (first lat) (subst2 new o1 o2 (rest lat)))))

(defn multi-rember [a lat]
  (cond
    (empty? lat) '()
    (= (first lat) a) (multi-rember a (rest lat))
    :else (cons (first lat) (multi-rember a (rest lat)))))

(defn multi-insert-right [new old lat]
  (cond
    (empty? lat) '()
    (= (first lat) old) (cons old (cons new (multi-insert-right new old (rest lat))))
    :else (cons (first lat) (multi-insert-right new old (rest lat)))))

(defn multi-insert-left [new old lat]
  (cond
    (empty? lat) '()
    (= (first lat) old) (cons new (cons old (multi-insert-left new old (rest lat))))
    :else (cons (first lat) (multi-insert-left new old (rest lat)))))

(defn multi-subst [new old lat]
  (cond
    (empty? lat) '()
    (= (first lat) old) (cons new (multi-subst new old (rest lat)))
    :else (cons (first lat) (multi-subst new old (rest lat)))))

(defn add1 [n] (+ n 1))

(defn sub1 [n] (- n 1))

(defn plus [n m]
  (cond
    (zero? m) n
    :else (add1 (plus n (sub1 m)))))

(defn minus [n m]
  (cond
    (zero? m) n
    :else (sub1 (minus n (sub1 m)))))

(defn add-tup [tup]
  (cond
    (empty? tup) 0
    :else (plus (first tup) (add-tup (rest tup)))))

(defn mult [n m]
  (cond
    (zero? m) 0
    :else (plus n (mult n (sub1 m)))))

(defn tup-plus [tup1 tup2]
  (cond
    (empty? tup1) tup2
    (empty? tup2) tup1
    :else (cons (plus (first tup1) (first tup2)) (tup-plus (rest tup1) (rest tup2)))))

(defn greater? [n m]
  (cond
    (zero? n) false
    (zero? m) true
    :else (greater? (sub1 n) (sub1 m))))

(defn less? [n m]
  (cond
    (zero? m) false
    (zero? n) true
    :else (less? (sub1 n) (sub1 m))))

(defn equal? [n m]
  (cond
    (less? n m) false
    (greater? n m) false
    :else true))

(defn expt [n m]
  (cond
    (zero? m) 1
    :else (mult n (expt n (sub1 m)))))

(defn div [n m]
  (cond
    (less? n m) 0
    :else (add1 (div (minus n m) m))))

(defn length [lat]
  (cond
    (empty? lat) 0
    :else (add1 (length (rest lat)))))

(defn one? [n]
  (equal? n 1))

(defn pick [n lat]
  (cond
    (one? n) (first lat)
    :else (pick (sub1 n) (rest lat))))

(defn remove-pick [n lat]
  (cond
    (one? n) (rest lat)
    :else (cons (first lat) (remove-pick (sub1 n) (rest lat)))))

(defn no-nums [lat]
  (cond
    (empty? lat) []
    (number? (first lat)) (no-nums (rest lat))
    :else (cons (first lat) (no-nums (rest lat)))))

(defn all-nums [lat]
  (cond
    (empty? lat) []
    (number? (first lat)) (cons (first lat) (all-nums (rest lat)))
    :else (all-nums (rest lat))))

(defn occur [a lat]
  (cond
    (empty? lat) 0
    (= (first lat) a) (add1 (occur a (rest lat)))
    :else (occur a (rest lat))))

(defn rember* [a l]
  (cond
    (empty? l) '()
    (atom? (first l))
      (cond
        (= (first l) a) (rember* a (rest l))
        :else (cons (first l) (rember* a (rest l))))
    :else (cons (rember* a (first l)) (rember* a (rest l)))))

(defn insert-right* [new old l]
  (cond
    (empty? l) '()
    (atom? (first l))
      (cond
        (= (first l) old) (cons old (cons new (insert-right* new old (rest l))))
        :else (cons (first l) (insert-right* new old (rest l))))
    :else (cons (insert-right* new old (first l)) (insert-right* new old (rest l)))))

(defn occur* [a l]
  (cond
    (empty? l) 0
    (atom? (first l))
      (cond
        (= (first l) a) (add1 (occur* a (rest l)))
        :else (occur* a (rest l)))
    :else (plus (occur* a (first l)) (occur* a (rest l)))))

(defn subst* [new old l]
  (cond
    (empty? l) '()
    (atom? (first l))
      (cond
        (= (first l) old) (cons new (subst* new old (rest l)))
        :else (cons (first l) (subst* new old (rest l))))
    :else (cons (subst* new old (first l)) (subst* new old (rest l)))))

(defn insert-left* [new old l]
  (cond
    (empty? l) '()
    (atom? (first l))
      (cond
        (= (first l) old) (cons new (cons old (insert-left* new old (rest l))))
        :else (cons (first l) (insert-left* new old (rest l))))
    :else (cons (insert-left* new old (first l)) (insert-left* new old (rest l)))))

(defn member* [a l]
  (cond
    (empty? l) false
    (atom? (first l))
      (cond
        (= (first l) a) true
        :else (member* a (rest l)))
    :else (or (member* a (first l)) (member* a (rest l)))))

(defn leftmost [l]
  (cond
    (atom? (first l)) (first l)
    :else (leftmost (first l))))

(defn rember2 [s l]
  (cond
    (empty? l) '()
    (= (first l) s) (rest l)
    :else (cons (first l) (rember2 s (rest l)))))

(defn numbered? [aexp]
  (cond
    (atom? aexp) (number? aexp)
    :alse (and (numbered? (first aexp)) (numbered? (first (rest (rest aexp)))))))

(defn first-sexp [nexp] (first nexp))

(defn operator [nexp] (first (rest nexp)))

(defn second-sexp [nexp] (first (rest (rest nexp))))

(defn value [nexp]
  (cond
    (atom? nexp) nexp
    (= (operator nexp) :+) (plus (value (first-sexp nexp)) (value (second-sexp nexp)))
    (= (operator nexp) :-) (minus (value (first-sexp nexp)) (value (second-sexp nexp)))
    (= (operator nexp) :*) (mult (value (first-sexp nexp)) (value (second-sexp nexp)))
    :else (expt (value (first-sexp nexp)) (value (second-sexp nexp)))))

(defn set?? [lat]
  (cond
    (empty? lat) true
    (member? (first lat) (rest lat)) false
    :else (set?? (rest lat))))

(defn makeset [lat]
  (cond
    (empty? lat) []
    (member? (first lat) (rest lat)) (makeset (rest lat))
    :else (cons (first lat) (makeset (rest lat)))))

(defn makeset2 [lat]
  (cond
    (empty? lat) []
    :else (cons (first lat) (multi-rember (first lat) (makeset2 (rest lat))))))

(defn subset? [set1 set2]
  (cond
    (empty? set1) true
    :else (and
      (member? (first set1) set2)
      (subset? (rest set1) set2))))

(defn eqset? [set1 set2] (and (subset? set1 set2) (subset? set2 set1)))

(defn intersect? [set1 set2]
  (cond
    (empty? set1) false
    :else (or
      (member? (first set1) set2)
      (intersect? (rest set1) set2))))

(defn intersect [set1 set2]
  (cond
    (empty? set1) '()
    (member? (first set1) set2) (cons (first set1) (intersect (rest set1) set2))
    :else (intersect (rest set1) set2)))

(defn union [set1 set2]
  (cond
    (empty? set1) set2
    (member? (first set1) set2) (union (rest set1) set2)
    :else (cons (first set1) (union (rest set1) set2))))

(defn difference [set1 set2]
  (let [head (first set1)
        tail (rest set1)]
    (cond
      (empty? set1) []
      (member? head set2) (difference tail set2)
      :else (cons head (difference tail set2)))))

(defn intersect-all [lsets]
  (cond
    (empty? (rest lsets)) (first lsets)
    :else (intersect (first lsets) (intersect-all (rest lsets)))))

(defn a-pair? [l]
  (cond
    (atom? l) false
    (empty? l) false
    (empty? (rest l)) false
    (empty? (rest (rest l))) true
    :else false))

(defn fun? [rel] (set?? (firsts rel)))

(defn build [s1 s2] (cons s1 (cons s2 '())))

(defn rev-pair [pair] (build (second pair) (first pair)))

(defn rev-rel [rel]
  (cond
    (empty? rel) []
    :else (cons (rev-pair (first rel)) (rev-rel (rest rel)))))

(defn seconds [lat]
  (cond
    (empty? lat) []
    :else (cons (second (first lat)) (seconds (rest lat)))))

(defn full-fun? [fun] (set?? (seconds fun)))

(defn one-to-one? [fun] (fun? (rev-rel fun)))

(defn rember-f [test? a l]
  (cond
    (empty? l) []
    (test? (first l) a) (rest l)
    :else (cons (first l) (rember-f test? a (rest l)))))

(defn eq?-c [a]
  (fn [x] (= a x)))

(defn rember-f2 [test?]
  (fn [a l]
    (cond
      (empty? l) []
      (test? (first l) a) (rest l)
      :else (cons (first l) ((rember-f2 test?) a (rest l))))))

(defn insert-g [seq-fn]
  (fn [new old l]
    (cond
      (empty? l) '()
      (= (first l) old) (seq-fn new old (rest l))
      :else (cons (first l) ((insert-g seq-fn) new old (rest l))))))

(def insert-left2 (insert-g #(cons %1 (cons %2 %3))))

(def insert-right2 (insert-g #(cons %2 (cons %1 %3))))

(def subst3 (insert-g #(cons %1 %3)))

(defn rember3 [a l]
  ((insert-g (fn [new old l] l)) false a l))

(defn atom-to-fn [a]
  (cond
    (= a :+) plus
    (= a :-) minus
    (= a :*) mult
    :else expt))

(defn value2 [nexp]
  (cond
    (atom? nexp) nexp
    :else ((atom-to-fn (operator nexp)) (value (first-sexp nexp)) (value (second-sexp nexp)))))

(defn multi-rember2 [])

(defn multi-rember-f [test]
  (fn [a lat]
    (cond
      (empty? lat) []
      (test (first lat) a) ((multi-rember-f test) a (rest lat))
      :else (cons (first lat) ((multi-rember-f test) a (rest lat))))))

(defn multi-rember-t [test lat]
  (cond
    (empty? lat) []
    (test (first lat)) (multi-rember-t test (rest lat))
    :else (cons (first lat) (multi-rember-t test (rest lat)))))

(defn multi-rember-co [a lat col]
  (cond
    (empty? lat) (col [] [])
    (= (first lat) a)
      (multi-rember-co
        a
        (rest lat)
        (fn [newlat seen] (col newlat (cons (first lat) seen))))
    :else
      (multi-rember-co
        a
        (rest lat)
        (fn [newlat seen] (col (cons (first lat) newlat) seen)))))

(defn multi-insert-leftright-co [new old-left old-right lat col]
  (cond
    (empty? lat) (col [] 0 0)
    (= (first lat) old-left)
      (multi-insert-leftright-co
        new
        old-left
        old-right
        (rest lat)
        (fn [newlat left right] (col (cons new (cons old-left newlat)) (add1 left) right)))
    (= (first lat) old-right)
      (multi-insert-leftright-co
        new
        old-left
        old-right
        (rest lat)
        (fn [newlat left right] (col (cons old-right (cons new newlat)) left (add1 right))))
    :else
      (multi-insert-leftright-co
        new
        old-left
        old-right
        (rest lat)
        (fn [newlat left right] (col (cons (first lat) newlat) left right)))))

(defn evens-only* [l]
  (cond
    (empty? l) []
    (atom? (first l))
      (cond
        (even? (first l)) (cons (first l) (evens-only* (rest l)))
        :else (evens-only* (rest l)))
    :else (cons
      (evens-only* (first l))
      (evens-only* (rest l)))))

(defn evens-only*-co [l col]
  (cond
    (empty? l) (col [] 1 0)
    (atom? (first l))
      (cond
        (even? (first l)) (evens-only*-co (rest l) (fn [newl p s] (col (cons (first l) newl) (* p (first l)) s)))
        :else (evens-only*-co (rest l) (fn [newl p s] (col newl p (+ (first l) s)))))
    :else
      (evens-only*-co (first l) (fn [al ap as] (evens-only*-co (rest l) (fn [dl dp ds] (col (cons al dl) (* ap dp) (+ as ds))))))))

(defn keep-looking [a sorn lat]
  (cond
    (number? sorn) (keep-looking a (pick sorn lat) lat)
    :else (= sorn a)))

(defn looking [a lat] (keep-looking a (pick 1 lat) lat))

(defn shift [pair]
  (build (first (first pair)) (build (second (first pair)) (second pair))))

(defn align [pora]
  (cond
    (atom? pora) pora
    (a-pair? (first pora)) (align (shift pora))
    :else (build (first pora) (align (second pora)))))

(defn length* [pora]
  (cond
    (atom? pora) 1
    :else (+ (length* (first pora)) (length* (second pora)))))

(defn weight* [pora]
  (cond
    (atom? pora) 1
    :else (+ (* (weight* (first pora)) 2) (weight* (second pora)))))

(defn C [n]
  (cond
    (one? n) 1
    (even? n) (C (/ n 2))
    :else (C (add1 (* 3 n)))))

(defn A [n m]
  (cond
    (zero? n) (add1 m)
    (zero? m) (A (sub1 n) 1)
    :else (A (sub1 n) (A n (sub1 m)))))

(defn eternity [x] (eternity x))

;; length0 - only returns the length of an empty list
((fn [l]
  (cond
    (empty? l) 0
    :else (add1 (eternity (rest l))))) '())

;; length<=1
((fn [l]
  (cond
    (empty? l) 0
    :else (add1
      ((fn [l]
        (cond
          (empty? l) 0
          :else (add1 (eternity (rest l))))) (rest l)))))
  '(1))

;; also length0
((fn [length]
  (fn [l]
    (cond
      (empty? l) 0
      :else (add1 (length (rest l))))))
  eternity)

;; also length0
((fn [mk-length]
  (mk-length eternity))
  (fn [length]
    (fn [l]
      (cond
        (empty? l) 0
        :else (add1 (length (rest l)))))))

;; also length<=1
((fn [mk-length]
  (mk-length (mk-length eternity)))
  (fn [length]
    (fn [l]
      (cond
        (empty? l) 0
        :else (add1 (length (rest l)))))))

((fn [mk-length]
  (mk-length mk-length))
  (fn [length]
    (fn [l]
      (cond
        (empty? l) 0
        :else (add1 (length (rest l)))))))

;; also length<=1
(((fn [mk-length]
  (mk-length mk-length))
  (fn [mk-length]
    (fn [l]
      (cond
        (empty? l) 0
        :else (add1 ((mk-length eternity) (rest l)))))))

  '(:apples))

(((fn [mk-length]
  (mk-length mk-length))
  (fn [mk-length]
    ((fn [length]
      (fn [l]
        (cond
          (empty? l) 0
          :else (add1 (length (rest l))))))
      (fn [x]
        ((mk-length mk-length) x)))))
  '(:apples :oranges))

(defn Y [le]
  ((fn [f] (f f))
    (fn [f]
      (le (fn [x] ((f f) x))))))

(def new-entry build)

(defn lookup-in-entry-help [name names values entry-f]
  (cond
    (empty? names) (entry-f name)
    (= (first names) name) (first values)
    :else (lookup-in-entry-help name (rest names) (rest values) entry-f)))

(defn lookup-in-entry [name entry entry-f]
  (lookup-in-entry-help
    name
    (first entry)
    (second entry)
    entry-f))

(def extend-table cons)

(defn lookup-in-table [name table table-f]
  (cond
    (empty? table) (table-f name)
    :else (lookup-in-entry name (first table) (fn [name] (lookup-in-table name (rest table) table-f)))))

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

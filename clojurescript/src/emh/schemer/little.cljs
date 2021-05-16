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

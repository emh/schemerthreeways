(ns emh.schemer.seasoned
  (:require
    [emh.schemer.little :refer [pick]]))

(defn two-in-a-row-b? [preceding lat]
  (cond
    (empty? lat) false
    (= preceding (first lat)) true
    :else (two-in-a-row-b? (first lat) (rest lat))))
  
(defn two-in-a-row? [lat]
  (two-in-a-row-b? (first lat) (rest lat)))

(defn sum-of-prefixes-b [sonssf tup]
  (cond
    (empty? tup) '()
    :else (cons (+ sonssf (first tup)) (sum-of-prefixes-b (+ sonssf (first tup)) (rest tup)))))

(defn sum-of-prefixes [tup]
  (sum-of-prefixes-b 0 tup))

(defn scramble-b [tup rev-pre]
  (cond
    (empty? tup) '()
    :else (cons (pick (first tup) (cons (first tup) rev-pre)) (scramble-b (rest tup) (cons (first tup) rev-pre)))))

(defn scramble [tup]
  (scramble-b tup []))


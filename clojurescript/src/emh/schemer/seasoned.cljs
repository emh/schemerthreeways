(ns emh.schemer.seasoned)

(defn two-in-a-row-b? [preceding lat]
  (cond
    (empty? lat) false
    (= preceding (first lat)) true
    :else (two-in-a-row-b? (first lat) (rest lat))))
  
(defn two-in-a-row? [lat]
  (cond 
    (empty? lat) false
    :else (two-in-a-row-b? (first lat) (rest lat))))



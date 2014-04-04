(ns ttt.logics.generate-combs)

(defn- get-combs [nums x length] (subvec nums x (+ length x)))

(defn- get-board-list [length] (vec (range (* length length))))

(defn- generate-column-combs [x length combs]
  (if (= length 3)
    (conj combs [x (+ x length) (+ x (* length 2))])
    (conj combs [x (+ x length) (+ x (* length 2)) (+ x 12)])))

(defn row-combs [length]
  (let [nums (get-board-list length)]
  (loop [win-rows [] x 0]
    (if (= (count win-rows) length)
      win-rows
      (recur (conj win-rows (get-combs nums x length)) (+ length x))))))

(defn column-combs [length]
  (loop [column-combs [] x 0]
    (if (= (count column-combs) length)
      column-combs
      (recur (generate-column-combs x length column-combs) (+ x 1)))))

(defn diagonal-combs [length]
  (if (= length 3)
    [[0 4 8] [2 4 6]]
    [[0 5 10 15] [3 6 9 12]]))

(defn get-all-combs [length]
  (reduce into [(row-combs length)
                (column-combs length)
                (diagonal-combs length)]))


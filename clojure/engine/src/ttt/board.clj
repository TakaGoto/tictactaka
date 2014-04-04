(ns ttt.board
  (:require [ttt.logics.game-logic :refer [game-over?]]))

(def empty-slot "_")

(defn create-board [size]
  (into []
    (repeat
      (* size size) empty-slot)))

(defn- valid-move-range? [board index]
  (or (> index (count board))
      (< index 0)))

(defn- move-taken? [board index] (not= (nth board index) empty-slot))

(defn available? [board index]
  (if (or (valid-move-range? board index)
          (move-taken? board index))
    false true))

(defn board-empty? [board] (every? #{empty-slot} board))

(defn convert-empty-to-nums [board]
  (into []
    (map-indexed
      #(if (not= %2 empty-slot)
         %2 (str (inc %1))) board)))

(defn get-length [board] (int (java.lang.Math/sqrt (count board))))

(defn available-moves [board]
  (remove nil?
    (map-indexed
      #(if (= %2 empty-slot) %1)
        board)))

(defn- state-ok? [board index]
    (and (not (nil? index))
         (not (game-over? (vec board) (get-length board)))))

(defn make-move [board index mark]
  (let [new-board (vec board)]
    (if (state-ok? board index)
      (if (available? new-board index)
        (assoc new-board index mark)
        new-board)
      new-board)))

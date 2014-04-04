(ns ttt.logics.game-logic
  (:require [ttt.logics.generate-combs :refer [get-all-combs]]))

(def x "X")
(def o "O")

(defn full? [board] (every? #{x o} board))

(defn get-board-length [board] (if (= (count board) 9) 3 4))

(defn winner? [board combs]
  (and (not= (board (first combs)) "_")
       (apply = (map board combs))))

(defn- winner-in-set [board combs]
  (if (winner? board combs)
    (board (first combs))))

(defn winner [board length]
  (some #(winner-in-set board %) (get-all-combs length)))

(defn tie? [board length]
  (let [mark (winner board length)]
  (and (full? board)
       (not= mark x)
       (not= mark o))))

(defn game-over? [board length]
  (let [mark (winner board length)]
  (or (tie? board length)
      (= mark x)
      (= mark o))))

(defn find-player [board]
  (if (even? (count (filter #{x o} board)))
    :p-one :p-two))

(ns ttt.logics.minimax
  (:require [ttt.logics.game-logic :refer [game-over?
                                           get-board-length
                                           winner
                                           x o]])
  (:require [ttt.board :refer [make-move available-moves]]))

(defn- opponent-mark [mark]
  (if (= mark x) o x))

(defn- game-is-over [board]
  (game-over? board (get-board-length board)))

(defn- get-winner-mark [board]
  (winner board (get-board-length board)))

(defn- eval-score [board mark depth]
  (let [winner (get-winner-mark board)]
    (cond
      (= winner mark) (+ 10 depth)
      (= winner (opponent-mark mark)) (+ -10 depth)
      :else 0)))

(defn- eval-best-move [moves]
  (let [move (first (sort #(> (last %1) (last %2)) moves))]
    (if (nil? move)
      [-1] move)))

(defn- eval-game [board depth]
  (or
    (game-is-over board)
    (= depth 5)))

(def minimax
  (memoize
    (fn [board player depth alpha beta max? color]
      (if (or (game-is-over board) (= depth 5))
        (* (eval-score board player depth) color)
        (if max?
          (->> (available-moves board)
               (map #(minimax (make-move board % player) (opponent-mark player)
                              (inc depth) alpha beta (not max?) (- color)))
               (take-while #(< % beta))
               (cons alpha)
               (apply max))
          (->> (available-moves board)
               (map #(minimax (make-move board % player) (opponent-mark player)
                              (inc depth) alpha beta (not max?) (- color)))
               (take-while #(< % beta))
               (cons beta)
               (apply min)))))))

(defn get-move [board player depth]
  (eval-best-move
    (map (fn[move]
      (let [marked-board (make-move board move player)]
           [move (minimax marked-board (opponent-mark player) depth -100 100 false -1)]))
      (available-moves board))))

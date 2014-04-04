(ns ttt.game
  (:require [ttt.players.create-players :refer :all :as player-factory]
            [ttt.board :refer [create-board make-move
                               board-empty? get-length]]
            [ttt.logics.game-logic :refer [x o find-player game-over?
                                           winner]]
            [ttt.ui.ui-protocol :refer :all])
            (:import clojure.lang.PersistentHashMap)
  (:import java.util.HashMap))

(defn get-options [options]
  {:p-one (player-factory/create-player (:p-one options) x)
   :p-two (player-factory/create-player (:p-two options) o)
   :board (create-board (Integer. (:board-size options)))
   :board-size (:board-size options)})

(defn make-player-move [player board ui]
  (print-board (ui) board)
  (println)
  (make-move board (dec (move player board ui)) (:mark player)))

(defn make-a-move [settings ui]
  {:p-one (:p-one settings)
   :p-two (:p-two settings)
   :board-size (:board-size settings)
   :board (make-player-move
            ((find-player (:board settings)) settings)
            (:board settings) ui)})

(defn get-result [result]
  (if (or (= result x) (= result o))
    result
    "tie"))

(defn over? [board board-size]
  (true? (game-over? board board-size)))

(defn end-game [board board-size ui]
  (print-board (ui) board)
  (display-end-game (ui)
    (get-result
      (winner board board-size))))

(defn play-game [ui]
  (welcome (ui))
  (loop [settings (get-options (ask-options (ui)))
         board-size (Integer. (:board-size settings))]
    (if (over? (:board settings) board-size)
      (end-game (:board settings) board-size ui)
      (recur (make-a-move settings ui) board-size)))
  (if (ask-play-again (ui)) (play-game ui)))

(defn- get-player [settings board]
  (let [player (find-player board)]
    (if (= player :p-one)
      (:p-one settings)
      (:p-two settings))))

(defn- check-move [user-move player board]
  (if (not (nil? user-move))
    user-move))

(defn- is-human? [player]
  (= (class player) ttt.players.create_players.Human))

(defn- validate-move [board player user-move]
  (and (board-empty? board)
       (is-human? player)
       (not (nil? user-move))))

(defn- prompt-end-game [ui board]
  (display-end-game (ui) (get-result (winner board (get-length board))))
  board)

(defn- make-play-move [player ui board]
  (let [new-board (make-move board (dec (move player board ui)) (:mark player))]
    (if (over? new-board (get-length board))
      (prompt-end-game ui new-board))
    new-board))

(defn- make-valid-move [ui player board user-move]
  (make-move board (dec (Integer. user-move)) (:mark player)))

(defn- make-move-check-state [ui player board user-move]
  (welcome (ui))
  (let [new-board (make-move board (dec (Integer. user-move)) (:mark player))]
    (if (over? new-board (get-length new-board))
      (prompt-end-game ui new-board))
    new-board))

(defn- check-state-board [board ui]
  (if (over? board (get-length board))
    (prompt-end-game ui board))
  board)

(defn play [ui settings & [user-move]]
  (welcome (ui))
  (let [options (get-options settings)
        board (vec (:board settings))
        player (get-player options board)]

    (if (validate-move board player user-move)
      (make-move-check-state ui player board user-move))
      (if (over? board (get-length board))
        (prompt-end-game ui board)
        (if (not (is-human? player))
          (make-play-move player ui board)
          (if (nil? user-move)
            (check-state-board board ui)
            (make-move-check-state ui player board user-move))))))

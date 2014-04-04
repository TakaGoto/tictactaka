(ns ttt.players.create-players
  (:require [ttt.logics.minimax :refer [get-move]]
            [ttt.ui.ui-protocol :refer :all]))

(defprotocol Player
  (mark [this])
  (move [this board ui]))

(defrecord Human [mark]
  Player
  (mark [this] (:mark this))
  (move [this board ui] (ask-player-move (ui))))

(defrecord Computer [mark]
  Player
  (mark [this] (:mark this))
  (move [this board _] (inc (first (get-move board (:mark this) 0)))))

(defn create-player [type mark]
  (case type
    "h" (Human. mark)
    "c" (Computer. mark)))

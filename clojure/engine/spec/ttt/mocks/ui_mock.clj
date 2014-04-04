(ns ttt.mocks.ui-mock
  (:require [ttt.ui.ui-protocol :refer :all]))

(def message (atom ""))

(def display-welcome-message "displayed welcome message")

(def continue?  "asked for continue")

(def ask-ttt-options {:p-one "h" :p-two "c" :board-size "3"})

(def display-board "displayed board")

(def prompt-player-move "displayed board")

(def prompt-end-game "prompted end game")

(def ask-move "asked player move")

(defn get-the-message [] message)

(defn ui-mock []
  (reify
    Ui
    (welcome [this] (swap! message (fn [n] "displayed welcome message")))
    (ask-play-again [this] continue?)
    (ask-options [this] ask-ttt-options)
    (print-board [this board] display-board)
    (display-end-game [this result] (swap! message (fn [n] "end game prompted")))
    (ask-player-move [this] "5")))

(ns console_ttt.ui
  (:require [ttt.ui.ui-protocol :refer :all]
            [ttt.board :refer [get-length convert-empty-to-nums]]))

(defn prompt [message] (println message) (read-line))

(defn- display-welcome-message [] (println "Welcome to Tic Tac Toe!"))

(defn- continue? []
  (let [input (prompt "play again? (y)es: ")]
    (if (= (clojure.string/lower-case input) "y")
      true
      false)))

(defn- ask-player-option [player]
  (loop [type (prompt (str "Enter player " player " type(h/c): "))]
    (if (or (= type "c") (= type "h"))
      type
       (recur (prompt (str "Enter correct player " player " type: "))))))

(defn- ask-board-option []
  (loop [board-size (prompt (str "Enter board size: "))]
    (if (or (= board-size "3") (= board-size "4"))
      board-size
      (recur (prompt (str "Enter board size: "))))))

(defn- ask-ttt-options []
  {:p-one (ask-player-option "One")
   :p-two (ask-player-option "Two")
   :board-size (ask-board-option )})

(defn- end-game [result]
  (if (= result "tie")
  (println "Game over!  It is a tie.")
  (println (str "Game over!  " result " has won!"))))

(defn- display-board [board]
  (doseq [row (partition (get-length board)
                    (convert-empty-to-nums board))]
     (println (str "| " (clojure.string/join " | " row) " |"))))

(defn- ask-user-move []
  (Integer. (prompt "Enter your move: ")))

(defn ui-console []
  (reify
    Ui
    (welcome [this] (display-welcome-message))
    (ask-play-again [this] (continue?))
    (ask-options [this] (ask-ttt-options))
    (print-board [this board] (display-board board))
    (display-end-game [this result] (end-game result))
    (ask-player-move [this] (ask-user-move))))

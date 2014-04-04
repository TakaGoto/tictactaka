(ns ttt.game-spec
  (:require [speclj.core :refer :all]
            [ttt.game :refer :all]
            [ttt.ui.ui-protocol :refer :all]
            [ttt.mocks.ui-mock :refer [ui-mock message]]))

(defn gen-board [board]
  (subvec (clojure.string/split board #"") 1))

(describe "game"
  (context "get-result"
    (it "returns tie if not an X or O"
      (should= "tie"
        (get-result "_")))

    (it "returns X if winner is X"
      (should= "X"
        (get-result "X")))

    (it "returns O if winner is O"
      (should= "O"
        (get-result "O"))))

  (let [settings (get-options {:p-one "h" :p-two "c" :board-size "3"})]
    (context "create-board-and-players"
      (it "creates an array map of board and player"
        (should= "X"
          (:mark (:p-one settings)))
        (should= "O"
          (:mark (:p-two settings)))
        (should= "3"
          (:board-size settings))
        (should= (gen-board "_________")
          (:board settings)))))

  (context "play"
    (it "returns a good bye message when computer wins"
      (play ui-mock
            {:p-one "h" :p-two "c"
             :board (gen-board "OO__X_XX_")
             :board-size "3"} "5")
      (should= "end game prompted"
        @message))

    (it "displays welcome message"
      (play ui-mock
            {:p-one "h" :p-two "c"
             :board (gen-board "_________")
             :board-size "3"} "5")
      (should= "displayed welcome message"
        @message))

    (it "displays good bye message when computer already won"
      (play ui-mock
            {:p-one "h" :p-two "c"
             :board (gen-board "OOO_X_XX_")
             :board-size "3"} "5")
      (should= "end game prompted"
        @message)
      )

    (it "plays human turn"
      (should= (gen-board "____X____")
        (and clojure.lang.PersistentVector
             (play ui-mock
                   {:p-one "h" :p-two "c"
                    :board (gen-board "_________")
                    :board-size "3"} "5"))))

    (it "plays computers turn"
      (should= (gen-board "XXO_O____")
        (and clojure.lang.PersistentVector
             (play ui-mock
                   {:p-one "h" :p-two "c"
                    :board (gen-board "XX__O____")
                    :board-size "3"}))))

    (it "shouldnt do anything if its humans turn but no move was passed"
      (should= (gen-board "_________")
        (and clojure.lang.PersistentVector
             (play ui-mock
                   {:p-one "h" :p-two "c"
                    :board (gen-board "_________")
                    :board-size "3"}))))

    (it "makes a human move when board is empty and it is humans turn"
      (should= (gen-board "____X____")
        (and clojure.lang.PersistentVector
             (play ui-mock {:p-one "h" :p-two "c"
                            :board (gen-board "_________")
                            :board-size "3"} "5"))))

    (let [board
          (play ui-mock {:p-one "h" :p-two "c"
                         :board (gen-board "XX__O____")
                         :board-size "3"})]
      (it "makes a move by passing in a java hashmap"
        (should=
          (gen-board "XXO_O____")
          board)
        (should=
          clojure.lang.PersistentVector
          (class board))))

    (it "returns a persistent vector parsing an arraylist board"
      (should= clojure.lang.PersistentVector
        (class (play ui-mock {:p-one "h" :p-two "h"
                              :board (gen-board "____X____")
                              :board-size "3"} "9"))))

    (it "makes a move when second player is human and has a move"
      (should= (gen-board "XO_______")
        (play ui-mock {:p-one "h" :p-two "h"
                       :board (gen-board "X________")
                       :board-size "3"} "2")))

    (it "shouldn't make a move if game is over"
      (should= (gen-board "XXX______")
        (play ui-mock {:p-one "h" :p-two "h"
                       :board (gen-board "XXX______")
                       :board-size "3"} "5")))))

(describe "ui"
  (it "prompts the end game"
    (should= "end game prompted"
      (end-game (gen-board "XXX______") 3 ui-mock))))


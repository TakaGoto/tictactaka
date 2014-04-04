(ns ttt.logics.game-logic-spec
  (:require [speclj.core :refer :all])
  (:require [ttt.logics.game-logic :refer :all])
  (:require [ttt.logics.generate-combs :refer :all]))

(defn gen-board [board]
  (subvec (clojure.string/split board #"") 1))

(describe "game logic"
  (context "tie"
    (it "returns true if it is a tie"
      (should= true (tie? (gen-board "XOXXOXOXO") 3)))

    (it "returns false if it is not a tie"
      (should= false (tie? (gen-board "XOX______") 3)))

    (it "returns false when game is full but not tie"
      (should= false (tie? (gen-board "XOXXOXXXO") 3)))))

  (context "full"
    (it "returns true if board is full"
      (should= true (full? (gen-board "XOXXOXOXO"))))

    (it "returns false if board is not full"
      (should= false (full? (gen-board "XOX______")))))

(context "game-over?"
  (it "returns true if the computer won with mark O"
    (should= true
      (game-over?
        (gen-board "OOO_X_XX_") 3)))

  (it "returns true if the game is over"
    (should= true (game-over? (gen-board "XXX______") 3)))

  (it "returns false when the game is not over"
    (should= false (game-over? (gen-board "_________") 3)))

  (it "returns true if the game is a tie"
    (should= true (game-over? (gen-board "XOXXOXOXO") 3)))

  (it "returns true if game is full and there is a winner"
    (should= true (game-over? (gen-board "OXXOOXOXO") 3)))

  (it "returns false when game is not over but has marks on sets"
    (should= false
      (game-over?
        (gen-board "O___X___X") 3)))

  (it "returns true when game is tie and no winner"
    (should= true
      (game-over?
        (gen-board "XOXXOXOXX") 3))))

(context "winner"
  (let [combs (ttt.logics.generate-combs/get-all-combs 3)]
    (describe "3x3"
      (it "returns X when X is a winner"
        (should= "X"
          (winner
            (gen-board "XXX______") 3)))

      (it "returns O when O is no winner"
        (should= "O"
          (winner
            (gen-board "OOO______") 3)))

      (it "returns X when the winner is X"
        (should= "X"
          (winner
            (gen-board "___XXX_OO") 3))))))

(context "check if there is a winner"
  (it "returns false when there is no winner"
    (should= false
      (winner?
        (gen-board "_________") (first (get-all-combs 3))))))

(context "find-player"
  (it "returns the current player"
    (should= :p-one
      (find-player (gen-board "_________"))))

  (it "returns current player with non empty board"
    (should= :p-two
      (find-player (gen-board "X________"))))

  (it "returns player one with non empty board"
    (should= :p-one
      (find-player (gen-board "XO_______"))))

  (it "returns computer player with 3 moves"
    (should= :p-two
      (find-player (gen-board "XX__O____")))))

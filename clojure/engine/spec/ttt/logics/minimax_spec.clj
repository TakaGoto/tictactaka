(ns ttt.logics.minimax-spec
  (:require [speclj.core :refer :all]
            [ttt.logics.minimax :refer :all]))

(defn gen-board [board]
  (subvec (clojure.string/split board #"") 1))

(describe "ai algorithm"
  (context "minimax"
    (it "returns 10 when computer has won"
      (should= 10
        (minimax (gen-board "OOOXOXOXO") "O" 0 -100 100 false 1)))

    (it "returns -10 when computer has lost"
      (should= -10
        (minimax (gen-board "XXXOXOXOX") "O" 0 -100 100 false 1)))

    (it "returns 0 when game is a tie"
      (should= 0
        (minimax (gen-board "XOXXOXOXO") "O" 0 -100 100 true 1)))

    (it "returns a tie when other player makes a move"
      (should= 0
        (minimax (gen-board "OXOOXOXO_") "X" 0 -100 100 false 1)))

    (it "returns a loss when computer loses after a move"
      (should= 0
        (minimax (gen-board "XOXXOXOX_") "O" 0 -100 100 false 1)))

    (it "returns -9 two moves behind"
      (should= -9
        (minimax (gen-board "O_OOXXXX_") "O" 0 -100 100 false -1)))

    (it "returns -10 a move behind"
      (should= -10
        (minimax (gen-board "XXXXXXXX_") "O" 0 -100 100 false 1)))))

(context "get-move"
  (it "returns a winning move when two moves left"
   (should= 7
      (first (get-move (gen-board "_OXXOOX_X") "O" 0))))

  (it "returns a winning move instead of a tie"
    (should= 7
      (first (get-move (gen-board "OX_OX____") "X" 0))))

  (it "chooses a tie instead of a loss"
    (should= 7
      (first (get-move (gen-board "OXOOX_X_X") "O" 0))))

  (it "chooses an early win"
    (should= 2
      (first (get-move (gen-board "OO_______") "O" 0))))

  (it "chooses an early block"
    (should= 3
      (first (get-move (gen-board "XOO___X__") "O" 0 ))))

  (it "chooses a smart move"
    (should= 2
      (first (get-move (gen-board "O___X___X") "O" 0))))

  (it "chooses a forced move"
    (should= 6
      (first (get-move (gen-board "OOXXXO___") "O" 0))))

  (it "gets a non move when its full"
    (should= -1
      (first (get-move (gen-board "XXXOOOXXX") "O" 0)))))

(ns ttt.board-spec
  (:require [speclj.core :refer :all])
  (:require [ttt.board :refer :all])
  (:import java.util.ArrayList))

(defn gen-board [board]
  (subvec (clojure.string/split board #"") 1))

(describe "board"
  (context "create-board"
    (it "creates a 3x3 board"
      (should=
        (gen-board "_________") (create-board 3)))

    (it "creates a 4x4 board"
      (should=
        (gen-board "________________") (create-board 4))))

  (let [board (gen-board "X________")]
    (context "available"
      (it "returns false if move is too high"
        (should= false
          (available? board 20)))

      (it "returns true when move is available"
        (should= true
          (available? board 1)))

      (it "returns false when move is taken"
        (should= false
          (available? board 0)))

      (it "returns false when move is too low"
        (should= false
          (available? board -10))))

    (context "make-move"
      (it "returns a new board with the given move with O"
        (should= (gen-board "XO_______")
          (make-move board 1 "O")))

      (it "returns a new board with the given move with X"
        (should= (gen-board "XX_______")
          (make-move board 1 "X")))

      (it "doesn't make move when the move is not available"
        (should= board
          (make-move board 0 "X")))

      (it "doesn't make move when the input is null"
        (should= (gen-board "X________")
          (make-move board nil "X")))

      (it "makes a move on an java arraylist"
        (should= (gen-board "X________")
          (make-move (ArrayList. ["_" "_" "_"
                                  "_" "_" "_"
                                  "_" "_" "_"])
                     0 "X")))
      )

    (context "empty?"
      (it "returns false when a 3x3 board is not empty"
        (should= false
          (board-empty? board)))

      (it "returns true when a 3x3 is empty"
        (should= true
          (board-empty?
            (gen-board "_________"))))

      (it "returns false wen a 4x4 board is not empty"
        (should= false
          (board-empty?
            (gen-board "_XO_____________"))))

      (it "returns true when a 4x4 is empty"
        (should= true
          (board-empty?
            (gen-board "________________"))))))

  (context "convert-empty-to-nums"
    (it "returns an empty board with nums instead of '_'"
      (should= (gen-board "123456789")
        (convert-empty-to-nums (gen-board "_________"))))

    (it "replaces empty slots with nums and leaves marks alone"
      (should= (gen-board "XO3456789")
        (convert-empty-to-nums (gen-board "XO_______")))))

  (context "find-length"
    (it "returns 3 for a 3x3 board"
      (should= 3
        (get-length (gen-board "_________"))))

    (it "returns 4 for a 4x4 board"
      (should= 4
        (get-length (gen-board "________________"))))

    (it "returns 5 for a 5x5 board"
      (should= 5
        (get-length (gen-board "_________________________")))))

  (context "available-moves"
    (it "returns all slots"
      (should= '(0 1 2 3 4 5 6 7 8)
        (available-moves (gen-board "_________"))))

    (it "returns all slots that are empty"
      (should= '(0 1 2 3)
        (available-moves (gen-board "____XOXOO"))))))

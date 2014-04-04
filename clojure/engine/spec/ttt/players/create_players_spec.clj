(ns ttt.players.create-players-spec
  (:require [speclj.core :refer :all]
            [ttt.players.create-players :refer :all]
            [ttt.mocks.ui-mock :refer [ui-mock]]))

(describe "players"
  (let [human (create-player "h" "X")]
    (describe "human"
      (around [it]
              (with-out-str (it)))
      (it "has a marker"
        (should= "X" (:mark human)))

      (it "makes a move"
        (should= "5"
          (with-in-str "5\n"
            (move human nil ui-mock))))))

  (let [computer (create-player "c" "O")]
    (describe "computer"
      (it "has a marker"
        (should= "O" (:mark computer)))

      (it "makes a move"
        (should= 3
          (move computer ["X" "X" "_" "O" "O" "X" "X" "X" "O"] ui-mock)))

      (it "makes a winning move"
        (should= 1
          (move computer ["_" "O" "O" "X" "X" "O" "O" "O" "X"] ui-mock))))))

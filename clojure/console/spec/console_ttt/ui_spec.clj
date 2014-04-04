(ns console_ttt.ui-spec
  (:require [speclj.core :refer :all]
            [console_ttt.ui :refer [ui-console]]
            [ttt.ui.ui-protocol :refer :all]))

(describe "console user interface"
  (it "welcomes the user"
    (should= "Welcome to Tic Tac Toe!\n"
      (with-out-str
        (welcome (ui-console)))))

  (it "displays tie end game"
    (should= "Game over!  It is a tie.\n"
      (with-out-str
        (display-end-game (ui-console) "tie"))))

  (it "displays X winner for end game"
    (should= "Game over!  X has won!\n"
      (with-out-str
        (display-end-game (ui-console) "X"))))

  (it "displays O winner for end game"
    (should= "Game over!  O has won!\n"
      (with-out-str
        (display-end-game (ui-console) "O"))))

  (context "continue?"
    (around [it]
      (with-out-str (it)))

    (it "returns false if user doesnt want to play again"
      (should= false
        (with-in-str "n\n"
          (ask-play-again (ui-console)))))

    (it "returns true if user does want to play again"
      (should= true
        (with-in-str "y\n"
          (ask-play-again (ui-console)))))

    (it "returns false if user butterfingered the button"
      (should= false
        (with-in-str "I\n"
          (ask-play-again (ui-console))))))

  (context "ask user for ttt options"
    (around [it]
      (with-out-str (it)))

    (it "should retrieve all the ttt options"
      (should= {:p-one "h" :p-two "c" :board-size "3"}
        (with-in-str "h\nc\n3\n"
          (ask-options (ui-console)))))

    (it "should ask user to re enter a proper option"
      (should= {:p-one "c" :p-two "h" :board-size "3"}
        (with-in-str "u\nc\ni\nh\n3\n"
          (ask-options (ui-console))))))

  (context "prints the board for the user"
    (it "prints out a 3x3 board"
      (should= "| 1 | 2 | 3 |\n| 4 | 5 | 6 |\n| 7 | 8 | 9 |\n"
        (with-out-str
          (print-board (ui-console) ["_" "_" "_"
                                     "_" "_" "_"
                                     "_" "_" "_"])))))

  (context "ask user for move"
    (around [it]
      (with-out-str (it)))

    (it "gets user player move"
      (should= 5
        (with-in-str "5\n"
          (ask-player-move (ui-console)))))))

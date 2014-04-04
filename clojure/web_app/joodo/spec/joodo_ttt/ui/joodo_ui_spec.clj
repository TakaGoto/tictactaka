(ns joodo_ttt.ui.joodo-ui-spec
  (:require [speclj.core :refer :all]
            [joodo_ttt.ui.joodo-ui :refer [ui-joodo message]]
            [ttt.ui.ui-protocol :refer :all]))

(describe "web ui for joodo"
  (it "welcomes the user"
    (welcome (ui-joodo))
    (should= "Welcome to Tic Tac Toe!"
      @message))

  (it "tells the user the game is over"
    (display-end-game (ui-joodo) "tie")
    (should= "game over!  play again? <a href='/'> yes</a>"
      @message))

  (it "asks the user if they want to play again" do
    (ask-play-again (ui-joodo))
    (should= "play again? <a href='/'> yes</a>"
      @message)))

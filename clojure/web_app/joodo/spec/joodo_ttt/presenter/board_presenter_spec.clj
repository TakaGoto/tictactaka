(ns joodo_ttt.presenter.board-presenter-spec
  (:require [speclj.core :refer :all]
            [joodo_ttt.presenter.board-presenter :refer :all]))

(describe "board presenter"
  (let [html-board (generate-board "_________")]
  (it "displays the board in html"
    (should-contain "form"
      html-board)
    (should-contain "player-move"
      html-board)
    (should-contain "post"
      html-board)
    (should-contain "submit"
      html-board)
    (should-contain "1"
      html-board)
    (should-contain "9"
      html-board)
    (should-contain "value"
      html-board))))

(ns ttt.ui.ui-protocol)

(defprotocol Ui
  (welcome [this])
  (ask-play-again [this])
  (ask-options [this])
  (print-board [this board])
  (display-end-game [this board])
  (ask-player-move [this]))

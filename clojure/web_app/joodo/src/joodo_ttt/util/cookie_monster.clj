(ns joodo_ttt.util.cookie-monster
  (:require [joodo_ttt.util.util :refer [create-ttt-board
                                         convert-board
                                         join-slots]]
            [ttt.game :refer [play]]
            [joodo_ttt.ui.joodo-ui :refer [ui-joodo]]
            [joodo.middleware.request :refer [*request*]]))


(defn get-cookie [k]
  (:value (k (:cookies *request*))))

(defn play-game [& [player-move]]
  (play ui-joodo
        {:p-one (get-cookie :p-one)
         :p-two (get-cookie :p-two)
         :board (convert-board (get-cookie :board))
         :board-size (get-cookie :board-size)}
        player-move))

(defn restore-cookies [player-move]
  {:p-one {:value (get-cookie :p-one) :path "/game"}
   :p-two {:value (get-cookie :p-two) :path "/game"}
   :board {:value (join-slots (play-game player-move)) :path "/game"}
   :board-size {:value (get-cookie :board-size) :path "/game"}})

(defn store-params-to-cookies [params]
  {:p-one {:value (:p-one params) :path "/game"}
   :p-two {:value (:p-two params) :path "/game"}
   :board-size {:value (:board-size params) :path "/game"}
   :board {:value (create-ttt-board (:board-size params))  :path "/game"}})


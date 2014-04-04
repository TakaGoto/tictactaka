(ns joodo_ttt.controller.game-controller
  (:require [compojure.core :refer [POST GET defroutes]]
            [ring.util.response :refer [redirect]]
            [joodo.middleware.request :refer [*request*]]
            [joodo.views :refer [render-template]]
            [joodo_ttt.presenter.board-presenter :refer [generate-board]]
            [joodo_ttt.util.cookie-monster :refer [restore-cookies play-game]]
            [joodo_ttt.ui.joodo-ui :refer [message]]
            [joodo.env :refer [env *env*]]
            [joodo_ttt.util.util :refer [convert-board join-slots]]))

(defn redirect-and-make-move [player-move]
  (-> (redirect "/game")
      (assoc :cookies (restore-cookies player-move))))

(defn render-board [board]
  {:status 200
   :headers {}
   :body (generate-board board)
   :cookies {:board {:value (join-slots board) :path "/game"}}})

(defroutes game-controller
  (GET "/game" [] (render-board (play-game)))
  (POST "/game" []
        (redirect-and-make-move (:player-move (:params *request*)))))

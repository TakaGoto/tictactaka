(ns joodo_ttt.controller.game-controller-spec
  (:require [speclj.core :refer [describe it should= should-contain
                                 context]]
            [joodo.spec-helpers.controller :refer [with-mock-rendering with-routes
                                                   do-post do-get should-redirect-to
                                                   request rendered-template
                                                   rendered-context]]
            [joodo_ttt.ui.joodo-ui :refer [message ui-joodo]]
            [ttt.game :refer [play]]
            [joodo_ttt.controller.game-controller :refer :all]
            [joodo.middleware.request :refer [*request*]]))

(describe "game-controller"
  (with-mock-rendering)
  (with-routes game-controller)

  (context "GET '/game'"
    (it "stores user's ttt options in cookies"
      (let [result (do-get "/game" :cookies {:p-one {:value "h"}
                                                      :p-two {:value "c"}
                                                      :board-size {:value "3"}
                                                      :board {:value "_________"}})]
      (should= 200 (:status result)))))

  (context "POST '/game'"
    (it "makes a move"
      (let [result (do-post "/game" :cookies {:p-one {:value "h"}
                                              :p-two {:value "c"}
                                              :board-size {:value "3"}
                                              :board {:value "_________"}}
                                    :params {:player-move "5"})]
        (should= "____X____"
          (:value (:board (:cookies result))))))

    (it "keeps the cookies recorded"
      (let [result (do-post "/game" :cookies {:p-one {:value "h"}
                                              :p-two {:value "c"}
                                              :board-size {:value "3"}
                                              :board {:value "_________"}}
                                    :params {:player-move "5"})]
        (should= "h"
          (:value (:p-one (:cookies result))))
        (should= "c"
          (:value (:p-two (:cookies result))))
        (should= "3"
          (:value (:board-size (:cookies result))))))

    (context "makes a computer move"
      (it "returns a different board"
        (let [result (do-post "/game" :cookies {:p-one {:value "c"}
                                              :p-two {:value "h"}
                                              :board-size {:value "3"}
                                              :board {:value "OX_OX____"}})]
          (should= "OX_OX__X_"
            (:value (:board (:cookies result)))))))

    (it "should return a game over prompt when game is over"
      (let [result (do-get "/game" :cookies {:p-one {:value "h"}
                                             :p-two {:value "c"}
                                             :board-size {:value "3"}
                                             :board {:value "OO__X_XX_"}})]
        (should= "OOO_X_XX_"
          (:value (:board (:cookies result))))
        (should= "game over!  play again? <a href='/'> yes</a>"
          @message)))

    (it "should give me a end game prompt when computer wins"
      (play ui-joodo
            {:p-one "h" :p-two "c"
             :board ["O" "O" "_" "_" "X" "_" "X" "X" "_"]
             :board-size "3"})
      (should= "game over!  play again? <a href='/'> yes</a>"
        @message))))

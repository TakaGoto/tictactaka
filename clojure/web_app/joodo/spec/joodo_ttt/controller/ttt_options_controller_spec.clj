(ns joodo_ttt.controller.ttt-options-controller-spec
  (:require
    [speclj.core :refer [describe it should= context should-contain]]
    [joodo.spec-helpers.controller :refer [with-mock-rendering
                                           with-routes do-post
                                           do-get
                                           should-redirect-to]]
    [joodo.spec-helpers.view :refer [should-have-tag rendered-template]]
    [joodo_ttt.controller.ttt-options-controller :refer [ttt-options-controller]]))

(describe "ttt-options-controller"
  (with-mock-rendering)
  (with-routes ttt-options-controller)

  (context "GET '/'"
    (it "handles GET"
      (let [result (do-get "/")]
        (should= 200
          (:status result)))))

  (context "POST '/'"
    (it "redirects to GET '/game'"
      (should-redirect-to
        (do-post "/" :params {:p-one "h" :p-two "c" :board-size "3"}) "/game"))

    (it "stores data into cookies"
      (let [result (do-post "/" :params {:p-one "h" :p-two "c" :board-size "3"})]
        (should= 302
          (:status result))
        (should= "h"
          (:value (:p-one (:cookies result))))
        (should= "c"
          (:value (:p-two (:cookies result))))
        (should= "3"
          (:value (:board-size (:cookies result))))
        (should= "_________"
          (:value (:board (:cookies result))))))))

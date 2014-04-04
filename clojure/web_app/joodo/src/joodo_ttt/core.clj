(ns joodo-ttt.core
  (:use
    [compojure.core :only (defroutes context GET POST)]
    [compojure.route :only (not-found)]
    [joodo.middleware.view-context :only (wrap-view-context)]
    [joodo.middleware.keyword-cookies :only (wrap-keyword-cookies)]
    [joodo.middleware.request :only (wrap-bind-request)]
    [joodo.views :only (render-template render-html)]
    [joodo.controllers :only (controller-router)]
    [joodo_ttt.controller.game-controller :refer [game-controller]]
    [joodo_ttt.controller.ttt-options-controller :refer [ttt-options-controller]]))

(defroutes joodo-ttt-routes
  (GET "/game" [] game-controller)
  (POST "/game" [] game-controller)
  (context "/" [] ttt-options-controller)
  (controller-router 'joodo-ttt.controller)
  (not-found (render-template "not_found" :template-root "joodo_ttt/view" :ns `joodo-ttt.view.view-helpers)))

(def app-handler
  (->
    joodo-ttt-routes
    (wrap-view-context :template-root "joodo_ttt/view" :ns `joodo-ttt.view.view-helpers)
    (wrap-keyword-cookies)
    (wrap-bind-request)))


(ns joodo_ttt.util.util
  (:require [joodo.middleware.request :refer [*request*]]))

(defn create-ttt-board [board-size]
  (let [size (Integer. board-size)]
  (clojure.string/join ""
    (take (* size size)
      (repeat "_")))))

(defn convert-board [board]
  (subvec (clojure.string/split board #"") 1))

(defn join-slots [board]
  (clojure.string/join "" board))

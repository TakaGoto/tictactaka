(ns console_ttt.main
  (:require [ttt.game :refer [play-game]]
            [console_ttt.ui :refer [ui-console]]))

(defn -main [& args]
  (play-game ui-console))

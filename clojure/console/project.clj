(defproject clojure_console_ttt "0.1.0-SNAPSHOT"
  :test-paths ["spec"]
  :description "Tic Tac Toe in Console"
  :url "http://github.com/takagoto"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :java-source-paths ["src"]
  :profiles {:dev {:dependencies [[speclj "2.5.0"]]}}
  :dependencies [[speclj "2.5.0"]
                 [org.clojure/clojure "1.5.1"]
                 [ttt_clojure "1.2.2-SNAPSHOT"]]
  :plugins [[speclj "2.5.0"]]
  :main console_ttt.main)

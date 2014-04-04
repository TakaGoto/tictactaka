(defproject ttt_clojure "1.2.2-SNAPSHOT"
  :test-paths ["spec/"]
  :description "Taka's Tic Tac Toe"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :java-source-paths ["src/"]
  :dependencies [[speclj "2.5.0"] [org.clojure/clojure "1.5.1"]]
  :profiles {:dev {:dependencies [[speclj "2.5.0"]]}}
  :plugins [[speclj "2.5.0"]])

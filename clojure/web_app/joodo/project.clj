(defproject joodo-ttt "0.0.1"
  :description "A website deployable to AppEngine"
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [joodo "0.10.0"]
                 [ttt_clojure "1.2.3-SNAPSHOT"]]

  :joodo-core-namespace joodo-ttt.core

  ; leiningen 2
  :profiles {:dev {:dependencies [[speclj "2.5.0"]]}}
  :test-paths ["spec/"]
  :java-source-paths ["src/"]
  :plugins [[speclj "2.5.0"]]
  )

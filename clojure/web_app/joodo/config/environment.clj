(use 'joodo.env)

(def environment {
  :joodo.core.namespace "joodo-ttt.core"
  ; environment settings go here
  })

(swap! *env* merge environment)
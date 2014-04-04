(doctype :html5)
[:html
 [:head
  [:meta {:http-equiv "Content-Type" :content "text/html" :charset "iso-8859-1"}]
  [:title "joodo-ttt"]
  (include-css "/stylesheets/joodo_ttt.css")
  (include-js "/javascript/joodo_ttt.js")]
 [:body
  (eval (:template-body joodo.views/*view-context*))
]]
if !exists("s:after_plugin_clojure_loaded")
	" Things to 2-indent in Clojure. i.e. Midje, Compojure
	let g:clojure_fuzzy_indent_patterns += ["GET", "POST", "PUT", "PATCH", "DELETE", "context"]
	let g:clojure_fuzzy_indent_patterns += ["facts\\?"]
	" Korma? let g:clojure_fuzzy_indent_patterns .= ",select.*,insert.*,update.*,delete.*,with.*"
endif

let s:after_plugin_clojure_loaded = 1

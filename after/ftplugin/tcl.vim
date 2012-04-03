" Spell check comments
syn region  tclComment  start="^\s*\#" skip="\\$" end="$" contains=tclTodo,@Spell
syn region  tclComment  start=/;\s*\#/hs=s+1 skip="\\$" end="$" contains=tclTodo,@Spell

" Highlight variable names after set, incr, etc.
highlight default link tclVarSet Identifier
syn match tclVarSet /\<\(\(\(un\)\?set\)\s\+\)\@<=\w\+/
syn match tclVarSet /\<\(incr\s\+\)\@<=\w\+/
syn match tclVarSet /\<\(variable\s\+\)\@<=\w\+/
syn match tclVarSet /\<\(global\s\+\)\@<=.*/

" NOT USING Tk!
highlight link tcltkArraySwitch NONE
highlight link tcltkCommandColor NONE
highlight link tcltkCommand NONE
highlight link tcltkLsortSwitch NONE
highlight link tcltkMaths NONE
highlight link tcltkNamespaceSwitch NONE
highlight link tcltkPackConfColor NONE
highlight link tcltkPackConf NONE
highlight link tcltkPackConfSwitch NONE
highlight link tcltkPackSwitch NONE
highlight link tcltkStringSwitch NONE
highlight link tcltkWidgetColor NONE
highlight link tcltkWidget NONE
highlight link tcltkWidgetSwitch NONE

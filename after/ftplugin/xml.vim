" Start and end tags should be the same highlighting in my mind...
" EndTag is already an Identifier so we just make them agree.
highlight link xmlTag     Identifier
highlight link xmlTagName Identifier

" As for HTML, smaller tabs are better and guarantee no wrapping
setlocal shiftwidth=2
setlocal tabstop=2
setlocal textwidth=0

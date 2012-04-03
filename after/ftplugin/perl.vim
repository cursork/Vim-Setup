" Make sure all symbols are parts of keywords in perl
setlocal iskeyword+=_,$,@,%,#

" Spell-check comments
syn match perlComment "#.*" contains=perlTodo,@Spell

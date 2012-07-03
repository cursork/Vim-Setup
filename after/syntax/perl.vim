" Spell-check comments
syn match perlComment "#.*" contains=perlTodo,@Spell

unlet b:current_syntax
syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start=:<<\(['"]\?\)SQL\1\s*;\s*$: end=:^\s*SQL$: contains=@SQL

unlet b:current_syntax
syntax include @XML syntax/xml.vim
syntax region xmlSnip matchgroup=Snip start=:<<\(['"]\?\)XML\1\s*;\s*$: end=:^\s*XML$: contains=@XML

unlet b:current_syntax
syntax include @HTML syntax/html.vim
syntax region htmlSnip matchgroup=Snip start=:<<\(['"]\?\)HTML\1\s*;\s*$: end=:^\s*HTML$: contains=@HTML

hi link Snip SpecialComment

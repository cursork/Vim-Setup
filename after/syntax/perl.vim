" Spell-check comments and ignore $#_ type array counts
syntax clear perlComment
syntax match perlComment "^#.*" contains=perlTodo,@Spell
syntax match perlComment "[^\$]#.*" contains=perlTodo,@Spell
" The above is wiping out sensible highlighting on 'm# ... #', etc. and I
" should resolve it in a better way but never mind - this is just copied from
" the normal syntax/perl.vim:
syntax region perlMatch matchgroup=perlMatchStartEnd  start=+\<\%(::\|'\|->\)\@<!m#+          end=+#[cgimopsx]*+ contains=@perlInterpMatch keepend
syntax region perlMatch matchgroup=perlMatchStartEnd  start=+\<\%(::\|'\|->\)\@<!s#+          end=+#+me=e-1      contains=@perlInterpMatch nextgroup=perlSubstitutionGQQ keepend
syntax region perlMatch matchgroup=perlMatchStartEnd  start=+\<\%(::\|'\|->\)\@<!\%(tr\|y\)#+ end=+#+me=e-1      contains=@perlInterpSQ    nextgroup=perlTranslationGQ
syntax region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!q#+          end=+#+            contains=@perlInterpSQ    keepend
syntax region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!q[qx]#+      end=+#+            contains=@perlInterpDQ    keepend
syntax region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw#+         end=+#+            contains=@perlInterpSQ    keepend
syntax region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!qr#+         end=+#[imosx]*+    contains=@perlInterpMatch keepend

" Add state to keywords
syntax keyword perlStatementStorage my local our state

" Moose and Method::Signatures
syntax match perlFunction "\<\(method\|func\|has\|extends\)\>"

unlet b:current_syntax
syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start=:<<\(['"]\?\)SQL\1: end=:^\s*SQL$: contains=@SQL

unlet b:current_syntax
syntax include @XML syntax/xml.vim
syntax region xmlSnip matchgroup=Snip start=:<<\(['"]\?\)XML\1: end=:^\s*XML$: contains=@XML

unlet b:current_syntax
syntax include @HTML syntax/html.vim
syntax region htmlSnip matchgroup=Snip start=:<<\(['"]\?\)HTML\1: end=:^\s*HTML$: contains=@HTML

unlet b:current_syntax
syntax include @JAVASCRIPT syntax/javascript.vim
syntax region jsonSnip       matchgroup=Snip start=:<<\(['"]\?\)JSON\1: end=:^\s*JSON$:             contains=@JAVASCRIPT
syntax region javascriptSnip matchgroup=Snip start=:<<\(['"]\?\)JAVASCRIPT\1: end=:^\s*JAVASCRIPT$: contains=@JAVASCRIPT

hi link Snip SpecialComment

" Prevent it being set to 'toplevel' and spell-checking 'Normal' text
syntax spell default

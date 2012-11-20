" Spell-check comments and ignore $#_ type array counts
syntax clear perlComment
syntax match perlComment "^#.*" contains=perlTodo,@Spell
syntax match perlComment "[^\$]#.*" contains=perlTodo,@Spell
" The above is wiping out sensible highlighting on 'm# ... #', etc. and I
" should resolve it in a better way but never mind - this is just copied from
" the normal syntax/perl.vim:
syn region perlMatch matchgroup=perlMatchStartEnd  start=+\<\%(::\|'\|->\)\@<!m#+          end=+#[cgimopsx]*+ contains=@perlInterpMatch keepend
syn region perlMatch matchgroup=perlMatchStartEnd  start=+\<\%(::\|'\|->\)\@<!s#+          end=+#+me=e-1      contains=@perlInterpMatch nextgroup=perlSubstitutionGQQ keepend
syn region perlMatch matchgroup=perlMatchStartEnd  start=+\<\%(::\|'\|->\)\@<!\%(tr\|y\)#+ end=+#+me=e-1      contains=@perlInterpSQ    nextgroup=perlTranslationGQ
syn region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!q#+          end=+#+            contains=@perlInterpSQ    keepend
syn region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!q[qx]#+      end=+#+            contains=@perlInterpDQ    keepend
syn region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!qw#+         end=+#+            contains=@perlInterpSQ    keepend
syn region perlQQ    matchgroup=perlStringStartEnd start=+\<\%(::\|'\|->\)\@<!qr#+         end=+#[imosx]*+    contains=@perlInterpMatch keepend

unlet b:current_syntax
syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start=:<<\(['"]\?\)SQL\1\s*;\s*$: end=:^\s*SQL$: contains=@SQL

unlet b:current_syntax
syntax include @XML syntax/xml.vim
syntax region xmlSnip matchgroup=Snip start=:<<\(['"]\?\)XML\1\s*;\s*$: end=:^\s*XML$: contains=@XML

unlet b:current_syntax
syntax include @HTML syntax/html.vim
syntax region htmlSnip matchgroup=Snip start=:<<\(['"]\?\)HTML\1\s*;\s*$: end=:^\s*HTML$: contains=@HTML

unlet b:current_syntax
syntax include @JAVASCRIPT syntax/javascript.vim
syntax region jsonSnip       matchgroup=Snip start=:<<\(['"]\?\)JSON\1\s*;\s*$: end=:^\s*JSON$:             contains=@JAVASCRIPT
syntax region javascriptSnip matchgroup=Snip start=:<<\(['"]\?\)JAVASCRIPT\1\s*;\s*$: end=:^\s*JAVASCRIPT$: contains=@JAVASCRIPT

hi link Snip SpecialComment

" Prevent it being set to 'toplevel' and spell-checking 'Normal' text
syntax spell default

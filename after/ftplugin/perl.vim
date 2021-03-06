" Make sure all symbols are parts of keywords in perl
" In my own ref-filled world, this works nicely. Not so much when sigils
" change...
setlocal iskeyword+=_,$,@,%,#,:

" Do NOT recursively scan Perl lib directories
" i is meant to indicate 'included' files
" <C-X><C-I> can be used to do this manually
setlocal complete-=i

" Use perldoc when 'K' is used to lookup a keyword
setlocal keywordprg=perldoc

" Generally I want to be based in the root of a project and look in 'lib' for
" files to 'gf' to
silent! execute 'Rooter'
let &l:path.=substitute($PERL5LIB,':',',','g')
let &l:path.=',lib'
let $PERL5LIB.=':lib'
setlocal suffixesadd=.pm,.pl
setlocal includeexpr=substitute(v:fname,'::','/','g')
" Without this you have to put the cursor inside the last word in Package::Name
" I don't *think* it will have much chance of a deleterious effect
setlocal isfname+=:

" This is defined in .vimrc. N.B. there will be issues if you edit Clojure and
" Perl in the same session (unlikely I hope); they both use this mapping.
nnoremap <Leader>ef :call NKRunPerlInNewWindow()<CR>

" Allow 'gf' to work
setlocal suffixesadd=.pm
setlocal isfname+=:
setlocal includeexpr=substitute(v:fname,'::','/','g')

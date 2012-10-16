" Make sure all symbols are parts of keywords in perl
" In my own ref-filled world, this works nicely. Not so much when sigils
" change...
setlocal iskeyword+=_,$,@,%,#,:

" Do NOT recursively scan Perl lib directories
" i is meant to indicate 'included' files
" <C-X><C-I> can be used to do this manually
setlocal complete-=i

" Use perldoc when 'K' is used to lookup a keyword
set keywordprg=perldoc

nnoremap <Leader>ef :call NKRunPerlInNewWindow()<CR>

silent! execute 'Rooter'

" TODO auto-completion would be ah-maaazing!
" TODO uses src/ for now - need something better - what if you have src/clj/ +
"      src/cljs/ - easy solution is look for src/clj then src/
" TODO handle cljs
" Requires classpath.vim
if !exists('*EditNamespace')
    function EditNamespace(ns) abort
        let path  = tr(a:ns, '.-', '/_') . '.clj'
        let cps   = split(classpath#detect(), ',')
        let to_match = '/src/clj$'
        let found = filter(copy(cps), 'v:val =~# to_match')
        if empty(found)
            let to_match = '/src$'
            let found = filter(copy(cps), 'v:val =~# to_match')
        endif
        if !empty(found)
            let filepath  = found[0] . '/' . path
            let directory = fnamemodify(filepath, ':h')
            if !isdirectory(directory)
                execute '!mkdir -p ' . directory
            endif
            execute 'tabnew ' . filepath
        endif
    endfunction
endif
command! -nargs=1 NS call EditNamespace('<args>')

" Quick and dirty compile NS
nnoremap <F13> :Require<CR>
nnoremap <F14> :normal cpp<CR>
nnoremap <F15> :normal cpaF<CR>
nnoremap <F16> :normal cpr<CR>

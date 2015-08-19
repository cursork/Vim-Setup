" Ignore typical 'build' directories
let g:ctrlp_custom_ignore = {
            \ 'dir' : 'out\|target\|repl'
            \ }
" Use project.clj before .git, etc.
let g:ctrlp_root_markers = ['project.clj']

" Markdown requires spaces!
setlocal expandtab
setlocal textwidth=79

" Focus on only current thing.
" WARNING! This applies globally.
" highlight Normal     guifg=#888888
" highlight CursorLine guifg=#000000
" highlight StatusLine guifg=#000000

" Doesn't need to be done each time a markdown file is open, but it does no harm...
let g:ttoc_rx_markdown="^#.*"

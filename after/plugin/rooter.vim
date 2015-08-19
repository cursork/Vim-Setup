" Rooter roots at lein project.clj before .git (for repos with >1 project
" inside and when I haven't yet run git init)
let g:rooter_patterns = ['project.clj'] + g:rooter_patterns

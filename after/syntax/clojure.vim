" Bit of a hackish way to conceal type annotations
syntax match clojureTypeHint /\^[A-z]\+/ conceal cchar=^
hi link clojureTypeHint Conceal

silent! RainbowParenthesesActivate
silent! RainbowParenthesesLoadRound
silent! RainbowParenthesesLoadSquare
silent! RainbowParenthesesLoadBraces


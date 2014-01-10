" Bit of a hackish way to conceal type annotations
syntax match clojureTypeHint /\^[A-z][A-z_.0-9]\+/ conceal cchar=^
hi link clojureTypeHint Conceal

silent! RainbowParenthesesActivate
silent! RainbowParenthesesLoadRound
silent! RainbowParenthesesLoadSquare
silent! RainbowParenthesesLoadBraces


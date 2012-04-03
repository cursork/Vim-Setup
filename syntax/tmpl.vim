" Templates...

" We will need XML and Perl highlighting
syntax include @Xml  syntax/xml.vim
syntax include @Perl syntax/perl.vim

" By default end at new line
syntax region tmplBody start=/^body: \?/ end=/$/ contains=tmplBodyContinue,tmplVariable,@Xml
" However, also allow region to continue if another 'body: ' is found
syntax match  tmplBodyContinue "\$body: " contained

" Same for Perl helpers
syntax region tmplHelper start=/^helper: \?/ end=/$/ contains=tmplHelperContinue,@Perl
syntax match  tmplHelperContinue "\$helper:" contained

" Variables are all over the place
syntax match tmplVariable /%[^%]\+%/
highlight link tmplVariable Identifier

" Single line comments
syntax region tmplComment start=/^#/ end=/$/
highlight link tmplComment Comment

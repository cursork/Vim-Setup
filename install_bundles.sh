#!/usr/bin/env sh

cd bundle
if [[ $? -eq 1 ]]; then
	echo No bundle directory found
	exit 1
fi

echo In bundle directory

echo Cloning vim-javascript...
git clone https://github.com/pangloss/vim-javascript.git

echo Cloning Tagbar...
git clone https://github.com/majutsushi/tagbar.git

echo Cloning Dokuwiki...
git clone https://github.com/nblock/vim-dokuwiki.git

echo Cloning OpenBrowser...
git clone https://github.com/tyru/open-browser.vim

echo Cloning ActionScript syntax...
git clone https://github.com/vim-scripts/actionscript.vim--Leider.git

echo Cloning Elixir...
git clone https://github.com/elixir-lang/vim-elixir.git

echo Cloning NERDTreeTabs
git clone https://github.com/jistr/vim-nerdtree-tabs.git

echo Cloning VimClojure...
git clone https://github.com/vim-scripts/VimClojure.git

echo Cloning zoom.vim...
git clone https://github.com/vim-scripts/zoom.vim.git

echo Cloning Vim Erlang...
git clone https://github.com/oscarh/vimerl.git

echo Cloning Perl Omni...
git clone https://github.com/c9s/perlomni.vim.git

echo Cloning Gundo...
git clone http://github.com/sjl/gundo.vim.git

echo Cloning Rooter...
git clone https://github.com/airblade/vim-rooter.git

echo Cloning Unicode Completion...
git clone https://github.com/chrisbra/unicode.vim.git

echo Cloning F# Runtime...
git clone https://github.com/kongo2002/fsharp-vim.git

echo Cloning Indent Text Objects...
git clone https://github.com/michaeljsmith/vim-indent-object.git

echo Cloning Column Text Objects...
git clone https://github.com/coderifous/textobj-word-column.vim.git

echo Cloning Fugitive \(Git\)...
git clone https://github.com/tpope/vim-fugitive.git

echo Cloning Ack...
git clone https://github.com/mileszs/ack.vim.git

echo Done.

#!/usr/bin/sh

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

echo Done.

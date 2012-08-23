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

echo Cloning Elixir
git clone https://github.com/elixir-lang/vim-elixir.git

echo Cloning improved xml.vim
git clone https://github.com/othree/xml.vim

echo Done.

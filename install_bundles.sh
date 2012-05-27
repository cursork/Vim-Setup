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

echo Done.

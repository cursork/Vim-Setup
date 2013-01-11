#!/usr/bin/env sh

if [ -d bundle ]; then
	cd bundle
	echo In bundle directory
else
	echo No bundle directory found
	exit 1
fi


for bundle in `ls`; do
	echo Updating $bundle...
	cd $bundle
	if [ -d .git ]; then
		git pull origin
	else
		echo No .git folder found. Skipped $bundle.
	fi
	cd ..
done

echo Done.

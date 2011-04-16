#!/bin/sh
if [ -z "$1" ]; then
	echo "usage: fastpack script.pl > script.packed.pl"
	exit 0
fi

fatpack trace "$1"
fatpack packlists-for `cat fatpacker.trace` > fatpacker.packlists
fatpack tree `cat fatpacker.packlists`
[ -d lib ] || mkdir lib

echo "#!/usr/bin/env perl"
echo
fatpack file
cat "$1"

rm fatpacker.trace
rm fatpacker.packlists 
rm -rf fatlib

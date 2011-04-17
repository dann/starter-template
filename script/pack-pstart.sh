#!/bin/bash
SCRIPT=script/starter.pl
script/update-fatlib.pl
fatpack trace "$SCRIPT"
fatpack packlists-for `cat fatpacker.trace` > fatpacker.packlists
fatpack tree `cat fatpacker.packlists`
[ -d lib ] || mkdir lib
(echo "#!/usr/bin/env perl";echo;fatpack file;cat "$SCRIPT") > starter
chmod +x starter
rm fatpacker.trace
rm fatpacker.packlists 

echo "============================="
echo " Generated starter!          "
echo " Rename starter if you need  "
echo "============================="

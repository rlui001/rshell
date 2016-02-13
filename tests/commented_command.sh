#!/bin/sh

#This shell script tests commands with commented text.

echo "Testing commands with #s...(Press \"Enter\" to continue): "
read answer

./a.out << EOF
ls #-a
date; ls #-a
ls#; date
date#&& echo ERROR
date#; ls#
mkdir commentFolder; ls#; rmdir commentFolder; echo ERROR bye folder
mkdir comment#Error
EOF

rmdir commentFolder
rmdir comment


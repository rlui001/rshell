#!/bin/sh

#This shell script tests commands with commented text.

echo "Testing commands with #s...(Press \"Enter\" to continue): "
read answer

bin/rshell << EOF
ls #-a
date; ls #-a
ls#; date
date#&& echo ERROR
date#; ls#
mkdir commentFolder; ls#; rmdir commentFolder; echo ERROR bye folder
mkdir comment#Error
exit
EOF

rmdir commentFolder
rmdir comment

#NEW SECTION FOR COMMENTED_COMMAND_SH
echo "New test commands with #s...(Press \"Enter\" to continue): "
read answer

bin/rshell << EOF
test -e /bin#/error.cpp
[ -e /bin ]# && echo ERROR
(test -f /bin/rshell)#&&(test -f /bin/error.cpp)
date#; test -e /bin#/error.cpp
(echo A #&& echo B) && (echo C #&& echo D)
(echo A && echo B #&& echo C)
test -e /bin; test /bin#; test /error
exit
EOF

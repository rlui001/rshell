#!/bin/sh

echo "Testing the test command...(Press \"Enter\" to continue..."
read answer

bin/rshell <<EOF
echo "Testing with 'test' argument"
test /bin
test /rshell
test /bin/rshell
test /bin/error
test -e /bin
test -e /bin/rshell
test -e /error
test -e /bin/error.cpp
test -f /bin
test -f /bin/rshell
test -f /error/rshell
test -d /bin
test -d /bin/rshell

echo "Testing symbolic version"
[ /bin ]
[ /rshell ]
[ /bin/rshell ]
[ /bin/error ]
[ -e /bin ]
[ -e /bin/rshell ]
[ -e /error ]
[ -e /bin/error.cpp ]
[ -f /bin ]
[ -f /bin/rshell ]
[ -f /error/rshell ]
[ -d /bin ]
[ -d /error ]
[ -d /bin/rshell ]
exit
EOF

echo "Testing test command with multiple commands using connectors...(Press \"Enter\" to continue..."
read answer

bin/rshell <<EOF
echo "Only 12 echo messages indicating success should appear"
test /bin || echo "This should not echo! Failed OR"
test /error || echo "Echo worked! OR"
test /error && echo "This should not echo! Failed AND"
test /bin && echo "Echo worked! AND"
test /error; echo "Echo worked! Semicolon"

test -e /bin || echo "This should not echo! Failed OR with -e"
test -e /error || echo "Echo worked! OR -e"
test -e /error && echo "This should not echo! Failed AND with -e"
test -e /bin && echo "Echo worked! AND -e"
test -e /error; echo "Echo worked! Semicolon with -e"

test -f /bin/rshell || echo "This should not echo! Failed OR with -f"
test -f /bin || echo "Echo worked! OR -f"
test -f /bin && echo "This should not echo! Failed AND with -f"
test -f /bin/rshell && echo "Echo worked! AND -f"
test -f /error; echo "Echo worked! Semicolon with -f"

test -d /bin || echo "This should not echo! Failed OR with -d"
test -d /bin/rshell || echo "Echo worked! OR -d"
test -d /bin/rshell && echo "This should not echo! Failed AND with -d"
test -d /bin && echo "Echo worked! AND -d"
test -d /error; echo "Echo worked! Semicolon with -d"
exit
EOF

echo "Testing symbolic test cmd with multiple cmds using connects...(Press \"Enter\" to continue..."
read answer

bin /rshell <<EOF
echo "Only 12 echo messages indicating success should appear"
[ /bin ] || echo "This should not echo! Failed OR"
[ /error ] || echo "Echo worked!"
[ /error ] && echo "This should not echo! Failed AND"
[ /bin ] && echo "Echo worked!"
[ /error ]; echo "Echo worked!"

[ -e /bin ] || echo "This should not echo! Failed OR with -e"
[ -e /error ] || echo "Echo worked! OR -e"
[ -e /error ] && echo "This should not echo! Failed AND with -e"
[ -e /bin ] && echo "Echo worked! AND -e"
[ -e /error ]; echo "Echo worked! Semicolon with -e"

[ -f /bin/rshell ] || echo "This should not echo! Failed OR with -f"
[ -f /bin ] || echo "Echo worked! OR -f"
[ -f /bin ] && echo "This should not echo! Failed AND with -f"
[ -f /bin/rshell ] && echo "Echo worked! AND -f"
[ -f ]; echo "Echo worked! Semicolon with -f"

[ -d /bin ] || echo "This should not echo! Failed OR with -d"
[ -d /bin/rshell ] || echo "Echo worked! OR -d"
[ -d /bin/rshell ] && echo "This should not echo! Failed AND with -d"
[ -d /bin ] && echo "Echo worked! AND -d"
[ -d ]; echo "Echo worked! Semicolon with -d"
exit
EOF


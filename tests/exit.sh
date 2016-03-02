#!/bin/sh

# This shell script tests the exit command, combined with multiple arguments.

echo "Testing exit with/without arguments:(Press enter to continue): "
read answer
bin/rshell << EOF
echo "Testing 'exit' by itself."
exit
EOF
echo "============================================================="

echo "Press enter to continue..."
read answer
bin/rshell << EOF
echo "Testing 'exit' with 'exit' as follow-up argument."
exit exit
EOF
echo "============================================================="

#UPDATED EXIT_SH TESTS
echo "Testing exit with the new implementation of test. Press enter."
read answer
bin/rshell << EOF
test -e /bin
exit
EOF
echo "============================================================="

echo "Testing exit with the new implementation for precedence. Press enter."
read answer
bin/rshell << EOF
(test -e /bin)
exit
EOF
echo "============================================================="

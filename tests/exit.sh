#!/bin/sh

# Thi shell script tests the exit command, combined with multiple arguments.

echo "Testing exit with/without arguments:(Press enter to continue): "
read answer
./a.out << EOF
echo "Testing 'exit' by itself."
exit
EOF
echo "============================================================="

echo "Press enter to continue..."
read answer
./a.out << EOF
echo "Testing 'exit' with 'exit' as follow-up argument."
exit exit
EOF
echo "============================================================="

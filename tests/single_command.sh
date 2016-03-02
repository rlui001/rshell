#!/bin/sh


#This shell script tests single commands AND the case where a command does not exist.

echo "Testing command 'ls'(Press enter to continue): "
read answer

bin/rshell << EOF
ls
ls -l
ls -a
ls -a -l
ls --version
exit
EOF

echo ""
echo "============================================================"
echo "Testing command 'date'(Press enter to continue): "
read answer

bin/rshell << EOF
date
exit
EOF

echo ""
echo "============================================================"
echo "Testing command 'echo'(Press enter to continue): "
read answer

bin/rshell << EOF
echo "Let's see if this works!"
echo "If you see the first echo, then this works!"
echo "Exiting program now, to run a different command!"
exit
EOF

echo ""
echo "============================================================="
echo "Testing command 'mkdir'(Press enter to continue): "
read answer

bin/rshell << EOF
mkdir disAfolder
echo "Let's see if the folder was created successfully..."
ls
echo "Now let's remove the folder..."
rmdir disAfolder
echo "Also notice how the 'exit' command has been working."
exit
EOF

echo ""
echo "============================================================="
echo "Testing multiple commands in one sitting(Press enter to continue): "
read answer

bin/rshell << EOF
echo "Example taken from assignment specifications:"
ls -a
echo hello
mkdir testfolder
ls
rmdir testfolder
echo "Test case for non-input command:"
hello
echo "Exiting..."
exit
EOF
echo ""
echo "============================================================="
echo "Testing command with many arguments:(Press enter to continue): "
read answer

bin/rshell << EOF
ls -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a -a 
ls -a -a -a 
ls -a -a 
ls -a
echo "Testing 'ls' with comment: "
ls # --version
echo "If the version did not display, comment worked."
exit
EOF


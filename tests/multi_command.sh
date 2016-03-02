#!/bin/sh

#This shell script tests multiple commands in each cmdline.

echo "Testing operators singularly...(Press \"Enter\" to continue): "
read answer

bin/rshell << EOF
echo "Testing condition of OR..."
lss || echo OR condition succeeded. 2nd cmd only executes if first cmd failed.
echo If error shows, OR failed || echo ERROR: OR failed.
echo "============================="
echo "Testing condition of AND..."
lss && echo AND failed. 2nd cmd only executes if first cmd succeeded.
echo Testing And... && echo And succeeded.
echo "============================="
echo "Testing semicolon"
echo "A message will follow."; echo "This is the message. Succeeded."
exit
EOF

echo "Upcoming tests check for multiple operators functionality."
echo "!or/!and = 2nd cmd should not have run. Thus error if it does."
echo "(Press \"Enter\" to continue): "
read answer

bin/rshell << EOF
echo "semi->semi"; echo "OK"; echo "OK"
echo "!or->!or"; echo "OK" || echo "ERR" || echo "ERR"
echo "or->or"; lss || lss || echo "OK"
echo "and->and" && echo "OK" && echo "OK"
echo "and->!and"; echo "OK" && lss && echo "ERR"
echo "semi->!or"; echo "OK" || echo "ERR"
echo "semi->or"; echo "OK"; lss || echo "OK"
echo "semi->and"; echo "OK" && echo "OK"
echo "semi->!and"; echo "OK"; lss && echo "ERR"
echo "!or->semi" || echo "ERR"; echo "OK"
echo "!and->semi"; lss && echo "ERR"; echo "OK"
echo "or->!or->and"; echo "OK" || echo "ERR" || echo "ERR" && echo "OK"
echo "and->!and->or"; echo "OK" && lss && echo "ERR" || echo "OK"
exit
EOF

echo "Large command line test...(Press \"Enter\" to continue): "
read answer

bin/rshell << EOF
echo "TEST INC"; echo "OK" && echo "OK"; lss || echo "OK" && echo "OK"; echo "DONE"
echo "TEST2 INC" && echo "OK"; lss || echo "OK" || echo "OR ERR"; echo "OK"
exit
EOF





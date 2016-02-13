#!/bin/sh

#This shell script tests multiple commands in each cmdline.

echo "Testing operators singularly...(Press \"Enter\" to continue): "
read answer

./a.out << EOF
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

./a.out << EOF
echo "semi->semi"; echo "OK"; echo "OK"
echo "or->or"; lss || echo "OK"; lss || echo "OK";
echo "!or->!or" || echo "ERR: OR failed" || echo "ERR: Did not terminate."
echo "and->and" && echo "OK" && echo "OK"
echo "and->!and" && echo "OK"; lss && : echo "ERR: AND failed"
echo "semi->!or"; echo "OK" || echo "ERR: OR failed"
echo "semi->or"; echo "OK"; lss || echo "OK"
echo "semi->and"; echo "OK" && echo "OK"
echo "semi->!and"; echo "OK"; lss && echo "ERR: AND failed"
echo "!or->semi" || echo "ERR: OR failed"; echo "ERR: Did not terminate."
echo "!and->semi"; lss && echo "ERR: And failed"; echo "ERR: Did not terminate."
exit
EOF

echo "Large command line test...(Press \"Enter\" to continue): "
read answer

./a.out << EOF
echo "TEST INC"; echo "OK" && echo "OK"; lss || echo "OK" && echo "OK"; echo "DONE"
echo "TEST2 INC" && echo "OK"; lss || echo "OK" || echo "OR ERR"; echo "TERM ERR"
exit
EOF





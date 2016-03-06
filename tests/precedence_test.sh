#!/bin/sh

echo "TESTING PRECEDENCE OPERATIONS...Press Enter to Continue..."
read answer

bin/rshell <<EOF
(echo 1. complete)
(echo 2. complete || echo ERR)
(echo 3. OK && echo complete)

(echo 4. complete) || (echo ERR)
(echo 5. OK; echo complete) || (echo ERR)
(echo 6. OK && echo complete) || (echo ERR)
(echo 7. OK || echo complete) || (echo ERR)
(lss) || (echo 8. complete)
(lss && ls) || (echo 9. ERR)
(lss || ls) || (echo 10. ERR)
(lss; ls) || (echo 11. ERR)

(echo 12. OK) && (echo complete)
(echo 13. OK; echo good) && (echo complete)
(echo 14. OK || echo ERR) && (echo complete)
(echo 15. OK && echo good) && (echo complete)
(lss) && (echo 16. ERR)
(lss && ls) && (echo 17. ERR)
(lss || ls) && (echo 18. complete)
(lss; ls) && (echo 19. complete)

(echo 20. OK) || (echo ERR: OR) && (echo complete)
(echo 21. OK) && (echo complete) || (echo ERR)
(echo 22. complete) || (echo ERR: OR) || (echo ERR: OR)
(echo 23. OK) && (echo good) && (echo complete)

echo "Testing mix of non precedence and precedence"
echo 24. OK && (echo complete)
echo 25. complete || (echo ERR)
(echo 26. OK) && echo complete
(echo 27. complete) || echo ERR
echo 28. OK && (echo good) && echo complete
echo 29. OK && (lss) || echo complete
echo 30. OK && (lss || echo complete) || echo ERR

echo 31. complete || (echo ERR) || echo ERR
echo 32. good || (lss || echo ERR) && echo complete
lss || (echo 33. OK) && echo complete
lss || (echo 33. OK || echo ERR) || echo ERR

echo "Testing precedence within precedence"
((echo 34. OK || echo ERR) || echo ERR)
((lss && ls) || echo 35. complete)
((echo 36. OK || echo ERR) && echo OK)
((lss || ls) && echo 37. complete)

echo "Remaining tests"
(echo 38. OK);(echo complete)
(echo 39. OK || echo ERR);(echo complete)
(echo 40. OK && echo good);(echo complete)
(lss || ls);(echo 41. complete)

exit
EOF


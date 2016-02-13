CC = g++
CC_FLAGS = -W -Wall -Werror -ansi -pedantic

all: rshell

rshell:
	([ ! -d bin ] && mkdir bin) || [ -d bin ]
	$(CC) $(CC_FLAGS) src/main.cpp -o bin/rshell

clean:
	rm -rf bin

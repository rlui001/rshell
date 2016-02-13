Rshell
========

Synopsis
--------
This project is an attempt on recreating the basic command shell with C++ implementation. The program implemented in this library works by having a command prompt provided with the current user and hostname instead of just a simple '$' to imitate most SSHs. The programmed shell in this library will be able to execute single commands with optional arguments, along with the functionality of executing multiple commands using connectors (e.g ls -a && cd rshell).

## Contributors

* Michael Tran (https://github.com/mtran049)
* Ronson Lui (https://github.com/rlui001)

## Known Bugs

* The command "exit" does not always work.
* Out of Range errors sometimes occurs, but should not inhibit the shell's function.
* Entering input after initial input sometimes results in repeated command executions.



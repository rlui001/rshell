#ifndef SHELL_H
#define SHELL_H

using namespace std;

class Shell {
    public:

    // This function prompts user for input.
        void cmdPrompt();

    // This function executes the command line, returns 1 if successful.
        bool runCmd();

    // This function exits the shell program.
        void exitShell();


};











#endif

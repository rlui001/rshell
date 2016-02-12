#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <vector>
#include <sys/wait.h>
#include <errno.h>
#include <iostream>

using namespace std;

#define BUFFER_LEN 1024

int main() {
    char line[BUFFER_LEN];
    char* argv[100];
    char* path = "/bin/";
    char progpath[20];
    int argc;
    
    cout << "Rshell initialized...\n";
    string username = getlogin();
    char hostname[128] = "";
    gethostname(hostname, sizeof(hostname));




    while(1) {
        
            cout << "[" << username << "@" << hostname << "]" << "$ ";
            if(!fgets(line, BUFFER_LEN, stdin)) {
                break;
            }

            size_t length = strlen(line);
            if (line[length - 1] == '\n') { 
                line[length - 1] = '\0';
            }
            if(strcmp(line, "exit")==0) {
                break;
            }

            char* token;
            token = strtok(line, " ");
            int i=0;
            while (token != NULL) {
                argv[i] = token;
                token = strtok (NULL, " ");
                ++i;
            }
            argv[i] = NULL;

            argc = i;
            for (i = 0; i < argc; ++i) {
                printf("%s\n" , argv[i]);
            }

            strcpy(progpath, path);
            strcat(progpath, argv[0]);

            for (i = 0; i <strlen(progpath); ++i) {
                if (progpath[i] == '\n') {
                    progpath[i] = '\0';
                }
            }
            int pid = fork();

            if (pid == 0) {
                execvp(progpath, argv);
               // fprintf (stderr, "Child process could not do execvp\n");
                cout << "-bash: " << *argv << ": command not found" << endl; 

            }
            else {
                wait(NULL);
                printf("Child exited\n");
            }
    }


    return 0;


}

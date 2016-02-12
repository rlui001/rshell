#include <iostream>
#include <vector>
#include <string>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>



using namespace std;


int main()
{

    cout << "Rshell initialized...\n";
    string username = getlogin();
    char hostname[128] = "";
    gethostname(hostname, sizeof(hostname));
 
    cout << "[" << username << "@" << hostname << "]" << "$ ";
    
    string userinput;
    getline(cin, userinput); //Temporary method 
    
    while (userinput != "exit") //Temporary method
    {
        cout << "[" << username << "@" << hostname << "]" << "$ ";
        
        // Parse word by word; userinput stores whole line of input.
        char* cstr = new char [userinput.size() + 1];
        strcpy(cstr, userinput.c_str());
        char* token;
        token = strtok(cstr, " ");
        while (token != NULL) {
            cout << token << endl;
            token = strtok(NULL, " ");
        }


        // getline takes place at end of all operations.
        getline(cin, userinput);

    }
   



    return 0;
}

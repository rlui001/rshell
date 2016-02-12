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
	cout << "Rshell initialized...\n\n";

	// Grabs username.
	char *username = getlogin();
	if (getlogin() == NULL)
	{
		perror("getlogin() failed");
	}

	// Grabs user's hostname/machine.
	char hostname[128] = "";
	if (gethostname(hostname, sizeof(hostname)) == -1)
	{
		perror("gethostname() failed");
	}

	while (1)
	{
		// Command prompt. '~' to distinguish from SSH bash.
		cout << "~[" << username << "@" << hostname << "]" << "$ ";
	
		string userinput;
		getline(cin, userinput);

		// Discards any input after a '#' character if found.
		int commentLoc = userinput.find('#');
		if (commentLoc != string::npos)
			userinput = userinput.substr(0, commentLoc - 1);
		
		// Record order of operators.
		//int andLoc = userinput.find("||");
		//int orLoc = userinput.find(
		//int semiLoc = userinput.find(';');
		
		char delim[] = ";|&";
		char *token, *subtoken;
		char *saveptr1, *saveptr2;

		char *str1 = new char[userinput.size() + 1];
		strcpy(str1, userinput.c_str());
		token = strtok_r(str1, delim, &saveptr1);
		
		// Iterates through every seperate command in a cmd line.
		while (token != NULL)
		{
			char space[] = " ";
			subtoken = strtok_r(token, space, &saveptr2);

			// Splits a command into arguments and places them in a vector.
			vector<string> args;
			while (subtoken != NULL)
			{
				args.push_back(subtoken);
				cout << "Subtoken: " << subtoken << endl;
				subtoken = strtok_r(NULL, space, &saveptr2);
			}

			char **argv = new char*[args.size() + 1];

			for (unsigned int i = 0; i < args.size(); ++i)
			{
				argv[i] = new char[args.at(i).size() + 1];
				strcpy(argv[i], args.at(i).c_str());
			}
			

			// Execution of command line using fork calls.
			int pid = fork();
			int status = 0;

			if (pid == -1)
			{
				perror("fork failed");
				exit(1);
			}
			else if (pid == 0)
			{
				if (execvp(*argv, argv) == -1)
				{
					perror("execvp failed");
					exit(1);
				}

			}
			else
			{
				if (wait(&status) == -1)
				{
					perror("waited too long");
				}

				token = strtok_r(NULL, delim, &saveptr1);
			}

		}


		if (userinput == "exit")	//Temporary
			break;
	}

	return 0;
}

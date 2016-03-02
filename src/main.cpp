#include <iostream>
#include <vector>
#include <string>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/stat.h>
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
	if (commentLoc != -1)
	    userinput = userinput.substr(0, commentLoc - 1);

	// Token loop that sets up vector..
	char lim[] = " ";
	char *contoken;
	char *savetok;
	vector<int> split;
	int counter = 0;
	int concount = 0;

	char *tempstr = new char[userinput.size() + 1];
	strcpy(tempstr, userinput.c_str());
	contoken = strtok_r(tempstr, lim, &savetok);

	while (contoken != NULL)
	{
	    if (strcmp(contoken, "&&") == 0) 
	    {
		split.push_back(1);
		contoken = strtok_r(NULL, lim, &savetok);
	    }

	    else if (strcmp(contoken, "||") == 0) 
	    {
		split.push_back(2);
		contoken = strtok_r(NULL, lim, &savetok);
	    }
	    else if (strcmp(contoken, ";") == 0) 
	    {
		split.push_back(3);
		contoken = strtok_r(NULL, lim, &savetok);
	    }
	    else 
	    {
		split.push_back(0);
		contoken = strtok_r(NULL, lim, &savetok);
	    }
	}

	split.push_back(-1); // -1 indicates end of line

	char delim[] = ";|&";
	char *token, *subtoken;
	char *saveptr1, *saveptr2;

	char *str1 = new char[userinput.size() + 1];
	strcpy(str1, userinput.c_str());
	token = strtok_r(str1, delim, &saveptr1);

	// Iterates through every seperate command in a cmd line.
	while (token != NULL)
	{
	    //bool currState = true;
	    char space[] = " ";
	    subtoken = strtok_r(token, space, &saveptr2);

	    // Splits a command into arguments and places them in a vector.
	    vector<string> args;
	    while (subtoken != NULL)
	    {
		args.push_back(subtoken);
		//cout << "Subtoken: " << subtoken << endl;
		subtoken = strtok_r(NULL, space, &saveptr2);
	    }

	    char **argv = new char*[args.size() + 1];
	    for (unsigned int i = 0; i < args.size(); ++i)
	    {
                if (args.at(i) == "exit")
                {
                    exit(1);
                }
               if (split.at(concount) == 2)
		    {   
		    
		        // || not satisfied, skips command
		        while (split.at(concount) == 0) 
		        {
			    ++concount;
                        }
                        strtok_r(NULL, delim, &saveptr1);
		    }	

		    else if (split.at(concount) == 1) 
	    	    {   
		        // && satisfied, doesn't skip command
		        strtok_r(NULL, delim, &saveptr1);
		    }


		counter = args.size(); 
		argv[i] = new char[args.at(i).size() + 1];
		strcpy(argv[i], args.at(i).c_str());	
	    }
	    
	    argv[args.size()] = '\0';
	    concount = concount + counter;
        
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
		if (args.at(0) == "test" || args.at(0) == "[")
		{
		    struct stat sb;

		    if (args.at(1) == "-e")
		    {
                        if (stat(argv[2], &sb) == -1)
                        {
                            perror("stat");
		            cout << "(False)\n";
                            goto fail_condition;
                        }

                        else
                        {
                            cout << "(True)\n";
                            exit(1);
                        }
		    }

		    if (args.at(1) == "-f")
		    {
		        if (stat(argv[2], &sb) == -1)
		        {
		            perror("stat");
		            cout << "(False)\n";
                            goto fail_condition;
                        }

		        else
		        {
                            switch (sb.st_mode & S_IFMT)
                            {
                                case S_IFREG:   
                                    cout << "(True)\n";     
                                    break;
                                default:        
                                    cout << "(False)\n";    
                                    goto fail_condition;
                            }
                            exit(1);
		        }
		    }

		    if (args.at(1) == "-d")
		    {
                        if (stat(argv[2], &sb) == -1)
		        {
		            perror("stat");
		            cout << "(False)\n";
                            goto fail_condition;
                        }

		        else
		        {
		            switch (sb.st_mode & S_IFMT)
		            {
		                case S_IFDIR:   
		                    cout << "(True)\n";     
		                    break;
		                default:        
		                    cout << "(False)\n";    
		                    goto fail_condition;
		            }
		            exit(1);
		        }
		    }
		    
                    
                    else
                    {
                        if (stat(argv[1], &sb) == -1)
                        {
                            perror("stat");
		            cout << "(False)\n";
                            goto fail_condition;
                        }

                        else
                        {
                            cout << "(True)\n";
                            exit(1);
                        }
    
                    }
                }


		else if (execvp(*argv, argv) == -1)
	        {
	            perror("execvp");
                    goto fail_condition;
		}
		
	    }

	    else
	    {
		if (wait(&status) == -1)
		{
		    perror("wait");
		}

		goto non_fail_condition;

		fail_condition:
		    if (split.at(concount) == 1) 
		    {	
		        // skip command and go to next. && not satisfied
			while (split.at(concount) == 0) 
			{
			    ++concount;
			}
			goto label;
			exit(1);
		    }
		    if (split.at(concount) == 2) 
		    {	
		        // || connector conditions satisfied, goes to next command
			goto label2;
			exit(1);
		    }
		    if (split.at(concount) == 3) 
		    {	
		        // ;  connector, always goes to next command
			goto label2;
			exit(1);
		    }

                non_fail_condition:
		    if (split.at(concount) == 2)
		    {          
		        // || not satisfied, skips command
		        while (split.at(concount) == 0) 
		        {
			    ++concount;
                        }
                        goto label;
		    }	

		    if (split.at(concount) == 1) 
		    {   
		        // && satisfied, doesn't skip command
		        goto label2;
		    }

		    if (split.at(concount) == 3) 
		    {   
		        // never skips command 
		        goto label2;
		    }
                    goto label2;


		label: // skips a command, goes to next
		token = strtok_r(NULL, delim, &saveptr1);

		label2:
		token = strtok_r(NULL, delim, &saveptr1);

        	++concount;
	    }


	}
        

    }

    return 0;
}


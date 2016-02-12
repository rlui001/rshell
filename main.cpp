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
	system("clear");
	cout << "Rshell initialized...\n";
	string username = getlogin();
	char hostname[128] = "";
	gethostname(hostname, sizeof(hostname));
	
	cout << "[" << username << "@" << hostname << "]" << "$ ";

	string userinput;
	getline(cin, userinput);	//Temporary method

	while (userinput != "exit") //Temporary method
	{
		cout << "[" << username << "@" << hostname << "]" << "$ ";
		getline(cin, userinput);
	}





	return 0;
}

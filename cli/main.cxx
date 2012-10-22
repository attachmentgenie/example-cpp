#include <iostream>
#include <string>
#include "example.h"

using namespace std;

int main()
{
	std::string strHelloName = hello("cli");
    cout << strHelloName << endl;

    return 0;
}

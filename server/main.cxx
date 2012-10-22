#include <iostream>
#include <string>
#include "example.h"

using namespace std;

int main()
{
    std::string strHelloName = hello("server");
    cout << strHelloName << endl;

    return 0;
}

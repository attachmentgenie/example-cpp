#include <string>
#include "example.h"

std::string hello(std::string strName)
{
    std::string result;

    result += std::string("Hello world ") + strName + std::string("!");
    return result;
}

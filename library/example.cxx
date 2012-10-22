#include <string>
#include "example.h"

std::string hello(std::string x)
{
	std::string result;

	result += std::string("Hello world ") + x + std::string("!");
	return result;
}

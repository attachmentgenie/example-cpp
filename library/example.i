%module example_library
%{ 
    #define SWIG_FILE_WITH_INIT
    #include "example.h"
%}
%include "example.h"
if(MSVC)
    list(APPEND RESOURCES_SOURCES cli.rc)
endif()

# first we add the executable that generates the table
add_executable(cli main.cxx ${MOC_SOURCES})

# add the binary tree directory to the search path for include files
include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})

install(TARGETS cli DESTINATION ${BIN_INSTALL_DIR})
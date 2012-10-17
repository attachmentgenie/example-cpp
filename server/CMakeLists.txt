if(MSVC)
    list(APPEND RESOURCES_SOURCES server.rc)
endif()

# first we add the executable that generates the table
add_executable(server main.cxx ${MOC_SOURCES})

# add the binary tree directory to the search path for include files
include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})

install (TARGETS server DESTINATION ${BIN_INSTALL_DIR})
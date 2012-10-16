set(SOURCES
    main.cpp
)

if(MSVC)
    list(APPEND RESOURCES_SOURCES cli.rc)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
add_executable(cli ${SOURCES} ${MOC_SOURCES})

install(TARGETS cli DESTINATION ${BIN_INSTALL_DIR})
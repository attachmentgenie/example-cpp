set(SOURCES
    main.cpp
)

if(MSVC)
    list(APPEND RESOURCES_SOURCES server.rc)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
add_executable(server ${SOURCES} ${MOC_SOURCES})

install(TARGETS server DESTINATION ${BIN_INSTALL_DIR})
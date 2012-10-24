add_executable(cli main.cxx ${MOC_SOURCES})

include_directories ("${CMAKE_SOURCE_DIR}/library")
target_link_libraries(cli library ${EXTRA_LIBS})

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
install(TARGETS cli DESTINATION ${BIN_INSTALL_DIR})
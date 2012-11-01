find_package(Doxygen)
if(DOXYGEN_FOUND)
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/api/Doxyfile @ONLY)
	add_custom_target(api
					${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/api/Doxyfile
					WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/api
					COMMENT "Generating API documentation with Doxygen" VERBATIM)
endif(DOXYGEN_FOUND)

if(APPLE)
elseif(WIN32)
	install(FILES "${LICENSE_FILE}" DESTINATION ${DOC_INSTALL_DIR})
elseif(UNIX AND NOT APPLE)
	install(FILES "${LICENSE_FILE}" DESTINATION ${DOC_INSTALL_DIR})
endif()
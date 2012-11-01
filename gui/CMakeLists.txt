find_package(Qt4 COMPONENTS QtMain QtCore QtGui REQUIRED)
include(UseQt4)

add_executable(gui WIN32 MACOSX_BUNDLE main.cxx ${MOC_SOURCES})

include_directories ("${CMAKE_SOURCE_DIR}/library")
target_link_libraries(gui library ${QT_LIBRARIES} ${EXTRA_LIBS})
SET_TARGET_PROPERTIES(gui PROPERTIES OUTPUT_NAME ${PROJECT_NAME})

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
if(APPLE)
	install(TARGETS gui DESTINATION ".")
else()
	install(TARGETS gui DESTINATION "${BIN_INSTALL_DIR}")
endif()

if(APPLE OR WIN32)
	include(DeployQt4)
	install_qt4_executable("${EXECUTABLE}")
endif()

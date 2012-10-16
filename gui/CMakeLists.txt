find_package(Qt4 COMPONENTS QtMain QtCore QtGui REQUIRED)
include(UseQt4)
if(APPLE OR WIN32)
    include(DeployQt4)
    install_qt4_executable("${EXECUTABLE}")
endif()

set(SOURCES
    main.cpp
)

if(MSVC)
    list(APPEND RESOURCES_SOURCES gui.rc)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
add_executable(gui WIN32 MACOSX_BUNDLE ${SOURCES} ${MOC_SOURCES})
target_link_libraries(gui ${QT_LIBRARIES})

install(TARGETS gui DESTINATION ${BIN_INSTALL_DIR})
find_package(Qt4 COMPONENTS QtMain QtCore QtGui REQUIRED)
include(UseQt4)

if(MSVC)
    list(APPEND RESOURCES_SOURCES gui.rc)
endif()

add_executable(gui WIN32 MACOSX_BUNDLE main.cxx ${MOC_SOURCES})

include_directories ("${CMAKE_SOURCE_DIR}/library")
set (EXTRA_LIBS ${EXTRA_LIBS} example)

target_link_libraries(gui ${QT_LIBRARIES} ${EXTRA_LIBS})

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
install(TARGETS gui DESTINATION ${BIN_INSTALL_DIR})

if(APPLE)
    set(EXECUTABLE "${PROJECT_NAME}.app")
else()
    set(EXECUTABLE "${BIN_INSTALL_DIR}/gui${CMAKE_EXECUTABLE_SUFFIX}")
endif()

if(APPLE OR WIN32)
    include(DeployQt4)
    install_qt4_executable("${EXECUTABLE}")
endif()
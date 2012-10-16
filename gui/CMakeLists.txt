find_package(Qt4 COMPONENTS QtMain QtCore QtGui REQUIRED)
include(UseQt4)
set(SOURCES
    main.cpp
)

if(MSVC)
    list(APPEND RESOURCES_SOURCES ${PROJECT_NAME}.rc)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
add_executable(${PROJECT_NAME} WIN32 MACOSX_BUNDLE ${SOURCES} ${MOC_SOURCES})
target_link_libraries(${PROJECT_NAME} ${QT_LIBRARIES})

set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION "${BIN_INSTALL_DIR}")

install(TARGETS ${PROJECT_NAME} DESTINATION ${BIN_INSTALL_DIR})
if(APPLE OR WIN32)
    include(DeployQt4)
    install_qt4_executable("${EXECUTABLE}")
endif()
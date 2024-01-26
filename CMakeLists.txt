cmake_minimum_required(VERSION 3.16)

project(SpaceInvaders VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appSpaceInvaders
    main.cpp
)
set_source_files_properties(
    Parameters.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appSpaceInvaders
    URI SpaceInvaders
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES Menu.qml
    QML_FILES Game.qml
    player2.png
    QML_FILES MenuController.qml
    SOURCES
    QML_FILES MainController.qml
    QML_FILES Bullet.qml
    QML_FILES Parameters.qml
    QML_FILES Enemy.qml
    QML_FILES MVCEnemy.qml
    enemy.png
    SOURCES gamedata.h gamedata.cpp
    QML_FILES EndScreen.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSpaceInvaders PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSpaceInvaders
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSpaceInvaders
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appSpaceInvaders
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

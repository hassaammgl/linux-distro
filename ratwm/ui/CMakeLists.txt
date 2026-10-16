cmake_minimum_required(VERSION 3.21)
project(rat-ui LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
qt_standard_project_setup(REQUIRES 6.5)

# Keep files in folders on disk, but expose flat names inside the QML module
set_source_files_properties(
    shell/Shell.qml PROPERTIES QT_RESOURCE_ALIAS Shell.qml
)
set_source_files_properties(
    shell/topbar/TopBar.qml PROPERTIES QT_RESOURCE_ALIAS TopBar.qml
)
set_source_files_properties(
    shell/sidebar/Sidebar.qml PROPERTIES QT_RESOURCE_ALIAS Sidebar.qml
)
set_source_files_properties(
    shell/dock/Dock.qml PROPERTIES QT_RESOURCE_ALIAS Dock.qml
)
set_source_files_properties(
    shell/wallpaper/Wallpaper.qml PROPERTIES QT_RESOURCE_ALIAS Wallpaper.qml
)
set_source_files_properties(
    apps/clock/Clock.qml PROPERTIES QT_RESOURCE_ALIAS Clock.qml
)
set_source_files_properties(
    apps/files/Files.qml PROPERTIES QT_RESOURCE_ALIAS Files.qml
)

# --- Desktop shell (topbar / sidebar / dock / wallpaper) ---
qt_add_executable(rat-shell shell/main.cpp shell/Launcher.h)
qt_add_qml_module(rat-shell
    URI RatShell
    VERSION 1.0
    QML_FILES
        shell/Shell.qml
        shell/topbar/TopBar.qml
        shell/sidebar/Sidebar.qml
        shell/dock/Dock.qml
        shell/wallpaper/Wallpaper.qml
)
target_link_libraries(rat-shell PRIVATE Qt6::Quick)

# --- Sample app: Clock ---
qt_add_executable(rat-clock apps/clock/main.cpp)
qt_add_qml_module(rat-clock
    URI RatClock
    VERSION 1.0
    QML_FILES apps/clock/Clock.qml
)
target_link_libraries(rat-clock PRIVATE Qt6::Quick)

# --- Sample app: Files (basic folder browser) ---
qt_add_executable(rat-files apps/files/main.cpp)
qt_add_qml_module(rat-files
    URI RatFiles
    VERSION 1.0
    QML_FILES apps/files/Files.qml
)
target_link_libraries(rat-files PRIVATE Qt6::Quick)

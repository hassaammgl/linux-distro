cmake_minimum_required(VERSION 3.21)
project(ratwm LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick WaylandCompositor)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(ratwm main.cpp)
qt_add_qml_module(ratwm
    URI RatWM
    VERSION 1.0
    QML_FILES Main.qml
)
target_link_libraries(ratwm PRIVATE Qt6::Quick Qt6::WaylandCompositor)

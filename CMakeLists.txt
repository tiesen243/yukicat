cmake_minimum_required(VERSION 3.16)
project(Yukicat VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml)

qt_add_executable(Yukicat
  src/main.cpp
)

qt_add_qml_module(Yukicat
  URI Yukicat
  VERSION 1.0
  RESOURCE_PREFIX "/"
  SOURCES
    src/backend.h
    src/backend.cpp
  QML_FILES
    src/main.qml
)

target_include_directories(Yukicat PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)

target_link_libraries(Yukicat PRIVATE 
    Qt6::Core 
    Qt6::Gui 
    Qt6::Qml
)

set_target_properties(Yukicat PROPERTIES OUTPUT_NAME "yukicat")

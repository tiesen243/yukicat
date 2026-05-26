cmake_minimum_required(VERSION 3.16)

set(CMAKE_POLICY_DEFAULT_QTP0004 NEW)

project(Yukicat VERSION 1.0 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

string(TOLOWER "${CMAKE_BUILD_TYPE}" build_type_lower)
if(NOT build_type_lower)
  set(build_type_lower "debug")
endif()
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/target/${build_type_lower}")

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml)

set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)

qt_add_executable(Yukicat
  src/main.cpp
)

qt_add_qml_module(Yukicat
  URI Yukicat
  VERSION 1.0
  RESOURCE_PREFIX "/"
  QML_FILES
    src/main.qml
)

target_link_libraries(Yukicat PRIVATE Qt6::Core Qt6::Gui Qt6::Qml)

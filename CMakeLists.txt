cmake_minimum_required(VERSION 3.15)

project(Untitled VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_custom_target(
    format
    COMMAND clang-format -i ${CMAKE_SOURCE_DIR}/src/*.cpp ${CMAKE_SOURCE_DIR}/include/*.h ${CMAKE_SOURCE_DIR}/include/*.hpp
    COMMENT "Formatting source code"
)

find_package(OpenSSL REQUIRED)

#set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
include(cmake/StandardSettings.cmake)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
endif()
message(STATUS "Started CMake for ${PROJECT_NAME} v${PROJECT_VERSION}...\n")

if(UNIX)
  add_compile_options("$<$<CONFIG:DEBUG>:-D_DEBUG>")
endif(UNIX)

# prevent build in src folder
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds are not allowed.\n")
endif()


include(cmake/SourcesAndHeaders.cmake)
add_executable(${PROJECT_NAME} ${exe_sources})
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 20 OUTPUT_NAME "a.out")

target_include_directories(${PROJECT_NAME} PRIVATE include)
target_link_libraries(${PROJECT_NAME} PRIVATE ${OPENSSL_CRYPTO_LIBRARY})

add_subdirectory(external/Catch2)
# unit testing setup
if(${PROJECT_NAME}_ENABLE_UNIT_TESTING)
  #enable_testing()
  message(STATUS "Building unit tests for ${PROJECT_NAME}.\n")
  add_subdirectory(tests)
endif()
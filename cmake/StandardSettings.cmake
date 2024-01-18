option(${PROJECT_NAME}_BUILD_EXECUTABLE "Build the project as an executable." ON)
option(${PROJECT_NAME}_BUILD_HEADERS_ONLY "Build the project as a header-only library" OFF)
option(${PROJECT_NAME}_USE_ALT_NAMES "Use alternative names for project(eg. lowercase, uppercase" ON)

option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)

option(${PROJECT_NAME}_ENABLE_UNIT_TESTING "Enable unit tests" ON)
option(${PROJECT_NAME}_USE_CATCH2 "Use Catch2 project for creating unit tests" ON)

option(${PROJECT_NAME}_ENABLE_CODE_COVERAGE "Enable code coverage through GCC" ON)
option(${PROJECT_NAME}_ENABLE_DOXYGEN "Enable Doxygen documentation builds of source" OFF)

option(${PROJECT_NAME}_VERBOSE_OUTPUT "Enable verbose output" ON)

option(${PROJECT_NAME}_ENABLE_LTO "Enable Interprocedural Optimization, LTO" OFF)

option(${PROJECT_NAME}_ENABLE_CCACHE "Enable the usage of Ccache" ON)
find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif()
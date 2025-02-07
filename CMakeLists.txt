cmake_minimum_required(VERSION 3.5)
project(dv3 CXX)

# Docker special
if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    find_program(LSB_RELEASE lsb_release)
    if (LSB_RELEASE)
        execute_process(COMMAND ${LSB_RELEASE} -is
                OUTPUT_VARIABLE DISTRO
                OUTPUT_STRIP_TRAILING_WHITESPACE)
        if (DISTRO STREQUAL "Ubuntu")
            message(STATUS "Building on Ubuntu - Forcing g++-13 and C++20")
            set(CMAKE_CXX_COMPILER "/usr/bin/g++-13" CACHE STRING "C++ Compiler" FORCE)
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20 -fcoroutines -pthread" CACHE STRING "" FORCE)
        endif ()
    endif ()
endif ()

include(CheckIncludeFileCXX)

check_include_file_cxx(any HAS_ANY)
check_include_file_cxx(string_view HAS_STRING_VIEW)
check_include_file_cxx(coroutine HAS_COROUTINE)
if (NOT "${CMAKE_CXX_STANDARD}" STREQUAL "")
    # Do nothing
elseif (HAS_ANY AND HAS_STRING_VIEW AND HAS_COROUTINE)
    set(CMAKE_CXX_STANDARD 20)
elseif (HAS_ANY AND HAS_STRING_VIEW)
    set(CMAKE_CXX_STANDARD 17)
else ()
    set(CMAKE_CXX_STANDARD 14)
endif ()

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(${PROJECT_NAME} main.cc)

# ##############################################################################
# If you include the drogon source code locally in your project, use this method
# to add drogon 
# add_subdirectory(drogon) 
# target_link_libraries(${PROJECT_NAME} PRIVATE drogon)
#
# and comment out the following lines
find_package(Drogon CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Drogon::Drogon)

# ##############################################################################

if (CMAKE_CXX_STANDARD LESS 17)
    message(FATAL_ERROR "c++17 or higher is required")
elseif (CMAKE_CXX_STANDARD LESS 20)
    message(STATUS "use c++17")
else ()
    message(STATUS "use c++20")
endif ()

aux_source_directory(controllers CTL_SRC)
aux_source_directory(filters FILTER_SRC)
aux_source_directory(plugins PLUGIN_SRC)
# aux_source_directory(models MODEL_SRC)

#drogon_create_views(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/views
#                    ${CMAKE_CURRENT_BINARY_DIR})
# use the following line to create views with namespaces.
# drogon_create_views(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/views
#                     ${CMAKE_CURRENT_BINARY_DIR} TRUE)
# use the following line to create views with namespace CHANGE_ME prefixed
# and path namespaces.
# drogon_create_views(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/views
#                     ${CMAKE_CURRENT_BINARY_DIR} TRUE CHANGE_ME)

target_include_directories(${PROJECT_NAME}
                           PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
                                   ${CMAKE_CURRENT_SOURCE_DIR}/models)
target_sources(${PROJECT_NAME}
               PRIVATE
               ${SRC_DIR}
               ${CTL_SRC}
               ${FILTER_SRC}
               ${PLUGIN_SRC}
               ${MODEL_SRC})
# ##############################################################################
# uncomment the following line for dynamically loading views 
# set_property(TARGET ${PROJECT_NAME} PROPERTY ENABLE_EXPORTS ON)

# ##############################################################################

add_subdirectory(test)

# ##############################################################################
# Vue3 Embedding
set(FRONTEND_DIR "${CMAKE_SOURCE_DIR}/frontend")
set(EXEC_PUBLIC_DIR "${CMAKE_BINARY_DIR}/public")

# Ensure the public directory exists in the build directory
file(MAKE_DIRECTORY ${EXEC_PUBLIC_DIR})

# Add a custom target to build the frontend
add_custom_target(build_frontend ALL
        COMMAND npm install
        COMMAND npm run build
        WORKING_DIRECTORY ${FRONTEND_DIR}
        COMMENT "Building Vue 3 frontend..."
)

# Add a custom cmd to copy the built files into the build directory
add_custom_command(
        TARGET build_frontend POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${FRONTEND_DIR}/dist ${EXEC_PUBLIC_DIR}
        COMMENT "Copying Vue 3 build files to ${EXEC_PUBLIC_DIR}..."
)

# Ensure project depends on the frontend build
add_dependencies(${PROJECT_NAME} build_frontend)
# ##############################################################################

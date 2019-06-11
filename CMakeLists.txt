cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
project(nominatim)
set(NOMINATIM_VERSION_MAJOR 3)
set(NOMINATIM_VERSION_MINOR 3)
set(NOMINATIM_VERSION_PATCH 0)
set(NOMINATIM_VERSION "${NOMINATIM_VERSION_MAJOR}.${NOMINATIM_VERSION_MINOR}.${NOMINATIM_VERSION_PATCH}")
add_definitions(-DNOMINATIM_VERSION="${NOMINATIM_VERSION}")

set(BUILD_TESTS off CACHE BOOL "Build test suite" FORCE)
set(WITH_LUA off CACHE BOOL "Build with lua support" FORCE)

find_package(Threads REQUIRED)
find_package(PostgreSQL REQUIRED)
include_directories(${PostgreSQL_INCLUDE_DIRS})
find_program(PG_CONFIG pg_config)
execute_process(COMMAND ${PG_CONFIG} --pgxs
                OUTPUT_VARIABLE PGXS
                OUTPUT_STRIP_TRAILING_WHITESPACE)

find_package(ZLIB REQUIRED)
find_package(BZip2 REQUIRED)
find_package(LibXml2 REQUIRED)
include_directories(${LIBXML2_INCLUDE_DIR})

add_subdirectory(module)
add_subdirectory(nominatim)

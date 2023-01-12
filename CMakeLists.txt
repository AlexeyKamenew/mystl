cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    mystl
    VERSION 0.1.0
    DESCRIPTION "Reimplementing some std API for fun and learning."
    HOMEPAGE_URL "https://github.com/AlexeyKamenew/mystl"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    mystl_mystl
    source/mystl.cpp
)
add_library(mystl::mystl ALIAS mystl_mystl)

include(GenerateExportHeader)
generate_export_header(
    mystl_mystl
    BASE_NAME mystl
    EXPORT_FILE_NAME export/mystl/mystl_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(mystl_mystl PUBLIC MYSTL_STATIC_DEFINE)
endif()

set_target_properties(
    mystl_mystl PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME mystl
    OUTPUT_NAME mystl
)

target_include_directories(
    mystl_mystl ${warning_guard}
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    mystl_mystl SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(mystl_mystl PUBLIC cxx_std_20)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Examples ----

if(PROJECT_IS_TOP_LEVEL)
  option(BUILD_EXAMPLES "Build examples tree." "${mystl_DEVELOPER_MODE}")
  if(BUILD_EXAMPLES)
    add_subdirectory(example)
  endif()
endif()

# ---- Developer mode ----

if(NOT mystl_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of mystl"
  )
endif()

include(cmake/dev-mode.cmake)

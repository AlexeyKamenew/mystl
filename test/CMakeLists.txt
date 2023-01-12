cmake_minimum_required(VERSION 3.14)

project(mystlTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)
include(../cmake/windows-set-path.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(mystl REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(mystl_test source/mystl_test.cpp)
target_link_libraries(mystl_test PRIVATE mystl::mystl)
target_compile_features(mystl_test PRIVATE cxx_std_20)

add_test(NAME mystl_test COMMAND mystl_test)
windows_set_path(mystl_test mystl::mystl)

# ---- End-of-file commands ----

add_folders(Test)

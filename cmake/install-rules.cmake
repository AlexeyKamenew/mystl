if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/mystl-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package mystl)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT mystl_Development
)

install(
    TARGETS mystl_mystl
    EXPORT mystlTargets
    RUNTIME #
    COMPONENT mystl_Runtime
    LIBRARY #
    COMPONENT mystl_Runtime
    NAMELINK_COMPONENT mystl_Development
    ARCHIVE #
    COMPONENT mystl_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    mystl_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(mystl_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${mystl_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT mystl_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${mystl_INSTALL_CMAKEDIR}"
    COMPONENT mystl_Development
)

install(
    EXPORT mystlTargets
    NAMESPACE mystl::
    DESTINATION "${mystl_INSTALL_CMAKEDIR}"
    COMPONENT mystl_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()

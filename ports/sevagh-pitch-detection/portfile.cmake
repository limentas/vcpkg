include(CMakePackageConfigHelpers)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO limentas/pitch-detection
    REF "8edf3afd7b62b0ecf1264bd0c8e8857969a602f2"
    SHA512 4f29c3cc17374c7ad0a7d9142e129df41b7eb640eef6cfdaff6161e898d85801f4f486e57a32ce978da09f95a3e77fd91eb0dde274257009c3ada7d01f13e076
    HEAD_REF master
#    PATCHES
#    fix-msvc-build.patch

    # fix-install.patch
    # remove-static-suffix.patch
    # fix-cache-flush-on-android.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    -DCMAKE_INCLUDE_PATH=${CURRENT_PACKAGES_DIR}/include
    -DCMAKE_LIBRARY_PATH=${CURRENT_PACKAGES_DIR}/lib
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

# configure_package_config_file(
# "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in"
# "${CURRENT_PACKAGES_DIR}/share/unofficial-${PORT}/unofficial-${PORT}-config.cmake"
# INSTALL_DESTINATION "share/${PORT}"
# )
# vcpkg_fixup_pkgconfig()

file(COPY "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/sevagh-pitch-detection")

# file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

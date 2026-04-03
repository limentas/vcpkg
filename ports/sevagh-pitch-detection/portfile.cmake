include(CMakePackageConfigHelpers)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO limentas/pitch-detection
    REF "407c693809f127f71b85848e36848f45a5a29213"
    SHA512 046420fdbcb669cb597b6a451b6c5c108235bee76ae8f57f9c8459761423e7f271ed79de540c83461d6d0d1cd664dd8dbfcf90ffcdeb9c58b89777d193afcbb9
    HEAD_REF master

    # PATCHES
    # fix-msvc-build.patch

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

configure_package_config_file(
    "${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in"
    "${CURRENT_PACKAGES_DIR}/share/${PORT}/${PORT}-config.cmake"
    INSTALL_DESTINATION "share/${PORT}"
)

# vcpkg_fixup_pkgconfig()

# file(COPY "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/sevagh-pitch-detection")
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

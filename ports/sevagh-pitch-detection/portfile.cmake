include(CMakePackageConfigHelpers)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO limentas/pitch-detection
    REF "ae80d6d842f7fe94a58eb3d4c1ac965aafbd5c66"
    SHA512 938ea1a1090e8e0a4b6c9b52a66e1de99d76b912a357076b4a1c3031e7e2fc81a5a34babfcaca014ff033d4b73e18c1e44d7cfe6aff53ec87ac86254da612b5e
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
    -DBUILD_FOR_VCPKG=ON
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

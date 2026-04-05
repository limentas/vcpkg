include(CMakePackageConfigHelpers)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO limentas/pitch-detection
    REF "4e1b50fb32b32138b55aec8c362a1244180ae43b"
    SHA512 a2534ab06c5761416c1048d0fcba61b147847ff0379c2702390b807d11f8342f5fa012caff2de72eb2082315d6e05c75af56f7fa0e110d44481eb3d8a5235610
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

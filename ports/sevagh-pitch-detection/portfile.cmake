include(CMakePackageConfigHelpers)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO limentas/pitch-detection
    REF "5034ce4fd58e7a7eb8b3ae13d1ad018eb3ef8e77"
    SHA512 a8a0ae0c25e5c65e72f6b3b27d2a655cf65b87233a8b8d80c2c954231e7e68f7a841b05420cb796026b31d7691ac57b1c318dc7ecc57e278fe17a93b1ab95f3f
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

find_path(LibHaru_INCLUDE_DIR
  NAMES hpdf.h
  DOC "libharu include directory")
mark_as_advanced(LibHaru_INCLUDE_DIR)

find_library(LibHaru_LIBRARY
  NAMES hpdf hpdfs libhpdf libhpdfs
  DOC "libharu release library")
mark_as_advanced(LibHaru_LIBRARY)

if (LibHaru_INCLUDE_DIR)
  file(STRINGS "${LibHaru_INCLUDE_DIR}/hpdf_version.h" _libharu_version_lines
    REGEX "#define HPDF_(MAJOR|MINOR|BUGFIX|EXTRA)_VERSION")
  string(REGEX REPLACE ".*HPDF_MAJOR_VERSION *\([0-9]*\).*" "\\1" _libharu_version_major "${_libharu_version_lines}")
  string(REGEX REPLACE ".*HPDF_MINOR_VERSION *\([0-9]*\).*" "\\1" _libharu_version_minor "${_libharu_version_lines}")
  string(REGEX REPLACE ".*HPDF_BUGFIX_VERSION *\([0-9]*\).*" "\\1" _libharu_version_bugfix "${_libharu_version_lines}")
  string(REGEX REPLACE ".*HPDF_EXTRA_VERSION *\"\([^\"]*\)\".*" "\\1" _libharu_version_extra "${_libharu_version_lines}")
  set(LibHaru_VERSION "${_libharu_version_major}.${_libharu_version_minor}.${_libharu_version_bugfix}")
  if (_libharu_version_extra)
    string(APPEND LibHaru_VERSION
      "-${_libharu_version_extra}")
  endif ()
  unset(_libharu_version_major)
  unset(_libharu_version_minor)
  unset(_libharu_version_bugfix)
  unset(_libharu_version_extra)
  unset(_libharu_version_lines)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LibHaru
  REQUIRED_VARS LibHaru_LIBRARY LibHaru_INCLUDE_DIR
  VERSION_VAR LibHaru_VERSION)

if (LibHaru_FOUND)
  set(LibHaru_INCLUDE_DIRS "${LibHaru_INCLUDE_DIR}")
  set(LibHaru_LIBRARIES "${LibHaru_LIBRARY}")
endif ()

# - Find ogg
# Find the native ogg includes and libraries
#
#  OGG_INCLUDE_DIR - where to find ogg.h, etc.
#  OGG_LIBRARIES   - List of libraries when using ogg.
#  OGG_FOUND       - True if ogg found.

if(OGG_INCLUDE_DIR)
    # Already in cache, be silent
    set(OGG_FIND_QUIETLY TRUE)
endif(OGG_INCLUDE_DIR)
find_path(OGG_INCLUDE_DIR ogg/ogg.h)
# MSVC built ogg may be named ogg_static.
# The provided project files name the library with the lib prefix.
find_library(OGG_LIBRARY NAMES ogg ogg_static libogg libogg_static)
# Handle the QUIETLY and REQUIRED arguments and set OGG_FOUND
# to TRUE if all listed variables are TRUE.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Ogg DEFAULT_MSG OGG_LIBRARY OGG_INCLUDE_DIR )

if (OGG_FOUND)
  set(OGG_LIBRARIES ${OGG_LIBRARY})
  set(OGG_INCLUDE_DIRS ${OGG_INCLUDE_DIR})
endif ()

mark_as_advanced(OGG_INCLUDE_DIR)
mark_as_advanced(OGG_LIBRARY)

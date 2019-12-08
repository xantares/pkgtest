# Find FreeImage includes and library
#
# This module defines
#  FreeImage_INCLUDE_DIRS
#  FreeImage_LIBRARIES, the libraries to link against to use FreeImage.
#  FreeImage_LIBRARY_DIRS, the location of the libraries
#  FreeImage_FOUND, If false, do not try to use FreeImage

find_path (FreeImage_INCLUDE_DIRS FreeImage.h)
find_library (FreeImage_LIBRARIES NAMES freeimage FreeImage)


# handle the QUIETLY and REQUIRED arguments
include (FindPackageHandleStandardArgs)
find_package_handle_standard_args(FreeImage DEFAULT_MSG FreeImage_LIBRARIES FreeImage_INCLUDE_DIRS)

mark_as_advanced (FreeImage_INCLUDE_DIRS FreeImage_LIBRARIES FreeImage_LIBRARY_DIRS)

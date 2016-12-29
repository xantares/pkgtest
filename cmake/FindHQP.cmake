# - Find Hqp
# library for nonlinear optimization
# http://ab-initio.mit.edu/nlopt
#
# The module defines the following variables:
#  HQP_FOUND - the system has nlopt
#  HQP_INCLUDE_DIR - where to find nlopt.h
#  HQP_INCLUDE_DIRS - nlopt includes
#  HQP_LIBRARY - where to find the nlopt library
#  HQP_LIBRARIES - aditional libraries
#  HQP_ROOT_DIR - root dir (ex. /usr/local)

# set HQP_INCLUDE_DIR
find_path (HQP_INCLUDE_DIR
  NAMES Hqp.h
  PATH_SUFFIXES hqp
  DOC
    "Hqp include directory"
)

# set HQP_INCLUDE_DIRS
set (HQP_INCLUDE_DIRS ${HQP_INCLUDE_DIR})

# set HQP_LIBRARY
find_library (HQP_LIBRARY
  NAMES hqp
  DOC
    "Hqp library location"
)

# set HQP_LIBRARIES
set (HQP_LIBRARIES ${HQP_LIBRARY})

# root dir
# try to guess root dir from include dir
if (HQP_INCLUDE_DIR)
  string (REGEX REPLACE "(.*)/include.*" "\\1" HQP_ROOT_DIR ${HQP_INCLUDE_DIR})

# try to guess root dir from library dir
elseif (HQP_LIBRARY)
  string (REGEX REPLACE "(.*)/lib[/|32|64].*" "\\1" HQP_ROOT_DIR ${HQP_LIBRARY})
endif ()

# handle REQUIRED and QUIET options
include (FindPackageHandleStandardArgs)

find_package_handle_standard_args (HQP DEFAULT_MSG HQP_LIBRARY
  HQP_INCLUDE_DIR
  HQP_INCLUDE_DIRS
  HQP_LIBRARIES
  HQP_ROOT_DIR
)


mark_as_advanced (
  HQP_LIBRARY
  HQP_LIBRARIES
  HQP_INCLUDE_DIR
  HQP_INCLUDE_DIRS
  HQP_ROOT_DIR
)

# - Find LpSolve
# lp_solve is a Mixed Integer Linear Programming (MILP) solver
# http://lpsolve.sourceforge.net/
#
# The module defines the following variables:
#  LPSOLVE_FOUND        - True if LpSolve found.
#  LPSOLVE_INCLUDE_DIRS - where to find muParser.h, etc.
#  LPSOLVE_LIBRARIES    - List of libraries when using LpSolve.
#

find_path (LPSOLVE_INCLUDE_DIR lp_lib.h PATH_SUFFIXES lpsolve)
set (LPSOLVE_INCLUDE_DIRS ${LPSOLVE_INCLUDE_DIR})

find_library (LPSOLVE_LIBRARY NAMES lpsolve55)
set (LPSOLVE_LIBRARIES ${LPSOLVE_LIBRARY})

#define MAJORVERSION             5
#define MINORVERSION             5
#define RELEASE                  2
#define BUILD                    5

# version
set (_VERSION_FILE ${LPSOLVE_INCLUDE_DIR}/lp_lib.h)
if ( EXISTS ${_VERSION_FILE} )
  file (STRINGS ${_VERSION_FILE} _LPSOLVE_VERSION_LINE REGEX "#define MAJORVERSION[ ]+(.*)")
  if ( _LPSOLVE_VERSION_LINE )
    string ( REGEX REPLACE "#define MAJORVERSION[ ]+(.*)" "\\1" LPSOLVE_MAJOR_VERSION ${_LPSOLVE_VERSION_LINE} )
  endif ()
  file (STRINGS ${_VERSION_FILE} _LPSOLVE_VERSION_LINE REGEX "#define MINORVERSION[ ]+(.*)")
  if ( _LPSOLVE_VERSION_LINE )
    string ( REGEX REPLACE "#define MINORVERSION[ ]+(.*)" "\\1" LPSOLVE_MINOR_VERSION ${_LPSOLVE_VERSION_LINE} )
  endif ()
  file (STRINGS ${_VERSION_FILE} _LPSOLVE_VERSION_LINE REGEX "#define RELEASE[ ]+(.*)")
  if ( _LPSOLVE_VERSION_LINE )
    string ( REGEX REPLACE "#define RELEASE[ ]+(.*)" "\\1" LPSOLVE_PATCH_VERSION ${_LPSOLVE_VERSION_LINE} )
  endif ()
#   set (LPSOLVE_VERSION_STRING )
  set (LPSOLVE_VERSION_STRING "${LPSOLVE_MAJOR_VERSION}.${LPSOLVE_MINOR_VERSION}.${LPSOLVE_PATCH_VERSION}")
endif ()

# check version
set ( _LPSOLVE_VERSION_MATCH TRUE )
if ( LpSolve_FIND_VERSION AND LPSOLVE_VERSION_STRING )
  if ( LpSolve_FIND_VERSION_EXACT )
    if ( ${LpSolve_FIND_VERSION} VERSION_EQUAL ${LPSOLVE_VERSION_STRING} )
    else()
      set ( _LPSOLVE_VERSION_MATCH FALSE)
    endif ()
  else ()
    if ( ${LpSolve_FIND_VERSION} VERSION_GREATER ${LPSOLVE_VERSION_STRING} )
      set ( _LPSOLVE_VERSION_MATCH FALSE )
    endif ()
  endif ()
endif ()



find_package_handle_standard_args ( LpSolve
    REQUIRED_VARS LPSOLVE_LIBRARY LPSOLVE_INCLUDE_DIR
    VERSION_VAR LPSOLVE_VERSION_STRING
  )

mark_as_advanced (
  LPSOLVE_LIBRARY
  LPSOLVE_LIBRARIES
  LPSOLVE_INCLUDE_DIR
  LPSOLVE_INCLUDE_DIRS
  LPSOLVE_MAJOR_VERSION
  LPSOLVE_MINOR_VERSION
  LPSOLVE_PATCH_VERSION
  LPSOLVE_VERSION_STRING
)

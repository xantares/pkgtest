# - Try to find the AGG graphics library
# Once done this will define
#
#  AGG_FOUND - system has AGG
#  AGG_INCLUDE_DIRS - the AGG include directories
#  AGG_LIBRARIES - Link these to use AGG
#  AGG_DEFINITIONS - Compiler switches required for using AGG

# Copyright (c) 2006, Alexander Neundorf, <neundorf@kde.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.


if (NOT WIN32)
  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIBRARY() calls
  find_package(PkgConfig)
  pkg_check_modules(PC_AGG QUIET libagg) 

  set(AGG_DEFINITIONS ${PC_AGG_CFLAGS_OTHER})
endif (NOT WIN32)

find_path(AGG_INCLUDE_DIR agg_pixfmt_gray.h
  PATH_SUFFIXES agg agg2
#     PATHS ${PC_AGG_INCLUDEDIR} ${PC_AGG_INCLUDE_DIRS}
)

find_library(AGG_LIBRARY NAMES agg
  PATHS ${PC_AGG_LIBDIR} ${PC_AGG_LIBRARY_DIRS}
)
find_library(AGG_PLATFORM_LIBRARY NAMES aggplatformX11 aggplatformsdl aggplatformwin32
  PATHS ${PC_AGG_LIBDIR} ${PC_AGG_LIBRARY_DIRS}
)
  
if (AGG_INCLUDE_DIR AND AGG_LIBRARY)
    set (AGG_INCLUDE_DIRS ${AGG_INCLUDE_DIR})
    set (AGG_LIBRARIES ${AGG_LIBRARY})
  if (AGG_PLATFORM_LIBRARY)
    list(APPEND AGG_LIBRARIES ${AGG_PLATFORM_LIBRARY})
  endif ()
endif ()


# handle REQUIRED and QUIET options
include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args ( AGG DEFAULT_MSG AGG_LIBRARY AGG_INCLUDE_DIR )

mark_as_advanced(AGG_INCLUDE_DIRS AGG_INCLUDE_DIR AGG_LIBRARY AGG_LIBRARIES)

# - Find SGpp
# SG++ is a universal toolbox for spatially adaptive sparse grid methods and the combination technique
# http://sgpp.sparsegrids.org/
#
# The module defines the following variables:
#  SGPP_FOUND        - True if SGpp found.
#  SGPP_INCLUDE_DIRS - where to find headers
#  SGPP_LIBRARIES    - List of libraries when using SGpp.
#
#=============================================================================
# Copyright (C) 2005-2013 EDF-EADS-Phimeca
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distributed this file outside of CMake, substitute the full
#  License text for the above reference.)

if ( SGPP_INCLUDE_DIR AND SGPP_LIBRARIES )
  # Already in cache, be silent
  set ( SGpp_FIND_QUIETLY TRUE )
endif ()

find_path ( SGPP_INCLUDE_DIR NAMES globaldef.hpp
            PATH_SUFFIXES sgpp
            )
            
set ( SGPP_INCLUDE_DIRS ${SGPP_INCLUDE_DIR} )

find_library (SGPPBASE_LIBRARY NAMES sgppbase)
find_library (SGPPCOMBIGRID_LIBRARY NAMES sgppcombigrid)
find_library (SGPPDATADRIVEN_LIBRARY NAMES sgppdatadriven)
find_library (SGPPMISC_LIBRARY NAMES sgppmisc)
find_library (SGPPOPTIMIZATION_LIBRARY NAMES sgppoptimization)
find_library (SGPPPDE_LIBRARY NAMES sgpppde)
find_library (SGPPQUADRATURE_LIBRARY NAMES sgppquadrature)
find_library (SGPPSOLVER_LIBRARY NAMES sgppsolver)

# set SGPP_LIBRARIES
set (SGPP_LIBRARIES ${SGPPBASE_LIBRARY})
if (SGPPCOMBIGRID_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPCOMBIGRID_LIBRARY})
endif ()
if (SGPPDATADRIVEN_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPDATADRIVEN_LIBRARY})
endif ()
if (SGPPMISC_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPMISC_LIBRARY})
endif ()
if (SGPPOPTIMIZATION_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPOPTIMIZATION_LIBRARY})
endif ()
if (SGPPPDE_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPPDE_LIBRARY})
endif ()
if (SGPPQUADRATURE_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPQUADRATURE_LIBRARY})
endif ()
if (SGPPSOLVER_LIBRARY)
  list (APPEND SGPP_LIBRARIES ${SGPPSOLVER_LIBRARY})
endif ()
# root dir
# try to guess root dir from include dir
if ( SGPP_INCLUDE_DIR )
  string ( REGEX REPLACE "(.*)/include.*" "\\1" SGPP_ROOT_DIR ${SGPP_INCLUDE_DIR} )

# try to guess root dir from library dir
elseif ( SGPPBASE_LIBRARY )
  string ( REGEX REPLACE "(.*)/lib[/|32|64].*" "\\1" SGPP_ROOT_DIR ${SGPPBASE_LIBRARY} )
endif ()

# handle REQUIRED and QUIET options
include ( FindPackageHandleStandardArgs )

find_package_handle_standard_args ( SGpp 
  REQUIRED_VARS SGPPBASE_LIBRARY SGPP_LIBRARIES SGPP_INCLUDE_DIR SGPP_INCLUDE_DIRS
)

mark_as_advanced (
  SGPPBASE_LIBRARY
  SGPPCOMBIGRID_LIBRARY
  SGPPDATADRIVEN_LIBRARY
  SGPPMISC_LIBRARY
  SGPPOPTIMIZATION_LIBRARY
  SGPPPDE_LIBRARY
  SGPPQUADRATURE_LIBRARY
  SGPPSOLVER_LIBRARY
  SGPP_LIBRARIES
  SGPP_INCLUDE_DIR
  SGPP_INCLUDE_DIRS
  SGPP_ROOT_DIR 
)

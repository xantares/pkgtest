# - Find ExprTk
# C++ Mathematical Expression Library
# http://www.partow.net/programming/exprtk/index.html
#
# The module defines the following variables:
#  EXPRTK_FOUND        - True if ExprTk found.
#  EXPRTK_INCLUDE_DIRS - where to find exprtk.hpp.
#
#=============================================================================
# Copyright 2005-2016 Airbus-EDF-IMACS-Phimeca
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

if (EXPRTK_INCLUDE_DIR)
  # Already in cache, be silent
  set (ExprTk_FIND_QUIETLY TRUE)
endif ()

find_path (EXPRTK_INCLUDE_DIR 
           NAMES exprtk.hpp
           PATH_SUFFIXES exprtk)

set (EXPRTK_INCLUDE_DIRS ${EXPRTK_INCLUDE_DIR})

# version
set (_VERSION_FILE ${EXPRTK_INCLUDE_DIR}/exprtk.hpp)
if (EXISTS ${_VERSION_FILE})
  file (STRINGS ${_VERSION_FILE} _EXPRTK_VERSION_LINE REGEX "const char\\* date[ ]+= \".*\"")
  if (_EXPRTK_VERSION_LINE)
    string (REGEX REPLACE ".*= \"(.*)\"" "\\1" EXPRTK_VERSION_STRING ${_EXPRTK_VERSION_LINE})
  endif ()
endif ()

# check version
set (_EXPRTK_VERSION_MATCH TRUE)
if (ExprTk_FIND_VERSION AND EXPRTK_VERSION_STRING)
  if (ExprTk_FIND_VERSION_EXACT)
    if (${ExprTk_FIND_VERSION} VERSION_EQUAL ${EXPRTK_VERSION_STRING})
    else()
      set (_EXPRTK_VERSION_MATCH FALSE)
    endif ()
  else ()
    if (${ExprTk_FIND_VERSION} VERSION_GREATER ${EXPRTK_VERSION_STRING})
      set (_EXPRTK_VERSION_MATCH FALSE)
    endif ()
  endif ()
endif ()

# handle REQUIRED and QUIET options
include (FindPackageHandleStandardArgs)

  find_package_handle_standard_args (ExprTk 
    REQUIRED_VARS EXPRTK_INCLUDE_DIR _EXPRTK_VERSION_MATCH
    VERSION_VAR EXPRTK_VERSION_STRING
 )

mark_as_advanced (
  EXPRTK_INCLUDE_DIR
  EXPRTK_INCLUDE_DIRS
  EXPRTK_VERSION_STRING
)

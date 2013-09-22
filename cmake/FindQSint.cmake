# QSint in an Opensource collection of Qt widgets 
# available at http://sintegrial.com/qsint/pages/en/index.php
#
# The module defines the following variables:
#  QSINT_FOUND - the system has QSint
#  QSINT_INCLUDE_DIR - where to find Qsci/qsciscintilla.h
#  QSINT_INCLUDE_DIRS - qwt includes
#  QSINT_LIBRARY - where to find the QSint library
#  QSINT_LIBRARIES - aditional libraries
#  QSINT_ROOT_DIR - root dir (ex. /usr/local)

#=============================================================================
# Copyright 2010-2013, Julien Schueller
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


find_path ( QSINT_INCLUDE_DIR
  NAMES Core/actionbox.h
  HINTS ${QT_INCLUDE_DIR}
  PATH_SUFFIXES qsint
)

set ( QSINT_INCLUDE_DIRS ${QSINT_INCLUDE_DIR} )

find_library ( QSINT_CORE_LIBRARY
  NAMES QSCore
  HINTS ${QT_LIBRARY_DIR}
)

find_library ( QSINT_CHARTS_LIBRARY
  NAMES QSCharts
  HINTS ${QT_LIBRARY_DIR}
)

set ( QSINT_LIBRARIES ${QSINT_CORE_LIBRARY} )
list ( APPEND QSINT_LIBRARIES ${QSINT_CHARTS_LIBRARY} )

# try to guess root dir from include dir
if ( QSINT_INCLUDE_DIR )
  string ( REGEX REPLACE "(.*)/include.*" "\\1" QSINT_ROOT_DIR ${QSINT_INCLUDE_DIR} )
# try to guess root dir from library dir
elseif ( QSINT_LIBRARY )
  string ( REGEX REPLACE "(.*)/lib[/|32|64].*" "\\1" QSINT_ROOT_DIR ${QSINT_LIBRARY} )
endif ()

# handle the QUIETLY and REQUIRED arguments
include ( FindPackageHandleStandardArgs )
find_package_handle_standard_args( QSint DEFAULT_MSG QSINT_CORE_LIBRARY QSINT_CHARTS_LIBRARY QSINT_INCLUDE_DIR )

mark_as_advanced (
  QSINT_CORE_LIBRARY
  QSINT_CHARTS_LIBRARY
  QSINT_LIBRARIES
  QSINT_INCLUDE_DIR
  QSINT_INCLUDE_DIRS
  QSINT_ROOT_DIR
)

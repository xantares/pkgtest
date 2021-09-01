# - Try to find MUMPS
# Once done, this will define
#
#  MUMPS_FOUND - system has MUMPS
#  MUMPS_INCLUDE_DIRS - the MUMPS include directories
#  MUMPS_LIBRARIES - libraries to link to

# Include dir
find_path(MUMPS_INCLUDE_DIR
  NAMES dmumps_c.h smumps_c.h PATH_SUFFIXES MUMPS
)
set(MUMPS_INCLUDE_DIRS ${MUMPS_INCLUDE_DIR})

# Finally the library itself
find_library(MUMPS_LIBRARY
  NAMES dmumps
)

find_library(CMUMPS_LIBRARY
  NAMES cmumps
)

find_library(SMUMPS_LIBRARY
  NAMES smumps
)

find_library(ESMUMPS_LIBRARY
  NAMES esmumps
)

find_library(ZMUMPS_LIBRARY
  NAMES zmumps
)

find_library(MUMPS_COMMON_LIBRARY
  NAMES mumps_common
)

find_library(MUMPS_PORD_LIBRARY
  NAMES pord
)

find_library(METIS_LIBRARY NAMES metis)
find_library(SCOTCH_LIBRARY NAMES scotch)
find_library(SCOTCH_ERR_LIBRARY NAMES scotcherr)
find_library(SCALAPACK_LIBRARY NAMES scalapack)

find_package(LAPACK)

set(MUMPS_LIBRARIES ${MUMPS_LIBRARY} ${MUMPS_COMMON_LIBRARY} ${MUMPS_PORD_LIBRARY} ${METIS_LIBRARY} ${LAPACK_LIBRARIES})

if (CMUMPS_LIBRARY)
  list(APPEND MUMPS_LIBRARIES ${CMUMPS_LIBRARY})
endif ()

if (SMUMPS_LIBRARY)
  list(APPEND MUMPS_LIBRARIES ${SMUMPS_LIBRARY})
endif ()

if (ZMUMPS_LIBRARY)
  list(APPEND MUMPS_LIBRARIES ${ZMUMPS_LIBRARY})
endif ()

if (ESMUMPS_LIBRARY)
  list(APPEND MUMPS_LIBRARIES ${ESMUMPS_LIBRARY})
endif ()

if (SCOTCH_LIBRARY)
  list(APPEND MUMPS_LIBRARIES ${SCOTCH_LIBRARY} ${SCOTCH_ERR_LIBRARY})
endif ()

if (SCALAPACK_LIBRARY)
  list(APPEND MUMPS_LIBRARIES ${SCALAPACK_LIBRARY})
endif ()

find_package(MPI)
if (MPI_FOUND)
 list(APPEND MUMPS_LIBRARIES MPI::MPI_Fortran)
endif ()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MUMPS DEFAULT_MSG MUMPS_LIBRARIES MUMPS_INCLUDE_DIRS)


option (USE_QT4 "qt4" ON)
if (USE_QT4)
  find_package ( Qt4 REQUIRED QtCore QtGui)
endif ()
if ( QT4_FOUND )
  include ( ${QT_USE_FILE} )
  add_pkgtest ( qt4 EXT .cxx LIBS ${QT_LIBRARIES})
endif ()


option (USE_QSCINTILLA "qscintilla" ON)
if (USE_QSCINTILLA)
  find_package ( QScintilla )
endif ()
if ( QSCINTILLA_FOUND AND QT4_FOUND)
  add_pkgtest ( qscintilla EXT .cxx INCLUDES ${QSCINTILLA_INCLUDE_DIRS} LIBS ${QT_LIBRARIES};${QSCINTILLA_LIBRARIES})
endif ()


option (USE_QWT "qwt" ON)
if (USE_QWT)
  find_package ( Qwt )
endif ()
if ( QWT_FOUND AND QT4_FOUND)
  add_pkgtest ( qwt EXT .cxx INCLUDES ${QWT_INCLUDE_DIRS} LIBS ${QT_LIBRARIES};${QWT_LIBRARIES})
endif ()


option (USE_QSINT "qsint" ON)
if (USE_QSINT)
  find_package ( QSint )
endif ()
if ( QSINT_FOUND AND QT4_FOUND)
  add_pkgtest ( qsint EXT .cxx INCLUDES ${QSINT_INCLUDE_DIRS} LIBS ${QT_LIBRARIES};${QSINT_LIBRARIES})
endif ()


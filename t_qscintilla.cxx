#include "QtGui/qapplication.h"
#include "QtGui/qpushbutton.h"
#include "QtGui/qmainwindow.h"
#include "QtCore/qtimer.h"
#include <Qsci/qsciscintilla.h>

class ExampleWindow : public QMainWindow
{
public:
  ExampleWindow() : QMainWindow()
  {
    QsciScintilla * textEdit = new QsciScintilla;
    textEdit->setText("Hello world!");
    setCentralWidget(textEdit);
    setCentralWidget( textEdit );
  }
};


int main( int argc, char **argv )
{
  QApplication app( argc, argv );
  QTimer::singleShot(1000, &app, SLOT(quit()));
  ExampleWindow mainWin;
  mainWin.show();
  int exec = app.exec();
  return exec;
}
#include "QtGui/qapplication.h"
#include "QtGui/qpushbutton.h"
#include "QtGui/qmainwindow.h"
#include "QtCore/qtimer.h"

class ExampleWindow : public QMainWindow
{
public:
  ExampleWindow() : QMainWindow()
  {
    QPushButton *hello = new QPushButton( "Hello world!", 0 );
    hello->resize( 100, 30 );
    setCentralWidget( hello );
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
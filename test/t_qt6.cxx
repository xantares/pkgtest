#include "QtWidgets/qapplication.h"
#include "QtWidgets/qpushbutton.h"
#include "QtWidgets/qmainwindow.h"
#include "QtCore/qtimer.h"
#include <iostream>

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
  
  // test iconv
  QString src("\xc3\xa9");
  std::cout << "src=["<<src.toStdString() <<"] rsrc=["<<QString::fromLocal8Bit(src.toStdString().c_str()).toLocal8Bit().constData()<<"]"<< std::endl;

  return exec;
}

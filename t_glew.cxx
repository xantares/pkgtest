#include "widget.h"

#include <QGuiApplication>
#include <QDebug>
#include <QOpenGLContext>
#include <QWindow>
#include <QOpenGLWidget>
#include <QOpenGLShaderProgram>
#include <QApplication>
#include <QTimer>

#include <iostream>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QTimer::singleShot(2500, &app, SLOT(quit()));

    QSurfaceFormat format;
    format.setVersion(3, 3);
    format.setProfile(QSurfaceFormat::CoreProfile);
    format.setDepthBufferSize(24);
    format.setStencilBufferSize(8);
    QSurfaceFormat::setDefaultFormat(format);
    Widget w;
    w.show();

    return app.exec();
}




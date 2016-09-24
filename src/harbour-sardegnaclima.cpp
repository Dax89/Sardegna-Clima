#include <QtQuick>
#include <sailfishapp.h>
#include "weatherstorage.h"

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> application(SailfishApp::application(argc, argv));
    application->setApplicationName("harbour-sardegnaclima");

    qmlRegisterType<WeatherStorage>("harbour.sardegnaclima", 1, 0, "WeatherStorage");

    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/harbour-sardegnaclima.qml"));
    view->show();

    return application->exec();
}


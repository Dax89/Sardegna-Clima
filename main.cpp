#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "sardegnaclimaconfig.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("Material");

    QGuiApplication app(argc, argv);
    SardegnaClimaConfig scconfig;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("scconfig", &scconfig);
    engine.load(QUrl(QStringLiteral("qrc:/qml/sardegnaclima.qml")));

    return app.exec();
}

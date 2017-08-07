#include "sardegnaclimaconfig.h"
#include <QStandardPaths>

#define WEATHER_CACHE "weather_cache.json"

SardegnaClimaConfig::SardegnaClimaConfig(QObject *parent) : QObject(parent)
{

}

QString SardegnaClimaConfig::requestUrl() const
{
    return "http://www.sardegna-clima.it/stazioni/server/public_html/index.php/v1/summary";
}

qreal SardegnaClimaConfig::latitude() const
{
    return 40.065;
}

qreal SardegnaClimaConfig::longitude() const
{
    return 9.065;
}

void SardegnaClimaConfig::save(const QString &s)
{
    QFile file(this->weatherFolder().absoluteFilePath(WEATHER_CACHE));
    file.open(QFile::WriteOnly);
    file.write(s.toUtf8());
    file.close();
}

QString SardegnaClimaConfig::load()
{
    QFile file(this->weatherFolder().absoluteFilePath(WEATHER_CACHE));

    if(!file.open(QFile::ReadOnly))
        return QString();

    QString s = QString::fromUtf8(file.readAll());
    file.close();

    return s;
}

QDir SardegnaClimaConfig::weatherFolder() const
{
    return QDir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));
}

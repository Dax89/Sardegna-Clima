#include "weatherstorage.h"
#include <QStandardPaths>
#include <QFile>

const QString WeatherStorage::WEATHER_FOLDER = "weather";
const QString WeatherStorage::WEATHER_DATA = "weather_data.json";

WeatherStorage::WeatherStorage(QObject *parent) : QObject(parent)
{

}

QDir WeatherStorage::weatherFolder() const
{
    QDir datadir = QDir(QStandardPaths::writableLocation(QStandardPaths::DataLocation));

    if(!datadir.exists(WeatherStorage::WEATHER_FOLDER))
        datadir.mkpath(WeatherStorage::WEATHER_FOLDER);

    datadir.cd(WeatherStorage::WEATHER_FOLDER);
    return datadir;
}

QString WeatherStorage::load()
{
    QFile file(this->weatherFolder().absoluteFilePath(WeatherStorage::WEATHER_DATA));

    if(!file.open(QFile::ReadOnly))
        return QString();

    QString s = QString::fromUtf8(file.readAll());
    file.close();

    return s;
}

void WeatherStorage::save(const QString &data)
{
    QFile file(this->weatherFolder().absoluteFilePath(WeatherStorage::WEATHER_DATA));
    file.open(QFile::WriteOnly);
    file.write(data.toUtf8());
    file.close();
}


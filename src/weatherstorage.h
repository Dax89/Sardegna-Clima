#ifndef WEATHERSTORAGE_H
#define WEATHERSTORAGE_H

#include <QObject>
#include <QDir>

class WeatherStorage : public QObject
{
    Q_OBJECT

    public:
        explicit WeatherStorage(QObject *parent = 0);

    private:
        QDir weatherFolder() const;

    public slots:
        QString load();
        void save(const QString& data);

    private:
        static const QString WEATHER_FOLDER;
        static const QString WEATHER_DATA;
};

#endif // WEATHERSTORAGE_H

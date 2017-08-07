#ifndef SARDEGNACLIMACONFIG_H
#define SARDEGNACLIMACONFIG_H

#include <QObject>
#include <QDir>

class SardegnaClimaConfig : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString requestUrl READ requestUrl CONSTANT FINAL)
    Q_PROPERTY(qreal latitude READ latitude CONSTANT FINAL)
    Q_PROPERTY(qreal longitude READ longitude CONSTANT FINAL)

    public:
        explicit SardegnaClimaConfig(QObject *parent = nullptr);
        QString requestUrl() const;
        qreal latitude() const;
        qreal longitude() const;

    public:
        Q_INVOKABLE void save(const QString& s);
        Q_INVOKABLE QString load();

    private:
        QDir weatherFolder() const;
};

#endif // SARDEGNACLIMACONFIG_H

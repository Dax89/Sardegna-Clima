# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-sardegnaclima

CONFIG += sailfishapp

SOURCES += src/harbour-sardegnaclima.cpp \
    src/weatherstorage.cpp

OTHER_FILES += qml/harbour-sardegnaclima.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-sardegnaclima.changes.in \
    rpm/harbour-sardegnaclima.spec \
    rpm/harbour-sardegnaclima.yaml \
    translations/*.ts \
    harbour-sardegnaclima.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-sardegnaclima-de.ts

DISTFILES += \
    qml/model/WeatherStationData.qml \
    qml/model/MapsModel.qml \
    qml/js/Settings.js \
    qml/pages/map/MapPage.qml \
    qml/pages/map/MapTypePage.qml \
    qml/pages/about/AboutPage.qml \
    qml/pages/about/DevelopersPage.qml \
    qml/pages/about/ThirdPartyPage.qml \
    qml/components/about/CollaboratorsLabel.qml \
    qml/components/about/ThirdPartyLabel.qml \
    qml/pages/weatherstation/WeatherStationPage.qml \
    qml/components/weatherstation/WeatherStationLabel.qml \
    qml/js/Weather.js \
    qml/components/Arrow.qml \
    qml/components/CoverLabel.qml

RESOURCES += \
    resources.qrc

HEADERS += \
    src/weatherstorage.h


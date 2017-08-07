import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Window 2.0
import "qrc:/js/Settings.js" as Settings
import "dialogs"
import "widgets"
import "model"

ApplicationWindow
{
    id: mainwindow
    x: 900
    y: 200
    width: 380
    height: 640
    visible: true
    title: qsTr("Sardegna Clima")

    header: HeaderBar {
        id: headerbar

        onMapChanged: {
            sardiniamap.currentMap = newmap;
            Settings.set("lastmap", newmap);
            wsdata.updateMap();
        }
    }

    WeatherStationData { id: wsdata }
    WeatherStationDialog { id: wsdialog }
    AboutDialog { id: aboutdialog }

    SardiniaMap
    {
        id: sardiniamap
        anchors.fill: parent

        currentMap: {
            var map = Settings.get("lastmap");

            if(map !== false) {
                headerbar.currentIndex = wsdata.maps.indexOf(map);
                return map;
            }

            return "temp"; // Temperature by default
        }

        Component.onCompleted: {
            wsdata.sardiniaView = sardiniamap;
        }
    }

    Material.primary: "#e20123"
}

import QtQuick 2.1
import QtLocation 5.0
import QtPositioning 5.2
import Sailfish.Silica 1.0
import "../../model"

Page
{
    property WeatherStationData weatherStationData

    id: mappage

    onStatusChanged: {
        if((status === PageStatus.Active) || (weatherStationData.weatherData !== null))
            return;

        weatherStationData.sourceMap = mapview;
        weatherStationData.load();
    }

    SilicaFlickable
    {
        anchors.fill: parent

        Map
        {
            id: mapview
            gesture.enabled: true
            anchors { left: parent.left; top: parent.top; right: parent.right; bottom: parent.bottom }

            plugin: Plugin {
                name: "nokia"
                PluginParameter { name: "app_id"; value: "lMungCz5oonoPKfu258s" }
                PluginParameter { name: "token"; value: "DzjRZWo2d6offLNW2xI0Yg" }
                PluginParameter { name: "proxy"; value: "system" }
            }

            Component.onCompleted: {
                mapview.center = QtPositioning.coordinate(40.1641, 9.04058);
                mapview.zoomLevel = 8;
            }

            MouseArea { anchors.fill: parent }
        }

        Label
        {
            id: lblmaptype
            anchors { left: parent.left; top: parent.top; right: btnmenu.right; leftMargin: Theme.paddingSmall; topMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
            text: qsTr("%1 map").arg(weatherStationData.currentMap.text);
            font.pixelSize: Theme.fontSizeExtraSmall
            elide: Text.ElideRight
            color: "black"
        }

        Label
        {
            anchors { left: parent.left; top: lblmaptype.bottom; right: btnmenu.right; leftMargin: Theme.paddingSmall; topMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }

            text: {
                if(weatherStationData.lastUpdate !== null) {
                    var date = new Date(weatherStationData.lastUpdate);
                    return qsTr("Updated on %1").arg(date.toLocaleString(null, Locale.ShortFormat));
                }

                return "";
            }

            visible: weatherStationData.lastUpdate !== null
            font.pixelSize: Theme.fontSizeTiny
            elide: Text.ElideRight
            color: "black"
        }

        IconButton
        {
            id: btnmenu
            anchors { right: parent.right; top: parent.top }
            width: Theme.itemSizeSmall
            height: Theme.itemSizeSmall
            icon.source: "image://theme/icon-m-menu?black"
            onClicked: pageStack.push(Qt.resolvedUrl("MapTypePage.qml"), { "weatherStationData": weatherStationData })
        }

        IconButton
        {
            id: btnrefresh
            anchors { right: parent.right; top: btnmenu.bottom; topMargin: Theme.paddingSmall }
            width: Theme.itemSizeSmall
            height: Theme.itemSizeSmall
            icon.source: "image://theme/icon-m-refresh?black"
            onClicked: weatherStationData.load(true)
        }

        IconButton
        {
            id: btnlocalize
            anchors { right: parent.right; top: btnrefresh.bottom; topMargin: Theme.paddingSmall }
            width: Theme.itemSizeSmall
            height: Theme.itemSizeSmall
            icon.source: "image://theme/icon-m-gps?black"
            onClicked: weatherStationData.localize()
        }
    }
}

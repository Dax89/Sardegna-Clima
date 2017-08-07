import QtQuick 2.0
import QtQuick.Controls 2.0
import QtLocation 5.0
import QtPositioning 5.0
import "../model"

Map
{
    readonly property var currentModel: wsdata.maps.byValue(currentMap)
    property string currentMap

    id: sardiniaview
    center: QtPositioning.coordinate(scconfig.latitude, scconfig.longitude)
    zoomLevel: 8

    plugin: Plugin {
        name: "here"
        locales: [ "it_IT", "en_US" ]
        PluginParameter { name: "here.app_id"; value: "<PLACEHOLDER>" }
        PluginParameter { name: "here.token";  value: "<PLACEHOLDER>" }
        PluginParameter { name: "here.proxy";  value: "system" }
    }

    Label
    {
        anchors { left: parent.left; top: parent.top; right: parent.right; margins: 4 }

        text: {
            if(wsdata.lastUpdate === null)
                return "";

            var date = new Date(wsdata.lastUpdate);
            return qsTr("Updated on %1").arg(date.toLocaleString(null, Locale.ShortFormat));
        }

        visible: wsdata.lastUpdate !== null
        elide: Text.ElideRight
        color: "black"
    }
}

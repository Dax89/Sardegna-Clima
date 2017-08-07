import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import "qrc:/js/Weather.js" as Weather

Popup
{
    readonly property color materialColor: Material.color(Material.primary)

    function details(weatherstation) {
        lbltitle.text = weatherstation.name;

        lbllatitude.text = weatherstation.latitude + "°";
        lbllongitude.text = weatherstation.longitude + "°";
        lbltempmax.text = wsdata.value(weatherstation, "tempmax");
        lbltempmin.text = wsdata.value(weatherstation, "tempmin");
        lbldewpoint.text = wsdata.value(weatherstation, "dp");
        lblhumidity.text = wsdata.value(weatherstation, "hum");
        lblwindspeed.text = wsdata.value(weatherstation, "wspeed");
        lblwinddirection.text = weatherstation.measure["wspeed"] === 0 ? qsTr("No Wind") : Weather.windCompass(weatherstation.measure["dir"])
        lblrain.text = wsdata.value(weatherstation, "rain");
        lblpressure.text = wsdata.value(weatherstation, "bar");

        open();
    }

    id: weatherstationdialog
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    x: (sardiniamap.width - width) / 2
    y: (sardiniamap.height - height) / 2

    GridLayout
    {
        anchors.fill: parent
        columns: 2

        Label { id: lbltitle; font { bold: true; pixelSize: 16 } horizontalAlignment: Text.AlignHCenter; Layout.columnSpan: 2; Layout.fillWidth: true; color: materialColor }
        Item { height: 10; Layout.columnSpan: 2; Layout.fillWidth: true }

        // Position Area
        Label { text: qsTr("Position"); font.bold: true; horizontalAlignment: Text.AlignRight; Layout.columnSpan: 2; Layout.fillWidth: true; color: materialColor }
        Rectangle { height: 1; color: materialColor; Layout.columnSpan: 2; Layout.fillWidth: true }

        Label { text: qsTr("Latitude:"); color: materialColor }
        Label { id: lbllatitude }

        Label { text: qsTr("Longitude:"); color: materialColor }
        Label { id: lbllongitude }

        Item { height: 5; Layout.columnSpan: 2; Layout.fillWidth: true }

        // Temperature Area
        Label { text: qsTr("Temperature"); font.bold: true; horizontalAlignment: Text.AlignRight; Layout.columnSpan: 2; Layout.fillWidth: true; color: materialColor }
        Rectangle { height: 1; color: materialColor; Layout.columnSpan: 2; Layout.fillWidth: true }

        Label { text: qsTr("Max Temperature:"); color: materialColor }
        Label { id: lbltempmax }

        Label { text: qsTr("Min Temperature:"); color: materialColor }
        Label { id: lbltempmin }

        Item { height: 5; Layout.columnSpan: 2; Layout.fillWidth: true }


        // Humidity Area
        Label { text: qsTr("Humidity"); font.bold: true; horizontalAlignment: Text.AlignRight; Layout.columnSpan: 2; Layout.fillWidth: true; color: materialColor }
        Rectangle { height: 1; color: materialColor; Layout.columnSpan: 2; Layout.fillWidth: true }

        Label { text: qsTr("Dew Point:"); color: materialColor }
        Label { id: lbldewpoint }

        Label { text: qsTr("Humidity:"); color: materialColor }
        Label { id: lblhumidity }

        Item { height: 10; Layout.columnSpan: 2; Layout.fillWidth: true }

        // Wind Area
        Label { text: qsTr("Wind"); font.bold: true; horizontalAlignment: Text.AlignRight; Layout.columnSpan: 2; Layout.fillWidth: true; color: materialColor }
        Rectangle { height: 1; color: materialColor; Layout.columnSpan: 2; Layout.fillWidth: true }

        Label { text: qsTr("Wind Speed:"); color: materialColor }
        Label { id: lblwindspeed }

        Label { text: qsTr("Wind Direction:"); color: materialColor }
        Label { id: lblwinddirection }

        Item { height: 10; Layout.columnSpan: 2; Layout.fillWidth: true }

        // Other Area
        Label { text: qsTr("Other"); font.bold: true; horizontalAlignment: Text.AlignRight; Layout.columnSpan: 2; Layout.fillWidth: true; color: materialColor }
        Rectangle { height: 1; color: materialColor; Layout.columnSpan: 2; Layout.fillWidth: true }

        Label { text: qsTr("Rain:"); color: materialColor }
        Label { id: lblrain }

        Label { text: qsTr("Pressure:"); color: materialColor }
        Label { id: lblpressure }
    }
}

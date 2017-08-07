import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Popup
{
    id: aboutdialog
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    x: (sardiniamap.width - width) / 2
    y: (sardiniamap.height - height) / 2

    ColumnLayout
    {
        anchors.fill: parent
        spacing: 10
        Layout.alignment: Qt.AlignHCenter

        Image
        {
            source: "qrc:///res/app.png"
            fillMode: Image.PreserveAspectFit
            sourceSize { width: Math.min(128, sardiniamap.width * 0.2) }

            Layout.fillWidth: true
        }

        Label
        {
            text: wsdata.applicationName + " " + wsdata.applicationVersion
            font { bold: true; pixelSize: 18 }
            horizontalAlignment: Text.AlignHCenter

            Layout.fillWidth: true
        }

        Label
        {
            text: qsTr("Unofficial android client for SardegnaClima website")
            font { italic: true; pixelSize: 12 }
            horizontalAlignment: Text.AlignHCenter

            Layout.fillWidth: true
        }
    }
}

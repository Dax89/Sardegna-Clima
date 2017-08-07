import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ToolBar
{
    property alias currentIndex: cbxmaps.currentIndex

    signal mapChanged(string newmap)

    id: headerbar

    Menu
    {
        id: mainmenu
        y: tbmenu.height
        x: parent.width

        MenuItem { text: qsTr("Update"); onClicked: wsdata.load() }
        MenuItem { text: qsTr("Localize"); onClicked: wsdata.localize() }
        MenuItem { text: qsTr("About"); onClicked: aboutdialog.open() }
    }

    RowLayout
    {
        anchors { fill: parent; leftMargin: 6 }

        ComboBox {
            id: cbxmaps
            displayText: wsdata.maps.elements[currentIndex].text
            model: wsdata.maps.elements

            delegate: ItemDelegate {
                width: cbxmaps.width
                text: modelData.text
                onClicked: mapChanged(modelData.value)
            }

            Layout.fillWidth: true
        }

        ImageToolButton { id: tbmenu; iconSource: "qrc:///res/menu.png"; onClicked: mainmenu.visible ? mainmenu.close() : mainmenu.open() }
    }
}

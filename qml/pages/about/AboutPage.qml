import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../model"

Page
{
    id: aboutpage

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: content.height

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("GitHub Repository")
                onClicked: Qt.openUrlExternally("https://github.com/Dax89/harbour-sardegnaclima")
            }

            MenuItem
            {
                text: qsTr("Report an Issue")
                onClicked: Qt.openUrlExternally("https://github.com/Dax89/harbour-sardegnaclima/issues")
            }
        }

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader
            {
                id: pageheader
                title: qsTr("About Sardegna Clima")
            }

            Image
            {
                id: vclogo
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                width: Theme.iconSizeLarge
                height: Theme.iconSizeLarge
                source: "qrc:///res/harbour-sardegnaclima.png"
            }

            Column
            {
                anchors { left: parent.left; right: parent.right }

                Label
                {
                    id: scswname
                    anchors { left: parent.left; right: parent.right }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pixelSize: Theme.fontSizeLarge
                    text: "Sardegna Clima"
                }

                Label
                {
                    id: scinfo
                    anchors { left: parent.left; right: parent.right }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                    text: qsTr("A local forecast weather application for SailfishOS")
                }

                Label
                {
                    id: scversion
                    anchors { left: parent.left; right: parent.right }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                    text: qsTr("Version") + " 1.0"
                }

                Label
                {
                    id: sccopyright
                    anchors { left: parent.left; right: parent.right }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeExtraSmall
                    wrapMode: Text.WordWrap
                    color: Theme.secondaryColor
                    text: qsTr("Sardegna Clima is distributed under the GPLv3 license")
                }
            }

            Column
            {
                anchors { left: parent.left; right: parent.right; topMargin: Theme.paddingExtraLarge }
                spacing: Theme.paddingSmall

                Button
                {
                    id: licensebutton
                    text: qsTr("License")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: Qt.openUrlExternally("https://raw.githubusercontent.com/Dax89/harbour-sardegnaclima/master/LICENSE")
                }

                Button
                {
                    id: developersbutton
                    text: qsTr("Developers")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: pageStack.push(Qt.resolvedUrl("DevelopersPage.qml"))
                }

                Button
                {
                    id: thirdpartybutton
                    text: qsTr("Third Party")
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: pageStack.push(Qt.resolvedUrl("ThirdPartyPage.qml"))
                }
            }
        }
    }
}

import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../components/about"

Page
{
    id: developerspage
    allowedOrientations: Orientation.Portrait

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: content.height

        VerticalScrollDecorator { flickable: parent }

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader
            {
                id: pageheader
                title: qsTr("Developers")
            }

            CollaboratorsLabel {
                title: qsTr("Author");
                labeldata: [ "Antonio Davide Trogu" ]
            }

            /*
            CollaboratorsLabel {
                title: qsTr("Contributor");
                labeldata: [ "" ]
            }
            */

            CollaboratorsLabel {
                title: qsTr("Icon Designer");
                labeldata: [ "Antonio Davide Trogu" ]
            }
        }
    }
}

import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../components/about"

Page
{
    id: thirdpartypage
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
                title: qsTr("Third Party")
            }

            ThirdPartyLabel
            {
                title: "Sardegna Clima"
                copyright: qsTr("Custom")
                licenselink: "http://www.sardegna-clima.it/index.php/disclaimer"
                link: "http://www.sardegna-clima.it"
            }
        }
    }
}

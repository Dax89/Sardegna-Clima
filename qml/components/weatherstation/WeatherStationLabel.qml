import QtQuick 2.1
import Sailfish.Silica 1.0

Row
{
    property alias caption: lblcaption.text
    property alias value: lblvalue.text
    property alias captionColor: lblcaption.color
    property alias valueColor: lblvalue.color

    id: weatherstationlabel
    x:  Theme.horizontalPageMargin
    width: (parent ? parent.width : Screen.width) - (x * 2)
    height: Theme.itemSizeSmall

    Label
    {
        id: lblcaption
        width: (parent.width / 2) - Theme.horizontalPageMargin
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.highlightColor
    }

    Label
    {
        id: lblvalue
        width: (parent.width / 2) - Theme.horizontalPageMargin
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.primaryColor
    }
}

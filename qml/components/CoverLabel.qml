import QtQuick 2.1
import Sailfish.Silica 1.0

Row
{
    property alias caption: lblcaption.text
    property alias value: lblvalue.text
    property alias captionColor: lblcaption.color
    property alias valueColor: lblvalue.color

    id: weatherstationlabel
    width: (parent ? parent.width : Screen.width) - (x * 2)
    height: Math.max(lblcaption.contentHeight, lblvalue.contentHeight)

    Label
    {
        id: lblcaption
        width: (parent.width / 2)
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: Theme.fontSizeExtraSmall
        color: Theme.highlightColor
    }

    Label
    {
        id: lblvalue
        width: (parent.width / 2)
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.pixelSize: Theme.fontSizeExtraSmall
        color: Theme.primaryColor
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.0

ToolButton
{
    property string iconSource

    id: imagetoolbutton

    Image
    {
        anchors { fill: parent; margins: 12 }
        fillMode: Image.PreserveAspectFit
        source: iconSource
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtLocation 5.0
import "qrc:/js/Weather.js" as Weather

MapQuickItem
{
    property bool displayArrow: false
    property int stationIdx: -1
    property string value
    property color color

    signal detailsRequested()

    id: weatherstation

    sourceItem: Rectangle {
        id: content
        color: weatherstation.displayArrow ? "transparent" : weatherstation.color
        border { width: 1; color: weatherstation.displayArrow ? "transparent" : "black" }
        height: lblhiddenvalue.contentHeight
        width: lblhiddenvalue.contentWidth + (8 * 2)
        radius: width * 0.1

        Arrow {
            anchors.fill: parent
            visible: weatherstation.displayArrow && (weatherstation.value > 0)
            color: weatherstation.color
            rotation: weatherstation.displayArrow ? Weather.windDirection(weatherstation.value) : 0
        }

        Label {
            id: lblvalue
            height: parent.height
            text: weatherstation.value
            visible: !weatherstation.displayArrow
            anchors { fill: parent; leftMargin: 4; rightMargin: 4 }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 12

            color: {
                var o = (((weatherstation.color.r * 255) * 299) +
                         ((weatherstation.color.g * 255) * 587) +
                         ((weatherstation.color.b * 255) * 114)) / 1000;

                return o > 125 ? "black" : "white";
            }
        }

        Label { id: lblhiddenvalue; visible: false; text: weatherstation.value; font: lblvalue.font }
        MouseArea { anchors.fill: parent; onClicked: detailsRequested() }
    }
}

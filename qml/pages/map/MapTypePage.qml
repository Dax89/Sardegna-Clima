import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../model"

Page
{
    property WeatherStationData weatherStationData

    id: maptypepage

    SilicaListView
    {
        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("About Sardegna Clima")
                onClicked: pageStack.push(Qt.resolvedUrl("../about/AboutPage.qml"))
            }
        }

        id: lvmaps
        anchors.fill: parent
        header: PageHeader { title: qsTr("Map Type") }

        section.property: "category"
        section.delegate: SectionHeader { text: section }

        model: weatherStationData.maps.elements

        delegate: ListItem {
            width: parent.width
            contentHeight: Theme.itemSizeSmall

            Label {
                x: Theme.horizontalPageMargin
                width: parent.width - (x * 2)
                height: parent.height
                verticalAlignment: Text.AlignVCenter

                color: {
                    if(weatherStationData.currentMap.value === model.modelData.value)
                        return Theme.highlightColor;

                    return Theme.primaryColor;
                }

                text: {
                    if(model.modelData.unit.length > 0)
                        return model.modelData.text + " [" + model.modelData.unit + "]";

                    return model.modelData.text;
                }
            }

            onClicked: {
                weatherStationData.currentMap = model.modelData;
                pageStack.pop();
            }
        }

        VerticalScrollDecorator { }
    }
}

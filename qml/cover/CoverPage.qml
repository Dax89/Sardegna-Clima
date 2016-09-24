import QtQuick 2.1
import Sailfish.Silica 1.0
import "../components"
import "../model"
import "../js/Weather.js" as Weather

CoverBackground
{
    property WeatherStationData weatherStationData

    id: coverpage

    Column
    {
        id: colstatus
        anchors { top: parent.top; left: parent.left; right: parent.right; topMargin: Theme.paddingMedium; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingMedium }
        spacing: Theme.paddingSmall

        Item
        {
            width: parent.width
            height: Math.max(lblvalue.contentHeight, lbltitle.contentHeight)

            Label
            {
                id: lblvalue
                anchors { left: parent.left; right: lbltitle.left; rightMargin: Theme.paddingSmall }
                font.pixelSize: Theme.fontSizeLarge
                font.family: Theme.fontFamilyHeading

                text: {
                    if(!weatherStationData.weatherData)
                        return qsTr("No\ndata");

                    return weatherStationData.userValue(weatherStationData.nearestWeatherStation, "temp");
                }
            }

            Label
            {
                id: lbltitle
                anchors { right: parent.right; verticalCenter: lblvalue.verticalCenter }
                color: Theme.highlightColor
                font { pixelSize: Theme.fontSizeTiny; family: Theme.fontFamilyHeading; weight: Font.Light }
                lineHeight: 0.8
                horizontalAlignment: Text.AlignRight
                truncationMode: TruncationMode.Fade

                text: {
                    if(!weatherStationData.weatherData)
                        return qsTr("No\ndata");

                    var s = weatherStationData.nearestWeatherStation.name.split("-");
                    return qsTr("%1\nstation").arg(s[1].trim());
                }
            }
        }

        CoverLabel
        {
            caption: qsTr("Max")

            value: {
                if(!weatherStationData.weatherData)
                    return qsTr("No data");

                return weatherStationData.userValue(weatherStationData.nearestWeatherStation, "tempmax");
            }
        }

        CoverLabel
        {
            caption: qsTr("Min")

            value: {
                if(!weatherStationData.weatherData)
                    return qsTr("No data");

                return weatherStationData.userValue(weatherStationData.nearestWeatherStation, "tempmin");
            }
        }

        CoverLabel
        {
            caption: qsTr("Rain")

            value: {
                if(!weatherStationData.weatherData)
                    return qsTr("No data");

                return weatherStationData.userValue(weatherStationData.nearestWeatherStation, "rain");
            }
        }

        CoverLabel
        {
            caption: qsTr("Wind")

            value: {
                if(!weatherStationData.weatherData)
                    return qsTr("No data");

                var wspeed = weatherStationData.userValue(weatherStationData.nearestWeatherStation, "wspeed");

                if(!wspeed)
                    return qsTr("No");

                var dir = weatherStationData.userValue(weatherStationData.nearestWeatherStation, "dir");
                return Weather.windCompass(dir);
            }
        }

        CoverLabel
        {
            caption: qsTr("Humidity")

            value: {
                if(!weatherStationData.weatherData)
                    return qsTr("No data");

                return weatherStationData.userValue(weatherStationData.nearestWeatherStation, "hum");
            }
        }

        CoverLabel
        {
            caption: qsTr("Pressure")

            value: {
                if(!weatherStationData.weatherData)
                    return qsTr("No data");

                return weatherStationData.userValue(weatherStationData.nearestWeatherStation, "bar");
            }
        }
    }

    CoverActionList
    {
        id: coveraction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: weatherStationData.load(true)
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-location"
            onTriggered: weatherStationData.localize(true)
        }
    }
}

import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../components/weatherstation"
import "../../model"
import "../../js/Weather.js" as Weather

Page
{
    property WeatherStationData weatherStationData
    property int stationIdx

    readonly property var weatherStation: stationIdx > -1 ? weatherStationData.weatherData[stationIdx] : null

    id: weatherstationpage

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: content.height

        Column
        {
            id: content
            width: parent.width

            PageHeader { title: weatherStation ? weatherStation.name : "" }

            Label
            {
                id: lbltemperature
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font { pixelSize: Theme.fontSizeHuge; family: Theme.fontFamilyHeading; bold: true }
                text: weatherStation ? weatherStationData.userValue(weatherStation, "temp") : ""
            }

            SectionHeader { text: qsTr("Position") }

            WeatherStationLabel {
                caption: qsTr("Latitude")
                value: weatherStation ? weatherStation.latitude : 0
            }

            WeatherStationLabel {
                caption: qsTr("Longitude")
                value: weatherStation ? weatherStation.longitude : 0
            }

            SectionHeader { text: qsTr("Temperature") }

            WeatherStationLabel {
                caption: qsTr("Max")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "tempmax") : 0
                valueColor: Theme.highlightColor
            }

            WeatherStationLabel {
                caption: qsTr("Min")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "tempmin") : 0
                valueColor: Theme.secondaryHighlightColor
            }

            SectionHeader { text: qsTr("Humidity") }

            WeatherStationLabel {
                caption: qsTr("Dew Point")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "dp") : 0
            }

            WeatherStationLabel {
                caption: qsTr("Humidity")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "hum") : 0
            }

            SectionHeader { text: qsTr("Wind") }

            WeatherStationLabel {
                caption: qsTr("Wind Speed")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "wspeed") : 0
            }

            WeatherStationLabel {
                caption: qsTr("Wind Direction")

                value: {
                    if(!weatherStation || !weatherStation.measure["wspeed"])
                        return qsTr("No Wind");

                     return Weather.windCompass(weatherStation.measure["dir"]);
                }

            }
            SectionHeader { text: qsTr("Other") }

            WeatherStationLabel {
                caption: qsTr("Rain")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "rain") : 0
            }

            WeatherStationLabel {
                caption: qsTr("Pressure")
                value: weatherStation ? weatherStationData.userValue(weatherStation, "bar") : 0
            }
        }
    }
}

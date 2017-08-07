import QtQuick 2.1

Item
{
    property list<QtObject> elements: [ QtObject { readonly property string category: qsTr("Temperature")
                                                   readonly property string text: qsTr("Mid Temperature")
                                                   readonly property string value: "temp"
                                                   readonly property string defaultValue: qsTr("No Data")
                                                   readonly property string unit: "°C" },

                                        QtObject { readonly property string category: qsTr("Temperature")
                                                   readonly property string text: qsTr("Max Temperature")
                                                   readonly property string value: "tempmax"
                                                   readonly property string defaultValue: qsTr("No Data")
                                                   readonly property string unit: "°C" },

                                        QtObject { readonly property string category: qsTr("Temperature")
                                                   readonly property string text: qsTr("Min Temperature")
                                                   readonly property string value: "tempmin"
                                                   readonly property string defaultValue: qsTr("No Data")
                                                   readonly property string unit: "°C" },

                                        QtObject { readonly property string category: qsTr("Humidity")
                                                   readonly property string text: qsTr("Humidity")
                                                   readonly property string value: "hum"
                                                   readonly property string defaultValue: qsTr("No Data")
                                                   readonly property string unit: "%" },

                                        QtObject { readonly property string category: qsTr("Humidity")
                                                   readonly property string text: qsTr("Dew Point")
                                                   readonly property string value: "dp"
                                                   readonly property string defaultValue: qsTr("No Data")
                                                   readonly property string unit: "°C" },

                                        QtObject { readonly property string category: qsTr("Wind")
                                                   readonly property string text: qsTr("Wind Speed")
                                                   readonly property string value: "wspeed"
                                                   readonly property string defaultValue: qsTr("No Wind")
                                                   readonly property string unit: "Km/h" },

                                        QtObject { readonly property string category: qsTr("Wind")
                                                   readonly property string text: qsTr("Wind Direction")
                                                   readonly property string value: "dir"
                                                   readonly property string defaultValue: qsTr("No Wind")
                                                   readonly property string unit: "" },

                                        QtObject { readonly property string category: qsTr("Other")
                                                   readonly property string text: qsTr("Rain")
                                                   readonly property string value: "rain"
                                                   readonly property string defaultValue: qsTr("No Rain")
                                                   readonly property string unit: "mm" },

                                        QtObject { readonly property string category: qsTr("Other")
                                                   readonly property string text: qsTr("Pressure")
                                                   readonly property string value: "bar"
                                                   readonly property string defaultValue: qsTr("No Data")
                                                   readonly property string unit: "mb" } ]

    function indexOf(value) {
        for(var i = 0; i < elements.length; i++) {
            if(elements[i].value !== value)
                continue;

            return i;
        }

        console.warn("Map " + value + " not found");
        return -1;
    }

    function byValue(value) {
        for(var i = 0; i < elements.length; i++) {
            if(elements[i].value !== value)
                continue;

            return elements[i];
        }

        console.warn("Map " + value + " not found");
        return null;
    }
}

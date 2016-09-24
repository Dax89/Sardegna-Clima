import QtQuick 2.1
import QtLocation 5.0
import QtPositioning 5.2
import Sailfish.Silica 1.0
import harbour.sardegnaclima 1.0
import "../components"
import "../js/Weather.js" as Weather
import "../js/Settings.js" as Settings

Item
{
    readonly property string requestUrl: "http://www.sardegna-clima.it/stazioni/server/public_html/index.php/v1/summary"
    property WeatherStorage weatherStorage: WeatherStorage { }
    property MapsModel maps: MapsModel {  }
    property var weatherData: null
    property Map sourceMap: null
    property var lastUpdate: null
    property var nearestWeatherStation: null

    property var currentMap: {
        if(!maps)
            return null;

        var value = Settings.get("lastmap");

        if(value !== false) {
            var map = maps.byValue(value);

            if(map)
                return map;
        }

        return maps.elements[0];
    }

    id: weatherstationdata
    onSourceMapChanged: updateMap()
    onWeatherDataChanged: updateMap()

    onCurrentMapChanged: {
        if(currentMap)
            Settings.set("lastmap", currentMap.value);

        updateMap();
    }

    function userValue(weatherstation, mapvalue) {
        var map = currentMap;

        if(map.value !== mapvalue)
            map = maps.byValue(mapvalue);

        if(!map)
            return "No map";

        var value = weatherstation.measure[mapvalue];

        if(!value) { // Updating...
            if(map.value === "dir")
                return -1;

            return map.defaultValue;
        }

        if(map.value === "dir")
            return value;

        if(map.unit.length > 0)
            return value + " " + map.unit;

        return value;
    }

    function value(weatherstation) {
        return userValue(weatherstation, currentMap.value);
    }

    function color(weatherstation) {
        var value = weatherstation.measure[currentMap.value];

        if(!value) // Updating...
            return Theme.primaryColor;

        if((currentMap.value === "temp") || (currentMap.value === "dp"))
            return Weather.temperature(value);
        else if(currentMap.value === "tempmin")
            return Weather.temperatureMin(value);
        else if(currentMap.value === "tempmax")
            return Weather.temperatureMax(value);
        else if(currentMap.value === "rain")
            return Weather.rain(value);
        else if(currentMap.value === "hum")
            return Weather.humidity(value);
        else if(currentMap.value === "wspeed")
            return Weather.windColor(value);
        else if(currentMap.value === "dir")
            return Weather.windColor(weatherstation.measure["wspeed"]);

        return Theme.secondaryHighlightColor;
    }

    function updateMap() {
        if(!weatherData || !sourceMap || !currentMap)
            return;

        sourceMap.clearMapItems();

        weatherData.forEach(function(weatherstation, index) {
            var wsobj = weatherstationcomponent.createObject(sourceMap)
            wsobj.stationIdx = index;
            wsobj.displayArrow = (currentMap && (currentMap.value === "dir"));
            wsobj.coordinate = QtPositioning.coordinate(weatherstation.latitude, weatherstation.longitude);
            wsobj.value = weatherstationdata.value(weatherstation);
            wsobj.color = weatherstationdata.color(weatherstation);
            sourceMap.addMapItem(wsobj);
        });
    }

    function load(onlineonly) {
        if(onlineonly !== true) {
            var localdata = weatherStorage.load();

            if(localdata.length > 0)
                weatherData = JSON.parse(localdata);

            var lastupdate = Settings.get("lastupdate");

            if(lastupdate !== false)
                lastUpdate = new Date(parseFloat(lastupdate));

            var nearestws = Settings.get("nearestws");

            if(nearestws !== false) {
                var ws = positionsource.nearestWeatherStation(positionsource.position.coordinate);

                if(ws)
                    weatherstationdata.nearestWeatherStation = ws;
            }
        }

        var req = new XMLHttpRequest();

        req.onreadystatechange = function() {
            if(req.readyState === XMLHttpRequest.DONE) {
                weatherData = JSON.parse(req.responseText);
                weatherStorage.save(req.responseText);

                lastUpdate = Date.now();
                Settings.set("lastupdate", lastUpdate);

                var nearestws = positionsource.nearestWeatherStation(positionsource.position.coordinate);

                if(!nearestws)
                    return;

                Settings.set("nearestws", nearestws.id);
            }
        }

        req.open("GET", requestUrl);
        req.send();
    }

    function localize(ignorezoom) {
        timnearestws.zoom = (ignorezoom === true) ? false : true;

        positionsource.update();
        timnearestws.start();
    }

    PositionSource {
        function distance(lat1, lon1, lat2, lon2, unit) { // http://www.geodatasource.com/developers/javascript
            var radlat1 = Math.PI * lat1 / 180;
            var radlat2 = Math.PI * lat2 / 180;
            var theta = lon1 - lon2;
            var radtheta = Math.PI * theta / 180;
            var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);

            dist = Math.acos(dist);
            dist = dist * 180 / Math.PI;
            dist = dist * 60 * 1.1515;

            if (unit === "K")
                dist = dist * 1.609344;

            if (unit === "N")
                dist = dist * 0.8684;

            return dist;
        }

        function nearestWeatherStation(coordinate) {
            if(!weatherData)
                return null;

            var nearws = null;
            var mindistance = 0;

            for(var i = 0; i < weatherData.length; i++) {
                var ws = weatherData[i];
                var d = distance(ws.latitude, ws.longitude, coordinate.latitude, coordinate.longitude);

                if(!nearws || (d < mindistance)) {
                    mindistance = d;
                    nearws = ws;
                }
            }

            return nearws;
        }

        id: positionsource
        preferredPositioningMethods: PositionSource.AllPositioningMethods
    }

    Component {
        id: weatherstationcomponent

        MapQuickItem {
            property bool displayArrow: false
            property string value
            property string color
            property int stationIdx

            id: weatherstationitem
            anchorPoint: Qt.point(content.width / 4, content.height / 4)
            opacity: 0.8

            sourceItem: Rectangle {
                id: content
                color: weatherstationitem.displayArrow ? "transparent" : weatherstationitem.color
                border { width: 1; color: weatherstationitem.displayArrow ? "transparent" : "black" }
                width: lblhiddenvalue.contentWidth + (Theme.paddingSmall * 2)
                height: Theme.fontSizeExtraSmall
                radius: width * 0.1

                Arrow {
                    anchors.fill: parent
                    visible: weatherstationitem.displayArrow && (weatherstationitem.value > 0)
                    color: weatherstationitem.color
                    rotation: weatherstationitem.displayArrow ? Weather.windDirection(weatherstationitem.value) : 0
                }

                Label {
                    id: lblvalue
                    visible: !weatherstationitem.displayArrow
                    anchors { fill: parent; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    height: parent.height
                    text: weatherstationitem.value
                    font.pixelSize: Theme.fontSizeTiny
                    color: "black"
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("../pages/weatherstation/WeatherStationPage.qml"), { "weatherStationData": weatherstationdata,
                                                                                                           "stationIdx": weatherstationitem.stationIdx });
                    }
                }

                Label { id: lblhiddenvalue; visible: false; text: weatherstationitem.value; font.pixelSize: Theme.fontSizeTiny; }
            }
        }
    }

    Timer
    {
        property bool zoom: true

        id: timnearestws
        interval: 1000
        running: false

        onTriggered: {
            var nearestws = positionsource.nearestWeatherStation(positionsource.position.coordinate);

            if(!nearestws || !sourceMap)
                return;

            weatherstationdata.nearestWeatherStation = nearestws;

            if(zoom)
            {
                sourceMap.center = QtPositioning.coordinate(nearestws.latitude, nearestws.longitude);
                sourceMap.zoomLevel = sourceMap.maximumZoomLevel / 2;
            }

            Settings.set("nearestws", nearestws.id);
        }
    }
}

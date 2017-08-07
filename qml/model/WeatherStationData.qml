import QtQuick 2.0
import QtLocation 5.0
import QtPositioning 5.0
import "qrc:/js/Weather.js" as Weather
import "qrc:/js/Settings.js" as Settings

Item
{
    readonly property string applicationName: "Sardegna Clima"
    readonly property string applicationVersion: "1.0"

    property MapsModel maps: MapsModel { }
    property var wsComponent: null
    property var nearestWeatherStation: null
    property var weatherData: null
    property var lastUpdate: null
    property Map sardiniaView: null

    function updateMap() {
        if(!weatherData || !sardiniaView)
            return;

        sardiniaView.clearMapItems();

        weatherData.forEach(function(weatherstation, index) {
            var wsobj = wsComponent.createObject(sardiniaView)
            wsobj.stationIdx = index;
            wsobj.displayArrow = (sardiniaView.currentMap && (sardiniaView.currentMap === "dir"));
            wsobj.coordinate = QtPositioning.coordinate(weatherstation.latitude, weatherstation.longitude);
            wsobj.value = wsdata.value(weatherstation);
            wsobj.color = wsdata.color(weatherstation);

            wsobj.detailsRequested.connect(function() { wsdialog.details(weatherstation); });
            sardiniaView.addMapItem(wsobj);
        });
    }

    function load(onlineupdate) {
        var localdata = scconfig.load();

        if(localdata.length > 0) {
            weatherData = JSON.parse(localdata);
            updateMap();
        }

        var lastupdate = Settings.get("lastupdate");

        if(lastupdate !== false)
            lastUpdate = new Date(parseFloat(lastupdate));

        if(onlineupdate !== false) {
            var req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === XMLHttpRequest.DONE) {
                    weatherData = JSON.parse(req.responseText);
                    lastUpdate = Date.now();

                    Settings.set("lastupdate", lastUpdate);
                    scconfig.save(req.responseText);
                    updateMap();

                    var nearestws = positionsource.nearestWeatherStation(positionsource.position.coordinate);

                    if(!nearestws)
                        return;

                    Settings.set("nearestws", nearestws.id);
                }
            }

            req.open("GET", scconfig.requestUrl);
            req.send();
        }
    }

    function value(weatherstation, mapvalue) {
        var mapmodel = sardiniaView.currentModel;

        if(mapvalue && mapvalue !== mapmodel.value)
            mapmodel = maps.byValue(mapvalue);

        var value = weatherstation.measure[mapmodel.value];

        if(!value) { // Updating...
            if(mapmodel.value === "dir")
                return -1;

            return mapmodel.defaultValue;
        }

        if(mapmodel.value === "dir")
            return value;

        if(mapmodel.unit.length > 0)
            return value + " " + mapmodel.unit;

        return value;
    }

    function color(weatherstation) {
        var currentmap = sardiniaView.currentMap;
        var value = weatherstation.measure[currentmap];

        if(!value) // Updating...
            return "white";

        if((currentmap === "temp") || (currentmap === "dp"))
            return Weather.temperature(value);
        else if(currentmap === "tempmin")
            return Weather.temperatureMin(value);
        else if(currentmap === "tempmax")
            return Weather.temperatureMax(value);
        else if(currentmap === "rain")
            return Weather.rain(value);
        else if(currentmap === "hum")
            return Weather.humidity(value);
        else if(currentmap === "wspeed")
            return Weather.windColor(value);
        else if(currentmap === "dir")
            return Weather.windColor(weatherstation.measure["wspeed"]);

        return "white";
    }

    function localize(ignorezoom) {
        timnearestws.zoom = (ignorezoom === true) ? false : true;

        positionsource.update();
        timnearestws.start();
    }

    id: wsdata

    Component.onCompleted: {
        wsComponent = Qt.createComponent("../widgets/WeatherStation.qml");
        load(false);
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

    Timer {
        property bool zoom: true

        id: timnearestws
        interval: 1000
        running: false

        onTriggered: {
            var nearestws = positionsource.nearestWeatherStation(positionsource.position.coordinate);

            if(!nearestws || !sardiniaView)
                return;

            wsdata.nearestWeatherStation = nearestws;

            if(zoom) {
                sardiniaView.center = QtPositioning.coordinate(nearestws.latitude, nearestws.longitude);
                sardiniaView.zoomLevel = sardiniaView.maximumZoomLevel / 2;
            }

            Settings.set("nearestws", nearestws.id);
        }
    }
}

.pragma library

var TEMPERATURE_TABLE = { "-10": "#0000FF", "-9": "#001FFF", "-8": "#003EFF", "-7": "#005DFF", "-6": "#007CFF", "-5": "#009BFF",
                          "-4": "#00B9FF", "-3": "#00D8FF", "-2": "#00F8FF", "-1": "#01F9E9", "0": "#02EFCC", "1": "#03E6AF",
                          "2": "#04DC92", "3": "#05D16E", "4": "#06C850", "5": "#06BF33", "6": "#07B516", "7": "#1EBA0E",
                          "8": "#3BC30C", "9": "#58CC09", "10": "#75D507", "11": "#92DD06", "12": "#AFE605", "13": "#CCEF03",
                          "14": "#E9F901", "15": "#FFFC00", "16": "#FFF100", "17": "#FFE600", "18": "#FFBB00", "19": "#FFB000",
                          "20": "#FFA500", "21": "#FF9100", "22": "#FF7D00", "23": "#FF6900", "24": "#FF5000", "25": "#FF3C00",
                          "26": "#FF2800", "27": "#FF1300", "28": "#FF0000", "29": "#EC0010", "30": "#D60021", "31": "#C20031",
                          "32": "#AE0042", "33": "#990052", "34": "#850063", "35": "#700073", "36": "#5C0084" };


var TEMPERATURE_MIN_TABLE = { "-10": "#0000FF", "-9": "#001FFF", "-8": "#003EFF", "-7": "#005DFF", "-6": "#007CFF", "-5": "#009BFF",
                             "-4": "#00B9FF", "-3": "#00D8FF", "-2": "#00F8FF", "-1": "#01F9E9", "0": "#02EFCC", "1": "#03E6AF",
                             "2": "#04DC92", "3": "#05D16E", "4": "#06C850", "5": "#06BF33", "6": "#07B516", "7": "#1EBA0E",
                             "8": "#3BC30C", "9": "#58CC09", "10": "#75D507", "11": "#92DD06", "12": "#AFE605", "13": "#CCEF03",
                             "14": "#E9F901", "15": "#FFFC00", "16": "#FFF100", "17": "#FFE600", "18": "#FFBB00", "19": "#FFB000",
                             "20": "#FFA500", "21": "#FF9100", "22": "#FF7D00", "23": "#FF6900", "24": "#FF5000", "25": "#FF3C00",
                             "26": "#FF2800", "27": "#FF1300", "28": "#FF0000", "29": "#EC0010", "30": "#D60021", "31": "#C20031",
                             "32": "#AE0042", "33": "#990052", "34": "#850063", "35": "#700073", "36": "#5C0084" };

var TEMPERATURE_MAX_TABLE = { "-10": "#0000FF", "-9": "#001FFF", "-8": "#003EFF", "-7": "#005DFF", "-6": "#007CFF", "-5": "#009BFF",
                              "-4": "#00B9FF", "-3": "#00D8FF", "-2": "#00F8FF", "-1": "#01F9E9", "0": "#02EFCC", "1": "#03E6AF",
                              "2": "#04DC92", "3": "#05D16E", "4": "#06C850", "5": "#06BF33", "6": "#07B516", "7": "#1EBA0E",
                              "8": "#3BC30C", "9": "#58CC09", "10": "#75D507", "11": "#92DD06", "12": "#AFE605", "13": "#CCEF03",
                              "14": "#E9F901", "15": "#FFFC00", "16": "#FFF100", "17": "#FFE600", "18": "#FFBB00", "19": "#FFB000",
                              "20": "#FFA500", "21": "#FF9100", "22": "#FF7D00", "23": "#FF6900", "24": "#FF5000", "25": "#FF3C00",
                              "26": "#FF2800", "27": "#FF1300", "28": "#FF0000", "29": "#EC0010", "30": "#D60021", "31": "#C20031",
                              "32": "#AE0042", "33": "#990052", "34": "#850063", "35": "#700073", "36": "#5C0084" };

var WIND_DIRECTION = { "N": 0, "E": 90, "S": 180, "W": 270 };
var COMPASS = [ "N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW" ];

var COMPASS_ROTATION = { "N": 0, "NNE": 22.5, "NE": 45,
                         "ENE": 67.5, "E": 90, "ESE": 112.5,
                         "SE": 135, "SSE": 157.5, "S": 180, "SSW": 202.5, "SW": 225,
                         "WSW": 247.5, "W": 270, "WNW": 292.5, "NW": 315, "NNW": 337.5 }


function temperature(tempval) {
    tempval = Math.floor(parseInt(tempval));

    if(tempval < -10)
        return TEMPERATURE_TABLE["-10"];
    else if(tempval > 36)
        return TEMPERATURE_TABLE["36"];

    return TEMPERATURE_TABLE[tempval.toString()];
}

function temperatureMin(tempval) {
    tempval = Math.floor(parseInt(tempval));

    if(tempval < -10)
        return TEMPERATURE_MIN_TABLE["-10"];
    else if(tempval > 36)
        return TEMPERATURE_MIN_TABLE["36"];

    return TEMPERATURE_MIN_TABLE[tempval.toString()];
}

function temperatureMax(tempval) {
    tempval = Math.floor(parseInt(tempval));

    if(tempval < -10)
        return TEMPERATURE_MAX_TABLE["-10"];
    else if(tempval > 36)
        return TEMPERATURE_MAX_TABLE["36"];

    return TEMPERATURE_MAX_TABLE[tempval.toString()];
}

function rain(rainval) {
    rainval = parseFloat(rainval);

    if(rainval === 0)
        return "#FFFFFF";
    else if(0 > rainval && rainval <= 0.5)
        return "#D6E2FF";
    else if(0.5 > rainval && rainval <= 1)
        return "#B5C9FF";
    else if(1 > rainval && rainval <= 2)
        return "#8EB2FF";
    else if(2 > rainval && rainval <= 5)
        return "#7F96FF";
    else if(5 > rainval && rainval <= 10)
        return "#6370F8";
    else if(10 > rainval && rainval <= 15)
        return "#0063FF";
    else if(15 > rainval && rainval <= 20)
        return "#009696";
    else if(20 > rainval && rainval <= 30)
        return "#00C633";
    else if(30 > rainval && rainval <= 40)
        return  "#63FF00";
    else if(40 > rainval && rainval <= 50)
        return "#96FF00";
    else if(50 > rainval && rainval <= 60)
        return  "#C6FF33";
    else if(60 > rainval && rainval <= 80)
        return "#FFFF00";
    else if(80 > rainval && rainval <= 100)
        return "#FFC600";
    else if(100 > rainval && rainval <= 120)
        return "#FFA000"
    else if(120 > rainval && rainval <= 150)
        return "#FF7C00";

    return "#FF1900";
}

function windDirection(winddirval) {

    if(!winddirval || winddirval.length <= 0)
        return 0;

    var floatwinddirval = parseFloat(winddirval);

    if(isNaN(floatwinddirval))
        return COMPASS_ROTATION[winddirval];

    return floatwinddirval;
}

function windCompass(winddirval) {
    var floatwinddirval = parseFloat(winddirval);

    if(isNaN(floatwinddirval))
        return winddirval;

    var value = Math.ceil((floatwinddirval / 22.5) + 0.5);
    return COMPASS[value % 16];
}

function windColor(wspeedval) {
    if(!wspeedval)
        return "transparent";

    var WIND_MAX = 8.8;
    var wspeedkmh = parseFloat(wspeedval);

    var wspeedms = wspeedkmh / 3.6;
    var windscale = wspeedms / WIND_MAX;

    return Qt.darker(Qt.rgba((255 * windscale) / 100,
                             (255 * (100 - windscale)) / 100,
                              0, 1.0), 1.5);
}

function humidity(humidityval) {
    humidityval = parseInt(humidityval) / 100.0;

    return Qt.rgba((255 * humidityval) / 100,
                   (255 * (100 - humidityval)) / 100,
                   0, 1.0);
}

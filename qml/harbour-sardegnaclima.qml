import QtQuick 2.1
import Sailfish.Silica 1.0
import "pages/map"
import "model"
import "cover"

ApplicationWindow
{
    WeatherStationData { id: weatherstationdata }

    allowedOrientations: Orientation.Portrait
    _defaultPageOrientations: Orientation.Portrait

    initialPage: Component {
        MapPage {
            weatherStationData: weatherstationdata
        }
    }

    cover: CoverPage {
        weatherStationData: weatherstationdata
    }
}

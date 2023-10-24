import QtQuick 2.15

Item {
    id: root

    property alias dispatcher: logicConnection.target
    readonly property var currentLocation: !!internal.previousLocations && internal.previousLocations.length > 0 ? internal.previousLocations[0] : undefined
    readonly property var previousLocations: internal.previousLocations

    Connections {
        id: logicConnection

        function onGeocodeSearch(input) {
            restAPI.geocodeSearch(input, internal.geocodeSearchSuccess, internal.geocodeSeachError());
        }

        function onUpdateCurrentLocation(location) {

        }

        function onUpdateWeatherData() {
            restAPI.getCurrentWeatherCondition(currentLocation.latitude + ", " + currentLocation.longitude, internal.currentWeatherConditionSuccess, internal.currentWeatherConditionError);
        }
    }

    RestAPI {
        id: restAPI
    }

    QtObject {
        id: internal

        property var previousLocations: []

        function geocodeSearchSuccess(results) {
            console.log("Geocode request success!", JSON.stringify(results));
        }

        function geocodeSeachError(err) {
            console.log("Geocode request failed!", err.message);
        }

        function currentWeatherConditionSuccess(results) {
            console.log("Current weather conditions request success", JSON.stringify(results));
        }

        function currentWeatherConditionError(err) {
            console.log("Current weather conditions request failed!", err.message);
        }
    }
}

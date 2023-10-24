import QtQuick 2.15

Item {
    id: root

    property alias dispatcher: logicConnection.target
    readonly property var currentLocation: internal.currentLocation
    readonly property var previousLocations: internal.previousLocations
    readonly property var geolocationSearchResults: internal.geolocationSearchResults

    onCurrentLocationChanged: {
        appLogic.updateWeatherData(currentLocation);
    }

    Connections {
        id: logicConnection

        function onInitialize() {
            if (!!appStorage.getValue(appStorage.currentLocationStorageKey)) {
                internal.currentLocation = appStorage.getValue(appStorage.currentLocationStorageKey);
            }
            if (!!appStorage.getValue(appStorage.previousLocationsStorageKey)) {
                internal.previousLocations = appStorage.getValue(appStorage.previousLocationsStorageKey);
            }
        }

        function onGeocodeSearch(input) {
            restAPI.geocodeSearch(input, internal.geocodeSearchSuccess, internal.geocodeSeachError());
        }

        function onClearGeocodeSearchResults() {
            internal.geolocationSearchResults = [];
        }

        function onUpdateCurrentLocation(location) {
            internal.currentLocation = location;
            appStorage.setValue(appStorage.currentLocationStorageKey, location);
            if (!internal.previousLocations.some((place) => place.place_id === location.place_id)) {
                internal.previousLocations.push(location);
                if (internal.previousLocations.length > appStorage.maxPreviousLocationsCount) {
                    internal.previousLocations = internal.previousLocations.slice(1);
                }
                appStorage.setValue(appStorage.previousLocationsStorageKey, internal.previousLocations);
                root.previousLocationsChanged();
            }
        }

        function onUpdateWeatherData() {
            restAPI.getCurrentWeatherCondition(currentLocation.lat + ", " + currentLocation.lon, internal.currentWeatherConditionSuccess, internal.currentWeatherConditionError);
        }
    }

    RestAPI {
        id: restAPI
    }

    QtObject {
        id: internal

        property var currentLocation: undefined
        property var previousLocations: []
        property var geolocationSearchResults: []

        function geocodeSearchSuccess(results) {
            console.log("Geocode request success!", JSON.stringify(results));
            internal.geolocationSearchResults = results;
        }

        function geocodeSeachError(err) {
            console.log("Geocode request failed!", err);
        }

        function currentWeatherConditionSuccess(results) {
            console.log("Current weather conditions request success", JSON.stringify(results));
        }

        function currentWeatherConditionError(err) {
            console.log("Current weather conditions request failed!", err.message);
        }
    }
}

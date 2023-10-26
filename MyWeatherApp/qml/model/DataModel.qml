import QtQuick 2.15

Item {
    id: root

    property alias dispatcher: logicConnection.target
    readonly property var currentLocation: internal.currentLocation
    readonly property var previousLocations: internal.previousLocations
    readonly property var geolocationSearchResults: internal.geolocationSearchResults
    readonly property var currentWeatherCondition: internal.currentWeatherCondition
    readonly property var hourlyForecast: internal.hourlyForecast
    readonly property var dailyForecast: internal.dailyForecast
    readonly property string measurementUnitOption: internal.measurementUnitOption

    onCurrentLocationChanged: {
        appLogic.updateWeatherData(currentLocation);
    }

    Connections {
        id: logicConnection

        function onInitialize() {
            if (!!appStorage.getValue(appStorage.measurementUnitOptionKey)) {
                internal.measurementUnitOption = appStorage.getValue(appStorage.measurementUnitOptionKey);
            }
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
            restAPI.getDailyForecast(currentLocation.lat + ", " + currentLocation.lon, internal.dailyForecastSuccess, internal.dailyForecastError);
            restAPI.getHourlyForecast(currentLocation.lat + ", " + currentLocation.lon, internal.hourlyForecastSuccess, internal.hourlyForecastError);
        }

        function onSetMeasurementUnitOption(option) {
            if (internal.measurementUnitOption !== option) {
                internal.measurementUnitOption = option;
                appStorage.setValue(appStorage.measurementUnitOptionKey, option);
                appLogic.updateWeatherData(root.currentLocation);
            }
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
        property var currentWeatherCondition
        property var hourlyForecast
        property var dailyForecast
        property string measurementUnitOption: "metric"

        function geocodeSearchSuccess(results) {
            console.log("Geocode request success!", JSON.stringify(results));
            internal.geolocationSearchResults = results;
        }

        function geocodeSeachError(err) {
            console.log("Geocode request failed!", err);
        }

        function currentWeatherConditionSuccess(results) {
            console.log("Current weather conditions request success!");
            internal.currentWeatherCondition = results;
        }

        function currentWeatherConditionError(err) {
            console.log("Current weather conditions request failed!", err);
        }

        function hourlyForecastSuccess(results) {
            console.log("Hourly forecast request success!");
            internal.hourlyForecast = results;
        }

        function hourlyForecastError(err) {
            console.log("Hourly forecast request failed!", err);
        }

        function dailyForecastSuccess(results) {
            console.log("Daily forecast request success!");
            internal.dailyForecast = results;
        }

        function dailyForecastError(err) {
            console.log("Daily forecast request failed!", err.message);
        }
    }
}

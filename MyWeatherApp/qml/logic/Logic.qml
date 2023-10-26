import QtQuick 2.15

Item {
    id: root

    signal initialize()

    signal geocodeSearch(string input)

    signal clearGeocodeSearchResults()

    signal updateCurrentLocation(var location)

    signal updateWeatherData()

    signal setMeasurementUnitOption(string option)
}

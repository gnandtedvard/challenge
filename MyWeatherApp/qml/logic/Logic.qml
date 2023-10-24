import QtQuick 2.15

Item {

    signal geocodeSearch(string input)

    signal updateCurrentLocation(var location)

    signal updateWeatherData()
}

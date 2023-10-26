import QtQuick 2.15
import Felgo 3.0

Item {
    id: root

    property int maxRequestTimeout: 5000

    QtObject {
        id: internal

        // Weather API data.
        // DISCLAIMER: Weather API accepts only 25 calls/hour using a free account.
        property string weatherApiKey: "qpRPO6BW4TzdxnpGq0ZVYlnXVcDwI66j"
        property string weatherForecastUrl: "https://api.tomorrow.io/v4/weather/forecast"
        property string weatherCurrentConditionUrl: "https://api.tomorrow.io/v4/weather/realtime"

        // Geocode API data.
        // DISCLAIMER: Geocode API accepts at most 1 request/second
        property string geocodeSearchUrl: "https://geocode.maps.co/search"

        function fetch(url, params, success, error) {
            HttpRequest.get(url)
            .query(params)
            .timeout(root.maxRequestTimeout)
            .accept('application/json')
            .then(function(res) { success(res.body) })
            .catch(function(err) { error(err) });
        }
    }

    function geocodeSearch(address, success, error) {
        var params = {q: address};
        internal.fetch(internal.geocodeSearchUrl, params, success, error);
    }

    function getCurrentWeatherCondition(address, success, error) {
        var params = {apikey: internal.weatherApiKey, location: address, units: appModel.measurementUnitOption};
        internal.fetch(internal.weatherCurrentConditionUrl, params,  success, error)
    }

    function getHourlyForecast(address, success, error) {
        var params = {apikey: internal.weatherApiKey, location: address, units: appModel.measurementUnitOption, timesteps: "1h"};
        internal.fetch(internal.weatherForecastUrl, params,  success, error)
    }

    function getDailyForecast(address, success, error) {
        var params = {apikey: internal.weatherApiKey, location: address, units: appModel.measurementUnitOption, timesteps: "1d"};
        internal.fetch(internal.weatherForecastUrl, params,  success, error)
    }
}

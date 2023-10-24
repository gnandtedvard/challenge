import QtQuick 2.15
import Felgo 3.0

Item {

    readonly property bool busy: HttpNetworkActivityIndicator.enabled
    property int maxRequestTimeout: 5000

    Component.onCompleted: {
        HttpNetworkActivityIndicator.setActivationDelay(0)
    }

    QtObject {
        id: internal
        property string weatherForecastUrl: "https://api.tomorrow.io/v4/weather/forecast"
        property string weatherCurrentConditionUrl: "https://api.tomorrow.io/v4/weather/realtime"
        property string geocodeSearchUrl: "https://geocode.maps.co/search"

        function fetch(url, params, success, error) {
            HttpRequest.get(url)
            .query(params)
            .timeout(maxRequestTimeout)
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
        var params = {apikey: "qpRPO6BW4TzdxnpGq0ZVYlnXVcDwI66j", location: address, units: "metric"};
        internal.fetch(internal.weatherCurrentConditionUrl, params,  success, error)
    }

    function getHourlyForecast(address, success, error) {
        var params = {apikey: "qpRPO6BW4TzdxnpGq0ZVYlnXVcDwI66j", location: address, units: "metric", timesteps: "1h"};
        internal.fetch(internal.weatherForecastUrl, params,  success, error)
    }

    function getDailyForecast(address, success, error) {
        var params = {apikey: "qpRPO6BW4TzdxnpGq0ZVYlnXVcDwI66j", location: address, units: "metric", timesteps: "1d"};
        internal.fetch(internal.weatherForecastUrl, params,  success, error)
    }
}

import Felgo 3.0
import QtQuick 2.15

Page {
    id: root

    title: "Current Weather"
    backgroundColor: "transparent"

    AppFlickable {
        anchors.fill: parent
        anchors.margins: dp(20)
        boundsBehavior: Flickable.StopAtBounds
        contentHeight: mainColumn.height
        clip: false;

        Column {
            id: mainColumn

            width: parent.width
            spacing: dp(60)

            Row {
                id: locationRow

                width: parent.width - searchLocationButton.width
                height: Math.max(locationLabel.height, searchLocationButton.height)
                anchors.right: parent.right

                AppText {
                    id: locationLabel

                    text: appModel.currentLocation.display_name
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width - searchLocationButton.width - locationRow.spacing
                    color: Theme.navigationTabBar.titleColor
                    horizontalAlignment: Text.AlignHCenter
                    fontSize: dp(26)
                }

                IconButton {
                    id: searchLocationButton

                    icon: IconType.search
                    color: Theme.navigationTabBar.titleColor

                    onClicked: {
                        searchLocationModal.open();
                    }
                }
            }

            AppText {
                id: temperatureText

                anchors.horizontalCenter: parent.horizontalCenter
                text: !!appModel.currentWeatherCondition ? Math.round(appModel.currentWeatherCondition.data.values.temperature) + " °C" : ""
                fontSize: dp(70)
                color: Theme.navigationTabBar.titleColor
            }

            Column {
                id: detailsColumn

                width: parent.width
                spacing: dp(10)

                AppText {
                    id: currentConditionLabel

                    text: weatherHelper.weatherCodeToString(appModel.currentWeatherCondition.data.values.weatherCode);
                    fontSize: dp(26)
                    color: Theme.navigationTabBar.titleColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                AppText {
                    id: precipitationProbabilityLabel

                    text: "Precipitation probability: %1 %".arg(appModel.currentWeatherCondition.data.values.precipitationProbability)
                    fontSize: dp(16)
                    color: Theme.navigationTabBar.titleColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                AppText {
                    id: humidityLabel

                    text: "Humidity: %1 %".arg(appModel.currentWeatherCondition.data.values.humidity)
                    fontSize: dp(16)
                    color: Theme.navigationTabBar.titleColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                AppText {
                    id: windSpeedLabel

                    text: "Wind speed: %1 m/s".arg(appModel.currentWeatherCondition.data.values.windSpeed)
                    fontSize: dp(16)
                    color: Theme.navigationTabBar.titleColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                AppText {
                    id: visibilityLabel

                    text: "Visibility: %1 km".arg(appModel.currentWeatherCondition.data.values.visibility)
                    fontSize: dp(16)
                    color: Theme.navigationTabBar.titleColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                AppText {
                    id: uvIndexLabel

                    text: "UV index: %1".arg(appModel.currentWeatherCondition.data.values.uvIndex)
                    fontSize: dp(16)
                    color: Theme.navigationTabBar.titleColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}

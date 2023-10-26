import Felgo 3.0
import QtQuick 2.15

Page {
    id: root

    title: "Hourly Forecast"
    backgroundColor: "transparent"


    JsonListModel {
        id: hourlyModel

        source: appModel.hourlyForecast.timelines.hourly
        fields: ["time", "values"]
        keyField: "time"
    }

    AppListView {
        id: hourlyList

        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        model: visible ? hourlyModel : []

        populate: Transition {
            id: populateAnim
            SequentialAnimation {
                PropertyAction { property: "opacity"; value: 0.0 }
                PauseAnimation { duration: 100 * populateAnim.ViewTransition.index }
                NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 500; easing.type: Easing.InOutQuart }
            }
        }

        delegate: Item {
            id: hourlyItem

            width: hourlyList.width
            height: contentColumn.childrenRect.height

            Column {
                id: contentColumn

                spacing: dp(5)
                width: parent.width
                AppText {
                    id: timeLabel

                    text: {
                        let date = new Date(time);
                        return date.toDateString() + " " + date.toTimeString();
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSize: dp(14)
                    color: Theme.navigationTabBar.titleColor
                }

                Row {
                    id: detailsRow

                    height: temperatureLabel.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: dp(15)

                    AppText {
                        id: conditionLabel

                        text: weatherHelper.weatherCodeToString(values.weatherCode)
                        fontSize: dp(15)
                        color: Theme.navigationTabBar.titleColor
                    }

                    AppText {
                        id: temperatureLabel

                        text: Math.round(values.temperature) +
                              (appModel.measurementUnitOption === "metric" ? " °C" : " °F")
                        fontSize: dp(15)
                        color: Theme.navigationTabBar.titleColor
                    }

                    AppText {
                        id: precipitationProbabilityLabel

                        text: "Precip: %1 %".arg(values.precipitationProbability)
                        fontSize: dp(15)
                        color: Theme.navigationTabBar.titleColor
                    }
                }

                Rectangle {
                    id: separatorLine

                    color: Theme.navigationTabBar.titleColor
                    width: parent.width - dp(8)
                    height: dp(2)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }
}

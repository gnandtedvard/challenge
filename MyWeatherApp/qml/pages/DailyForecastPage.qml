import Felgo 3.0
import QtQuick 2.15
import "components"

Page {
    id: root

    title: "Daily Forecast"
    backgroundColor: "transparent"

    JsonListModel {
        id: hourlyModel

        source: appModel.dailyForecast.timelines.daily
        fields: ["time", "values"]
        keyField: "time"
    }

    AppListView {
        id: hourlyList

        anchors.fill: parent
        boundsBehavior: Flickable.StopAtBounds
        model: hourlyModel
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
                        return new Date(time).toDateString();
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    fontSize: dp(16)
                    color: Theme.navigationTabBar.titleColor
                }

                Row {
                    id: detailsRow

                    spacing: dp(2)

                    DailyForecastItem {
                        id: dayComponent

                        width: hourlyItem.width/2 - dp(3)
                        daytimeIcon: IconType.suno
                        temperatureValue: values.temperatureMax
                        weatherCode: values.weatherCodeMax
                        precipitationProbability: values.precipitationProbabilityMax
                    }

                    Rectangle {
                        id: verticalSeparator

                        width: dp(2);
                        height: detailsRow.height
                    }

                    DailyForecastItem {
                        id: nightComponent

                        width: hourlyItem.width/2 - dp(3)
                        daytimeIcon: IconType.moono
                        temperatureValue: values.temperatureMin
                        weatherCode: values.weatherCodeMin
                        precipitationProbability: values.precipitationProbabilityMin
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

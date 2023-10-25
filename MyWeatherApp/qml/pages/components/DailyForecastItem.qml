import Felgo 3.0
import QtQuick 2.15

Column {
    id: root

    property alias daytimeIcon: daytimeIcon.icon
    property int temperatureValue: 0
    property int weatherCode: 0
    property int precipitationProbability: 0

    Icon {
        id: daytimeIcon

        color: Theme.navigationTabBar.titleColor
        anchors.horizontalCenter: parent.horizontalCenter
        size: dp(25)
    }

    AppText {
        id: temperatureText

        anchors.horizontalCenter: parent.horizontalCenter
        text: "%1 °C".arg(root.temperatureValue)
        fontSize: dp(20)
        color: Theme.navigationTabBar.titleColor
    }

    AppText {
        id: currentConditionLabel

        text: weatherHelper.weatherCodeToString(root.weatherCode);
        fontSize: dp(16)
        color: Theme.navigationTabBar.titleColor
        anchors.horizontalCenter: parent.horizontalCenter
    }

    AppText {
        id: precipitationProbabilityLabel

        text: "Precip: %1 %".arg(root.precipitationProbability)
        fontSize: dp(16)
        color: Theme.navigationTabBar.titleColor
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

import Felgo 3.0
import QtQuick 2.15
import QtQuick.Controls 2.15 as QC2

Page {
    id: root

    title: "Options"
    backgroundColor: "transparent"

    onPushed: {
        optionsColumn.opacity = Qt.binding(function () {return root.visible ? 1 : 0})
    }

    Column {
        id: optionsColumn

        width: parent.width
        opacity: 0

        Behavior on opacity {
            NumberAnimation {duration: 800; easing.type: Easing.InOutQuart}
        }

        AppText {
            id: locationLabel

            text: "Measurement unit option:"
            fontSize: dp(15)
            anchors.horizontalCenter: parent.horizontalCenter
        }

        QC2.ButtonGroup {
            id: radioButtonGroup
            buttons: [metricRadio, imperialRadio]

            onCheckedButtonChanged: {
                appLogic.setMeasurementUnitOption(radioButtonGroup.checkedButton.value)
            }
        }

        AppListItem {
            text: "Metric"
            showDisclosure: false
            backgroundColor: "transparent"

            leftItem: AppRadio {
                id: metricRadio
                checked: appModel.measurementUnitOption === "metric"
                value: "metric"
                anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
                if(!metricRadio.checked) metricRadio.toggle()
            }
        }

        AppListItem {
            text: "Imperial"
            showDisclosure: false
            backgroundColor: "transparent"

            leftItem: AppRadio {
                id: imperialRadio
                checked: appModel.measurementUnitOption === "imperial"
                value: "imperial"
                anchors.verticalCenter: parent.verticalCenter
            }

            onSelected: {
                if(!imperialRadio.checked) imperialRadio.toggle()
            }
        }
    }
}

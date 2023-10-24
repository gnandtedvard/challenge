import Felgo 3.0
import QtQuick 2.15

Page {
    id: root

    title: "Current"
    backgroundColor: "transparent"

    AppButton {
        anchors.centerIn: parent
        text: "Search"

        onClicked: {
            searchLocationModal.open();
        }
    }
}

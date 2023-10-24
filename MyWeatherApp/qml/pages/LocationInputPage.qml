import Felgo 3.0
import QtQuick 2.15

Page {
    id: root

    title: "Set up location"

    AppTextField {
        id: textInput

        width: parent.width - dp(40)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: dp(20)

        onTextChanged: {
            appLogic.clearGeocodeSearchResults();
            searchTriggerTimer.restart();
        }
    }

    JsonListModel {
        source: textInput.activeFocus && textInput.text === "" ? appModel.previousLocations : appModel.geolocationSearchResults
        fields: ["place_id", "display_name", "lat", "lon"]
        keyField: "place_id"
    }

    AppListView {
        id: results

        width: textInput.width
        anchors {
            left: textInput.left
            top: textInput.bottom
            bottom: parent.bottom
            bottomMargin: dp(20)
        }
        model: textInput.activeFocus && textInput.text === "" ? appModel.previousLocations : appModel.geolocationSearchResults
        delegate: AppListItem {
            text: modelData.display_name

            onSelected: {
                appLogic.updateCurrentLocation({place_id: modelData.place_id, display_name: modelData.display_name, lat: modelData.lat, lon: modelData.lon});
            }
        }
    }

    Timer {
        id: searchTriggerTimer

        interval: 800
        running: false
        repeat: false

        onTriggered: {
            if (textInput.text.length >= 3) {
                appLogic.geocodeSearch(textInput.text);
            }
        }
    }

}

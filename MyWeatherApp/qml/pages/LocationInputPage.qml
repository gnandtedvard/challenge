import Felgo 3.0
import QtQuick 2.15

Page {
    id: root

    title: "Set up location"

    leftBarItem: IconButtonBarItem {
        icon: IconType.close

        onClicked: {
            searchLocationModal.close()
        }
    }

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
        id: locationModel

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
        model: locationModel
        delegate: AppListItem {
            text: display_name

            onSelected: {
                appLogic.updateCurrentLocation({place_id: place_id, display_name: display_name, lat: lat, lon: lon});
                searchLocationModal.close();
            }
        }
    }

    // Geocode API supports at most 1 request/second
    // Using this timer will limit the number of requests while typing
    Timer {
        id: searchTriggerTimer

        interval: 800
        running: false
        repeat: false

        onTriggered: {
            // Another limitation of the API is that the input lenght must be at least 3 characters long
            if (textInput.text.length >= 3) {
                appLogic.geocodeSearch(textInput.text);
            }
        }
    }

    function reset() {
        textInput.clear();
    }

    function openKeyboard() {
        textInput.forceActiveFocus();
    }
}

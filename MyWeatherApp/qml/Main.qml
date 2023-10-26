import Felgo 3.0
import QtQuick 2.15
import "logic"
import "model"
import "pages"
import "helpers"

App {
    id: appRoot

    Component.onCompleted: {
        appLogic.initialize();

        // If there is no current location set (first startup or storage reset) the current location has to be set up.
        if (!appModel.currentLocation) {
            searchLocationModal.open();
        }
    }

    onInitTheme: {
        Theme.colors.tintColor = "#000000";
        Theme.navigationTabBar.backgroundColor = "#000000";
        Theme.navigationTabBar.titleColor = "#FFFFFF";
        Theme.navigationTabBar.textSize = dp(16);
    }


    Rectangle {
        id: appBackground

        anchors.fill: parent

        gradient: Gradient {
            GradientStop {
                id: colorTop
                position: 0
                color: "#06beb6"
                Behavior on color { ColorAnimation { duration: 1000 } }
            }
            GradientStop {
                id: colorBottom
                position: 1
                color: "#48b1bf"
                Behavior on color { ColorAnimation { duration: 1000 } }
            }
        }

        states: [
            State {
                when: navigation.currentIndex === 0
                PropertyChanges {target: colorTop; color: "#06beb6"}
                PropertyChanges {target: colorBottom; color: "#48b1bf"}
            },
            State {
                when: navigation.currentIndex === 1
                PropertyChanges {target: colorTop; color: "#ffafbd"}
                PropertyChanges {target: colorBottom; color: "#ffc3a0"}
            },
            State {
                when: navigation.currentIndex === 2
                PropertyChanges {target: colorTop; color: "#de6262"}
                PropertyChanges {target: colorBottom; color: "#ffb88c"}
            },
            State {
                when: navigation.currentIndex === 3
                PropertyChanges {target: colorTop; color: "#eacda3"}
                PropertyChanges {target: colorBottom; color: "#d6ae7b"}
            }
        ]
    }

    Logic {
        id: appLogic
    }

    Storage {
        id: appStorage

        readonly property string previousLocationsStorageKey: "prevLocations"
        readonly property int maxPreviousLocationsCount: 5
        readonly property string currentLocationStorageKey: "currentLocation"
        readonly property string measurementUnitOptionKey: "measurementUnit"
    }

    DataModel {
        id: appModel

        dispatcher: appLogic
    }

    WeatherDataHelper {
        id: weatherHelper
    }

    Navigation {
        id: navigation

        navigationMode: navigationModeTabs
        tabs.showIcon: false
        width: parent.width
        height: parent.height

        NavigationItem {
            title: "Current"

            NavigationStack {
                initialPage: CurrentConditionsPage {}
            }
        }

        NavigationItem {
            title: "Hourly"

            NavigationStack {
                initialPage: HourlyForecastPage {}
            }
        }

        NavigationItem {
            title: "Daily"

            NavigationStack {
                initialPage: DailyForecastPage {}
            }
        }

        NavigationItem {
            title: "Options"

            NavigationStack {
                initialPage: OptionsPage {}
            }
        }
    }

    SearchLocationModal {
        id: searchLocationModal

        modalHeight: appRoot.height
    }


}

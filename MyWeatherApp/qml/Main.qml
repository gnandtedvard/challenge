import Felgo 3.0
import QtQuick 2.15
import "logic"
import "model"
import "pages"

App {

    Component.onCompleted: {
        appLogic.initialize();
    }

    Logic {
        id: appLogic
    }

    Storage {
        id: appStorage

        readonly property string previousLocationsStorageKey: "prevLocations"
        readonly property int maxPreviousLocationsCount: 5
    }

    DataModel {
        id: appModel

        dispatcher: appLogic
    }

    NavigationStack {
        initialPage: LocationInputPage {
        }
    }


}

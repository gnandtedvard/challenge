import Felgo 3.0
import QtQuick 2.15
import "logic"
import "model"

App {

    Component.onCompleted: {

    }

    Logic {
        id: logic
    }

    DataModel {
        dispatcher: logic
    }
}

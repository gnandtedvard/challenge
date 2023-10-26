import Felgo 3.0
import QtQuick 2.0

AppModal {
    id: root

    pushBackContent: navigation

    fullscreen: false

    NavigationStack {
        id: navigationStack

        initialPage: LocationInputPage {
            id: inputPage
        }
    }

    onClosed: {
        inputPage.reset()
    }

    onOpened: {
        inputPage.openKeyboard()
    }
}

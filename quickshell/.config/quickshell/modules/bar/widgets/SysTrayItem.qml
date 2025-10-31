import Quickshell.Services.SystemTray
import Quickshell.Widgets

import QtQuick

import qs.common.widgets

// TODO: MAKE PART OF GLOBAL CONFIG
MouseArea {
    id: root
    required property SystemTrayItem item
    property bool menuOpen: false

    signal menuOpened(qsWindow: var)
    signal menuClosed

    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    implicitHeight: 22
    implicitWidth: 22

    IconImage {
        id: trayIcon
        source: root.item.icon
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }

    StyledPopup {
        id: tooltip
        hoverTarget: root
        StyledText {
            text: root.item.title || root.item.tooltipTitle
            anchors.centerIn: parent
        }
    }
}

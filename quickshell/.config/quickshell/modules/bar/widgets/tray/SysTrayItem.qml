pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import Quickshell.Widgets

import QtQuick

import qs.common.widgets
import qs.services

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

    onPressed: (event) => {
        switch (event.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        case Qt.RightButton:
            if (item.hasMenu) menu.open();
            break;
        }
    }
    onEntered: {
        tooltip.text = getTooltipForItem(root.item)

    }

    function getTooltipForItem(item) {
        var result = item.tooltipTitle.length > 0 ? item.tooltipTitle
                : (item.title.length > 0 ? item.title : item.id);
        if (item.tooltipDescription.length > 0) result += " • " + item.tooltipDescription;
        return result;
    }

    Loader {
        id: menu
        function open() {
            menu.active = true;
        }
        active: false
        sourceComponent: SystemTrayMenu {
            Component.onCompleted: this.open();
            trayItemMenuHandle: root.item.menu
            anchor {
                window: root.QsWindow.window
                rect.x: root.x + QsWindow.window?.width
                rect.y: root.y + 0
                rect.height: root.height
                rect.width: root.width
                edges: (Edges.Bottom | Edges.Right)
                gravity: (Edges.Bottom | Edges.Right)
            }
            onMenuOpened: (window) => root.menuOpened(window);
            onMenuClosed: {
                root.menuClosed();
                menu.active = false;
            }
        }
    }

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
        isTrayPopup: true
        StyledText {
            text: root.item.title || root.item.tooltipTitle
            anchors.centerIn: parent
        }
    }
}

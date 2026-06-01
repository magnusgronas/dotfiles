pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import Quickshell
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

    onPressed: event => {
        switch (event.button) {
        case Qt.LeftButton:
            item.activate();
            break;
        case Qt.RightButton:
            if (item.hasMenu)
                if (menu.active && menu.item && typeof menu.item.close === "function")
                    menu.item.close();
                else
                    menu.open();
            break;
        }
        event.accepted = true;
    }
    onEntered: {
        tooltip.text = getTooltipForItem(root.item);
    }

    function getTooltipForItem(item) {
        var result = item.tooltipTitle.length > 0 ? item.tooltipTitle : (item.title.length > 0 ? item.title : item.id);
        if (item.tooltipDescription.length > 0)
            result += " • " + item.tooltipDescription;
        return result;
    }

    Loader {
        id: menu
        function open() {
            menu.active = true;
        }
        active: false
        sourceComponent: SysTrayMenu {
            Component.onCompleted: this.open()
            trayItemMenuHandle: root.item.menu
            trayItemId: root.item.id
            anchor {
                item: root
                edges: Edges.Bottom
                gravity: Edges.Bottom
            }
            onMenuOpened: window => root.menuOpened(window)
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
        property string text: root.item.title || root.item.tooltipTitle
        StyledText {
            text: tooltip.text
            anchors.centerIn: parent
        }
    }
}

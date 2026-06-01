import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.common.widgets

Item {
    id: root
    readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
    readonly property int workspacesShown: 10

    RowLayout {

        Repeater {
            model: root.workspacesShown

            Rectangle {
                width: 20
                height: 20
                color: "#00FF00"
            }
        }
    }
}

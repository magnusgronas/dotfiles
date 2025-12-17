pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick

import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root;
    property bool mediaPopupOpen: false;
    property bool showBar: true;
    property bool superDown: false;
    property bool screenLocked: false;
    property bool powerMenuOpen: false;

    GlobalShortcut {
        name: "workspaceNumber";
        description: "Hold to show workspace numbers, release to show icons";

        onPressed: {
            root.superDown = true;
        }
        onReleased: {
            root.superDown = false;
        }
    }
}

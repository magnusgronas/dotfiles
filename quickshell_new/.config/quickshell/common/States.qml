pragma Singleton

import QtQuick

import Quickshell

Singleton {
    property bool connectivityMenuOpen: false
    property bool mediaMenuOpen: false
    property bool powerMenuOpen: false
    property bool screenLocked: false
    property bool showBar: true
    property real mediaWidgetCenterX: 0
}

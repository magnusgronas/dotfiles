pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Widgets

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.common.widgets
import qs.common

// TODO: MAKE VALUES PART OF GLOBAL CONFIG
Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    readonly property int workspacesShown: 10
    readonly property int workspaceGroup: Math.floor((monitor?.activeWorkspace?.id - 1) / root.workspacesShown)
    property list<bool> workspaceOccupied: []
    property int widgetPadding: 4
    property int workspaceButtonWidth: 36
    property real activeWorkspaceMargin: 2
    property real workspaceIconSize: workspaceButtonWidth * 0.69
    property real workspaceIconSizeShrinked: workspaceButtonWidth * 0.55
    property real workspaceIconOpacityShrinked: 1
    property real workspaceIconMarginShrinked: -4
    property int workspaceIndexInGroup: (monitor?.activeWorkspace?.id - 1) % root.workspacesShown

    property bool showNumbers: false

    Timer {
        id: showNumbersTimer
        interval: 300
        repeat: false
        onTriggered: {
            root.showNumbers = true;
        }
    }
    Connections {
        target: States
        function onSuperDownChanged() {
            if (States.superDown)
                showNumbersTimer.restart();
            else {
                showNumbersTimer.stop();
                root.showNumbers = false;
            }
        }
    }

    function updateWorkspaceOccupied() {
        workspaceOccupied = Array.from({
            length: root.workspacesShown
        }, (_, i) => {
            return Hyprland.workspaces.values.some(ws => ws.id === workspaceGroup * root.workspacesShown + i + 1);
        });
    }
    Component.onCompleted: updateWorkspaceOccupied()
    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() {
            root.updateWorkspaceOccupied();
        }
    }
    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
            root.updateWorkspaceOccupied();
        }
    }
    onWorkspaceGroupChanged: {
        updateWorkspaceOccupied();
    }

    implicitWidth: root.workspaceButtonWidth * root.workspacesShown
    implicitHeight: 50

    WheelHandler {
        onWheel: event => {
            if (event.angleDelta.y < 0) {
                Hyprland.dispatch(`workspace r+1`);
            } else if (event.angleDelta.y > 0) {
                Hyprland.dispatch(`workspace r-1`);
            }
        }
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.BackButton
        onPressed: event => {
            if (event.button === Qt.BackButton) {
                Hyprland.dispatch(`togglespecialworkspace`);
            }
        }
    }

    // Background
    RowLayout {
        id: background
        z: 1
        anchors.centerIn: parent

        spacing: 0
        Repeater {
            model: root.workspacesShown

            Rectangle {
                id: backgroundRect
                z: 1
                implicitWidth: root.workspaceButtonWidth
                implicitHeight: root.workspaceButtonWidth
                radius: width / 2

                required property int index

                property var previousOccupied: (root.workspaceOccupied[index - 1] && !(!root.activeWindow?.activated && root.monitor?.activeWorkspace?.id === index))
                property var rightOccupied: (root.workspaceOccupied[index + 1] && !(!root.activeWindow?.activated && root.monitor?.activeWorkspace?.id === index + 2))

                property var radiusPrev: previousOccupied ? 0 : width / 2
                property var radiusNext: rightOccupied ? 0 : width / 2

                topLeftRadius: radiusPrev
                bottomLeftRadius: radiusPrev
                topRightRadius: radiusNext
                bottomRightRadius: radiusNext

                color: Qt.alpha("#33343a", 0.4)
                opacity: (root.workspaceOccupied[index] && !(!root.activeWindow?.activated && root.monitor?.activeWorkspace?.id === index + 1)) ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 350
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.38, 1.21, 0.22, 1.00, 1, 1]
                    }
                }

                Behavior on radiusPrev {
                    NumberAnimation {
                        duration: 350
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.38, 1.21, 0.22, 1.00, 1, 1]
                    }
                }

                Behavior on radiusNext {
                    NumberAnimation {
                        duration: 350
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: [0.38, 1.21, 0.22, 1.00, 1, 1]
                    }
                }
            }
        }
    }

    // Active workspace
    Rectangle {
        z: 2
        radius: width / 2
        color: "#b3c5ff"

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: undefined
        }

        property real idx1: root.workspaceIndexInGroup
        property real idx2: root.workspaceIndexInGroup
        property real indicatorPosition: Math.min(idx1, idx2) * root.workspaceButtonWidth + root.activeWorkspaceMargin
        property real indicatorLength: Math.abs(idx1 - idx2) * root.workspaceButtonWidth + root.workspaceButtonWidth - root.activeWorkspaceMargin * 2
        property real indicatorThickness: root.workspaceButtonWidth - root.activeWorkspaceMargin * 2

        x: indicatorPosition
        implicitWidth: indicatorLength
        implicitHeight: indicatorThickness

        Behavior on idx1 {
            NumberAnimation {
                duration: 100
                easing.type: Easing.OutSine
            }
        }
        Behavior on idx2 {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutSine
            }
        }
    }

    // Workspace number
    RowLayout {
        z: 3
        spacing: 0
        anchors.fill: parent

        Repeater {
            model: root.workspacesShown

            Button {
                id: button
                required property int index
                property int workspaceValue: root.workspaceGroup * root.workspacesShown + index + 1

                implicitHeight: 50
                onPressed: Hyprland.dispatch(`workspace ${workspaceValue}`)
                width: root.workspaceButtonWidth

                background: Item {
                    id: workspaceButtonBackground
                    implicitWidth: root.workspaceButtonWidth
                    implicitHeight: root.workspaceButtonWidth

                    StyledText {
                        // TODO: Move numberMap to a Config file, used to change the numbers on the workspace indicator
                        property list<string> numberMap: ["1", "2"]
                        opacity: root.showNumbers ? 1 : 0
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        z: 3
                        font {
                            pixelSize: 18 - ((text.length - 1) * (text !== "10") * 2)
                            family: "Noto Sans"
                        }
                        text: numberMap[button.workspaceValue - 1] || button.workspaceValue
                        elide: Text.ElideRight
                        color: (root.monitor?.activeWorkspace?.id == button.workspaceValue) ? "#192e60" : (root.workspaceOccupied[button.index] ? "#c5c6d0" : "#e3e2e9")

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: [0.34, 0.80, 0.34, 1.00, 1, 1]
                            }
                        }
                    }
                    Rectangle {
                        id: wsDot
                        opacity: root.showNumbers ? 0 : 1
                        visible: opacity > 0
                        anchors.centerIn: parent

                        width: root.workspaceButtonWidth * 0.18
                        height: width
                        radius: width / 2
                        color: (root.monitor?.activeWorkspace?.id == button.workspaceValue) ? "#192e60" : (root.workspaceOccupied[button.index] ? "#c5c6d0" : "#e3e2e9")

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.BezierSpline
                                easing.bezierCurve: [0.34, 0.80, 0.34, 1.00, 1, 1]
                            }
                        }
                    }
                }
            }
        }
    }
}

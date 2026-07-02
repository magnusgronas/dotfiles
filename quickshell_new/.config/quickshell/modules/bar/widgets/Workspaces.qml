pragma ComponentBehavior: Bound

import QtQuick

import Quickshell.Hyprland

import qs.common
import qs.common.widgets
import qs.common.functions

Item {
    id: root
    readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
    readonly property int workspacesShown: 10

    property int buttonWidth: 32

    property var workspaceMap: {
        let dict = {};
        for (let i = 0; i < workspaces.length; i++) {
            dict[workspaces[i].id] = workspaces[i];
        }
        return dict;
    }

    implicitWidth: buttonWidth * workspacesShown
    implicitHeight: 50

    WheelHandler {
        onWheel: event => {
            const currentId = Hyprland.focusedWorkspace?.id ?? 1;
            if (event.angleDelta.y < 0) {
                if (currentId < root.workspacesShown) {
                    Hyprland.dispatch(`hl.dsp.focus({ workspace = "r+1" })`);
                }
            } else if (event.angleDelta.y > 0) {
                Hyprland.dispatch(`hl.dsp.focus({ workspace = "r-1" })`);
            }
        }
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    Rectangle {
        id: traveler
        height: 12
        radius: height / 2
        color: Colors?.md3.primary
        anchors.verticalCenter: parent.verticalCenter

        readonly property int rawIndex: Hyprland.focusedWorkspace?.id ? (Hyprland.focusedWorkspace.id - 1) : 0
        readonly property int activeIndex: Math.max(0, Math.min(rawIndex, root.workspacesShown - 1))
        property int previousIndex: 0
        property bool movingRight: true

        onActiveIndexChanged: {
            movingRight = activeIndex >= previousIndex;
            previousIndex = activeIndex;
        }

        property real targetLeft: (activeIndex * root.buttonWidth) + ((root.buttonWidth - height) / 2)
        property real targetRight: targetLeft + height

        property real animLeft: targetLeft
        property real animRight: targetRight

        x: animLeft
        width: animRight - animLeft

        Behavior on animLeft {
            NumberAnimation {
                duration: Appearance.animationCurves.expressiveEffectsDuration
                easing.type: traveler.movingRight ? Easing.InOutQuad : Easing.OutQuart
            }
        }

        Behavior on animRight {
            NumberAnimation {
                duration: Appearance.animationCurves.expressiveEffectsDuration
                easing.type: traveler.movingRight ? Easing.OutQuart : Easing.InOutQuad
            }
        }
    }

    Row {
        anchors.fill: parent
        z: 2

        Repeater {
            model: root.workspacesShown
            delegate: Item {
                id: dotRoot
                required property int index
                width: root.buttonWidth
                height: root.height

                readonly property int workspaceId: index + 1
                readonly property var ws: root.workspaceMap[workspaceId]
                readonly property bool isActive: Hyprland.focusedWorkspace?.id === workspaceId
                readonly property bool isOccupied: ws !== undefined
                readonly property bool isUrgent: ws ? ws.urgent : false

                readonly property int windowCount: dotRoot.ws ? dotRoot.ws.toplevels.values.length : 0
                readonly property int nextWindowCount: root.workspaceMap[workspaceId + 1] ? root.workspaceMap[workspaceId + 1].toplevels.values.length : 0

                // Center divider
                Rectangle {
                    visible: dotRoot.index === Math.floor(root.workspacesShown / 2) - 1

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    width: 2
                    height: 16
                    radius: 1

                    color: ColorUtils.transparentize(Colors.md3.on_surface, 0.8)
                    z: -1
                }

                // Attention animation
                Rectangle {
                    anchors.centerIn: parent
                    width: dot.width
                    height: dot.height
                    radius: width / 2
                    color: "transparent"
                    border.color: Colors?.md3.error
                    border.width: 2

                    visible: dotRoot.isUrgent

                    SequentialAnimation on scale {
                        loops: Animation.Infinite
                        running: dotRoot.isUrgent
                        NumberAnimation {
                            from: 1.0
                            to: 2.5
                            duration: 1200
                            easing.type: Easing.OutQuad
                        }
                    }
                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        running: dotRoot.isUrgent
                        NumberAnimation {
                            from: 0.8
                            to: 0.0
                            duration: 1200
                            easing.type: Easing.OutQuart
                        }
                    }
                }

                // Connecting occupied workspaces
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.horizontalCenter
                    width: root.buttonWidth

                    height: 14

                    opacity: (dotRoot.windowCount > 0 && dotRoot.nextWindowCount > 0) ? 1 : 0

                    color: ColorUtils.transparentize(Colors?.md3.secondary, 0.8)
                    z: -1

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                // Number of windows indicator
                Row {
                    anchors.top: dot.bottom
                    anchors.topMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 2

                    opacity: dotRoot.isActive ? 1.0 : 0.6

                    Repeater {
                        model: Math.min(5, dotRoot.windowCount)

                        Rectangle {
                            width: 4
                            height: 4
                            radius: 2

                            color: dotRoot.windowCount === 1 ? "transparent" : dotRoot.isActive ? (Colors?.md3.primary) : (Colors?.md3.outline)

                            NumberAnimation on opacity {
                                from: 0
                                to: 1
                                duration: 200
                                easing.type: Easing.OutQuad
                            }
                        }
                    }
                }

                // Workspace dot
                RippleButton {
                    id: dot
                    anchors.centerIn: parent
                    rippleEnabled: false
                    colBackgroundHover: Colors.md3.secondary

                    buttonRadius: implicitHeight / 2
                    toggled: dotRoot.isActive

                    releaseAction: () => {
                        Hyprland.dispatch(`hl.dsp.focus({workspace = "${dotRoot.workspaceId}"})`);
                    }

                    state: dotRoot.isActive ? "active" : (dotRoot.isUrgent ? "urgent" : (dotRoot.isOccupied ? "occupied" : "empty"))

                    states: [
                        State {
                            name: "active"
                            PropertyChanges {
                                target: dot
                                implicitWidth: 24
                                implicitHeight: 24
                                colBackground: Colors?.md3.primary
                            }
                        },
                        State {
                            name: "occupied"
                            PropertyChanges {
                                target: dot
                                implicitWidth: dot.isHovered ? 18 : 14
                                implicitHeight: dot.isHovered ? 18 : 14
                                colBackground: dot.isHovered ? Colors.md3.outline : Colors?.md3.secondary
                            }
                        },
                        State {
                            name: "empty"
                            PropertyChanges {
                                target: dot
                                implicitWidth: dot.isHovered ? 12 : 8
                                implicitHeight: dot.isHovered ? 12 : 8
                                colBackground: dot.isHovered ? Colors.md3.primary : Colors?.palette.neutral50
                            }
                        },
                        State {
                            name: "urgent"
                            PropertyChanges {
                                target: dot
                                implicitWidth: 16
                                implicitHeight: 16
                                colBackground: Colors?.md3.error
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            to: "active"
                            SequentialAnimation {
                                PauseAnimation {
                                    duration: 300
                                }
                                ParallelAnimation {
                                    NumberAnimation {
                                        properties: "implicitWidth,implicitHeight"
                                        duration: 300
                                        easing.type: Easing.OutBack
                                    }
                                    ColorAnimation {
                                        duration: 300
                                    }
                                }
                            }
                        },
                        Transition {
                            from: "active"
                            ParallelAnimation {
                                NumberAnimation {
                                    properties: "implicitWidth,implicitHeight"
                                    duration: 200
                                    easing.type: Easing.OutQuad
                                }
                                ColorAnimation {
                                    duration: 200
                                }
                            }
                        },
                        Transition {
                            ParallelAnimation {
                                NumberAnimation {
                                    properties: "implicitWidth,implicitHeight"
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                                ColorAnimation {
                                    duration: 250
                                }
                            }
                        }
                    ]
                }
            }
        }
    }
}

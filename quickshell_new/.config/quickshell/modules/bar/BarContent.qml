import QtQuick

import qs.modules.bar.widgets
import qs.modules.bar.groups
import qs.common.functions
import qs.common

Item {
    id: root
    required property bool floating
    required property bool transparent

    property bool shouldBeTransparent: transparent && !floating

    Rectangle {
        id: background
        anchors.fill: parent
        color: ColorUtils.transparentize(Colors.md3.surface, root.shouldBeTransparent ? 1 : 0.11)
        gradient: root.shouldBeTransparent ? barGradient : 0
        radius: root.floating ? height / 2 : 0

        Gradient {
            id: barGradient
            GradientStop {
                position: 0.0
                color: ColorUtils.transparentize(Colors.md3.surface, 0.6)
            }
            GradientStop {
                position: 1
                color: "transparent"
            }
        }

        Row {
            anchors.topMargin: root.shouldBeTransparent ? 6 : 0
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 24
            }
            spacing: 10
            PowerButton {
                anchors.verticalCenter: parent.verticalCenter
            }
            WindowWidget {
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            anchors.topMargin: root.shouldBeTransparent ? 6 : 0
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 4
            Rectangle {
                implicitWidth: 360
                implicitHeight: 40
                anchors.verticalCenter: parent.verticalCenter
                color: ColorUtils.transparentize(Colors.md3.surface_container_high, root.transparent ? 1 : 0.4)
                radius: height / 2.5
                MediaWidget {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                }
            }
            Rectangle {
                id: workspaceContainer
                implicitHeight: workspaces.implicitHeight - 10
                implicitWidth: workspaces.implicitWidth + 32
                anchors.verticalCenter: parent.verticalCenter
                color: ColorUtils.transparentize(Colors.md3.surface_container_high, root.transparent ? 1 : 0.4)
                radius: height / 2.5

                Workspaces {
                    id: workspaces
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                implicitWidth: 360
                implicitHeight: 40
                anchors.verticalCenter: parent.verticalCenter
                color: ColorUtils.transparentize(Colors.md3.surface_container_high, root.transparent ? 1 : 0.4)
                radius: height / 2.5
                Row {
                    anchors.centerIn: parent
                    spacing: 16
                    ClockWidget {}
                }
            }
        }
        Connectivity {
            shouldBeTransparent: root.shouldBeTransparent

            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                rightMargin: 28
            }
        }
    }

    RoundCorner {
        visible: !root.transparent && !root.floating
        side: RoundCorner.Side.Left
        color: background.color
        anchors {
            top: background.bottom
            left: background.left
        }
    }

    RoundCorner {
        visible: !root.transparent && !root.floating
        side: RoundCorner.Side.Right
        color: background.color
        anchors {
            top: background.bottom
            right: background.right
        }
    }
}

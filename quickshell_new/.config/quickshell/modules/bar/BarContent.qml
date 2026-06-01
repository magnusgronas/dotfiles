import QtQuick

import qs.modules.bar.widgets
import qs.common.functions
import qs.common.widgets
import qs.common

Item {
    id: root

    Rectangle {
        id: background
        anchors.fill: parent
        color: ColorUtils.transparentize(Colors.md3.surface, 0.11)

        Row {
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
                color: ColorUtils.transparentize(Colors.md3.surface_container_high, 0.4)
                radius: height / 2.5
                StyledText {
                    anchors.centerIn: parent
                    text: "PLACEHOLDER"
                }
            }
            Rectangle {
                id: workspaceContainer
                implicitHeight: workspaces.implicitHeight - 10
                implicitWidth: workspaces.implicitWidth + 32
                anchors.verticalCenter: parent.verticalCenter
                color: ColorUtils.transparentize(Colors.md3.surface_container_high, 0.4)
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
                color: ColorUtils.transparentize(Colors.md3.surface_container_high, 0.4)
                radius: height / 2.5
                Row {
                    anchors.centerIn: parent
                    spacing: 16
                    ClockWidget {
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    BatteryWidget {
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    RoundCorner {
        side: RoundCorner.Side.Left
        color: background.color
        anchors {
            top: background.bottom
            left: background.left
        }
    }

    RoundCorner {
        side: RoundCorner.Side.Right
        color: background.color
        anchors {
            top: background.bottom
            right: background.right
        }
    }
}

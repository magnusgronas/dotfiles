pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

import qs.common.widgets
import qs.modules.bar
import qs.modules.bar.widgets

Item {
    id: root

    property var screen: root.QsWindow.window?.screen
    property int centerSideModuleWidth: 360

    Loader {
        anchors.fill: barBackground
        sourceComponent: StyledRectangularShadow {
            anchors.fill: undefined
            target: barBackground
        }
    }

    Rectangle {
        id: barBackground
        anchors.fill: parent
        color: "#121318"
        // color: "red"
    }

    MouseArea {
        id: leftSide

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: middleSection.left
        }

        RowLayout {
            id: leftSideRowLayout
            anchors.fill: parent
            spacing: 10

            WindowWidget {
                Layout.leftMargin: 23
                Layout.rightMargin: 23
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }

    Row {
        id: middleSection
        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 4

        BarGroup {
            id: leftCenterGroup
            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: root.centerSideModuleWidth

            Media {
                Layout.leftMargin: 20
                Layout.fillWidth: true
            }
        }

        BarGroup {
            id: middleCenterGroup
            anchors.verticalCenter: parent.verticalCenter
            padding: workspacesWidget.widgetPadding

            Workspaces {
                id: workspacesWidget
                Layout.fillHeight: true
            }
        }
        MouseArea {
            id: rightCenterGroup
            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: root.centerSideModuleWidth
            implicitHeight: rightCenterGroupContent.implicitHeight

            BarGroup {
                id: rightCenterGroupContent
                anchors.fill: parent

                ClockWidget {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }

                BatteryIndicator {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 100
                    Layout.rightMargin: 20
                }
            }
        }
    }
    MouseArea {
        id: rightSide
    }
}

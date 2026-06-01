pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland

import QtQuick

import qs.common

Scope {
    id: root
    property int cornerRadius: Appearance.sizes.roundCornerSize
    property int barHeight: Appearance.sizes.barHeight

    Variants {
        model: Quickshell.screens

        LazyLoader {
            id: barLoader
            required property ShellScreen modelData
            active: true

            component: PanelWindow {
                id: barRoot
                screen: barLoader.modelData
                color: "transparent"

                anchors {
                    left: true
                    top: true
                    right: true
                }

                implicitHeight: root.barHeight + root.cornerRadius
                exclusiveZone: root.barHeight
                exclusionMode: ExclusionMode.Ignore
                WlrLayershell.namespace: "quickshell:bar"

                MouseArea {
                    id: hoverRegion
                    anchors.fill: parent

                    BarContent {
                        id: barContent
                        implicitHeight: root.barHeight
                        anchors {
                            left: parent.left
                            top: parent.top
                            right: parent.right
                        }
                    }
                }
            }
        }
    }
}

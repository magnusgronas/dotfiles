pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland

import QtQuick

import qs.common

Scope {
    id: root
    property int cornerRadius: Appearance.sizes.roundCornerSize
    property int barHeight: Appearance.sizes.barHeight
    property bool floating: false
    property bool transparent: true

    Variants {
        model: Quickshell.screens

        LazyLoader {
            id: barLoader
            required property ShellScreen modelData
            // TODO: Should not be active under certain conditions, e.g. when lockscreen is active (semi-optimizaition ig)
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

                margins {
                    top: root.floating ? 8 : 0
                    right: root.floating ? 8 : 0
                    left: root.floating ? 8 : 0
                }

                implicitHeight: root.barHeight + (root.transparent ? 0 : root.cornerRadius)
                exclusiveZone: root.barHeight
                exclusionMode: ExclusionMode.Ignore
                WlrLayershell.namespace: "quickshell:bar"

                BarContent {
                    id: barContent
                    implicitHeight: root.barHeight
                    floating: root.floating
                    transparent: root.transparent
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

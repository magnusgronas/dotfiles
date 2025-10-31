pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import qs.modules.bar.widgets
import qs.common.widgets
import qs.common

// TODO: MAKE PART OF GLOBAL CONFIG
Scope {
    id: root

    // NOTE: Variants makes the module get copied for each specified "model",
    // here the PanelWindow will be copied for every item in Quickshell.screens
    Variants {
        model: Quickshell.screens

        LazyLoader {
            id: barLoader
            // active: States.showBar && !States.screenLocked
            active: true
            required property ShellScreen modelData
            component: PanelWindow {
                id: barRoot
                screen: barLoader.modelData

                exclusiveZone: 50
                exclusionMode: ExclusionMode.Ignore
                WlrLayershell.namespace: "quickshell:bar"
                implicitHeight: 50 + 23
                mask: Region {
                    item: hoverMaskRegion
                }
                
                color: "transparent"

                anchors {
                    top: true
                    left: true
                    right: true
                }

                MouseArea {
                    id: hoverRegion
                    hoverEnabled: true
                    anchors.fill: parent

                    Item {
                        id: hoverMaskRegion
                        anchors.fill: barConent
                    }

                    BarContent {
                        id: barConent
                        implicitHeight: 50
                        anchors {
                            right: parent.right
                            left: parent.left
                            top: parent.top
                        }
                    }

                    Loader {
                        id: roundCorners
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: barConent.bottom
                        }
                        height: 23
                        active: true

                        sourceComponent: Item {
                            implicitHeight: 23
                            RoundCorner {
                                id: leftCorner
                                anchors {
                                    top: parent.top
                                    bottom: parent.bottom
                                    left: parent.left
                                }

                                implicitSize: 23
                                color: "#121318"
                                corner: RoundCorner.CornerEnum.TopLeft
                            }
                            RoundCorner {
                                id: rightCorner
                                anchors {
                                    right: parent.right
                                    top: parent.top
                                    bottom: undefined
                                }
                                implicitSize: 23
                                color: "#121318"

                                corner: RoundCorner.CornerEnum.TopRight
                            }
                        }
                    }
                }
            }
        }
    }
}

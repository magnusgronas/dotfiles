pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.services
import qs.common.widgets

Scope {
    id: root

    property bool showOsd: false
    property real volume

    property bool pinTop: false

    function show(): void {
        showOsd = true;
        osdTimeout.restart();
    }

    function dimWhenMuted() {
        return (Audio.muted) ? Qt.alpha("#e3e2e9", 0.4) : "#e3e2e9";
    }

    // Listen to volume changes
    Connections {
        target: Audio

        function onVolumeChanged() {
            root.show();
            root.volume = Audio.volume;
        }
        function onMutedChanged() {
            root.show();
        }
    }

    // Timeout timer
    Timer {
        id: osdTimeout
        repeat: false
        running: false

        interval: 1000 // 1 second
        onTriggered: root.showOsd = false
    }

    LazyLoader {
        id: osdLoader
        active: root.showOsd

        PanelWindow {
            id: osdRoot
            // anchors.bottom: true
            anchors {
                bottom: !root.pinTop
                top: root.pinTop
            }
            // margins.bottom: screen.height / 16
            margins {
                top: screen.height / 16
                bottom: screen.height / 16
            }
            exclusiveZone: 0

            WlrLayershell.namespace: "quickshell:onScreenDisplay"
            WlrLayershell.layer: WlrLayer.Overlay

            implicitWidth: 300
            implicitHeight: 80
            color: "transparent"

            // Remove the osd when hovering over it
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: root.showOsd = false
            }

            // Shadow
            StyledRectangularShadow {
                target: valueIndicator
            }

            Rectangle {
                id: valueIndicator
                anchors {
                    fill: parent
                    margins: 5
                }
                radius: height / 2
                color: "#1e1f25"

                implicitWidth: parent.implicitWidth
                implicitHeight: parent.implicitHeight

                RowLayout {
                    id: valueRow
                    Layout.margins: 10
                    anchors.fill: parent
                    spacing: 10

                    Item {
                        implicitWidth: 40
                        implicitHeight: 40
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 18

                        MaterialSymbol {
                            // verticalAlignment: Qt.AlignVCenter
                            text: Audio.volumeText
                            fill: 1
                            iconSize: 40
                            color: root.dimWhenMuted()
                            
                        }

                        // IconImage {
                        //     implicitSize: parent.implicitWidth
                        //     source: Audio.volumeIcon()
                        // }
                    }
                    ColumnLayout {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.rightMargin: 20
                        spacing: 5

                        RowLayout {
                            Layout.leftMargin: progressBar.height / 2
                            Layout.rightMargin: progressBar.height / 2

                            StyledText {
                                Layout.fillWidth: true
                                text: "Volume"
                                color: root.dimWhenMuted()
                                font.pixelSize: 20
                            }

                            StyledText {
                                Layout.fillWidth: false
                                text: Math.round(root.volume * 100)
                                color: root.dimWhenMuted()
                                font.pixelSize: 20
                            }
                        }

                        StyledProgressBar {
                            id: progressBar
                            barHeight: 6
                            barGap: 4
                            Layout.fillWidth: true
                            value: root.volume
                            // highlightColor: (Audio.muted) ? "#414659" : "#b3c5ff"
                            highlightColor: (Audio.muted) ? "#ffb4ab" : "#b3c5ff"
                        }
                    }
                }
            }
        }
    }
}

pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.services
import qs.common
import qs.common.widgets
import qs.common.functions

Scope {
    id: root

    Loader {
        id: connectivityMenuLoader
        active: States.connectivityMenuOpen

        Connections {
            target: States
            function onScreenLockedChanged() {
                if (States.screenLocked)
                    States.connectivityMenuOpen = false;
            }
        }

        sourceComponent: PanelWindow {
            id: menuRoot
            visible: connectivityMenuLoader.active

            function hide() {
                States.connectivityMenuOpen = false;
            }

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:connectivity-menu"
            WlrLayershell.layer: WlrLayer.Overlay

            anchors {
                top: true
                right: true
            }

            margins {
                top: Appearance.sizes.barHeight + 10
                right: 20
            }

            implicitWidth: 400
            implicitHeight: 500

            color: ColorUtils.transparentize(Colors.md3.background, 0.6)

            HyprlandFocusGrab {
                windows: [menuRoot]
                active: States.connectivityMenuOpen
                onCleared: menuRoot.hide()
            }

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape)
                    menuRoot.hide();
            }

            Rectangle {
                anchors.fill: parent
                color: Colors.md3.surface
                radius: Appearance.rounding.normal

                MouseArea {
                    anchors.fill: parent
                }

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 15

                    StyledText {
                        text: "Connectivity"
                        font.pixelSize: Appearance.font.size.title
                        font.weight: Font.Bold
                        color: Colors.md3.on_surface
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        StyledText {
                            text: "Wifi"
                            font.pixelSize: Appearance.font.size.large
                            color: Colors.md3.on_surface
                            Layout.fillWidth: true
                        }
                        StyledSwitch {
                            checked: Network.isWifiEnabled
                            onClicked: Network.toggleWifi()
                        }
                    }

                    StyledText {
                        text: Network.currentNetworkName
                        color: Network.color
                        font.pixelSize: Appearance.font.size.normal
                    }

                    // TODO: Map over Network.availableNetworks to display a ListView here

                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: Colors.md3.outline_variant
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        StyledText {
                            text: "Bluetooth"
                            font.pixelSize: Appearance.font.size.large
                            color: Colors.md3.on_surface
                            Layout.fillWidth: true
                        }
                        StyledSwitch {
                            checked: Bluetooth.enabled
                            onClicked: Bluetooth.toggleBluetooth()
                        }
                    }

                    StyledText {
                        text: Bluetooth.connected ? "Connected (" + Bluetooth.activeDeviceCount + ")" : "Disconnected"
                        color: Bluetooth.color
                        font.pixelSize: Appearance.font.size.normal
                    }

                    // TODO: Map over Bluetooth.friendlyDeviceList to display a ListView here

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
        }
    }
}

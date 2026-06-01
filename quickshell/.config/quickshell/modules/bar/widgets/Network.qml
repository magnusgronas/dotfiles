pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Hyprland

import qs.common.widgets
import qs.common
import qs.services

RippleButton {
    id: root

    implicitHeight: 50
    buttonRadius: implicitHeight / 2

    releaseAction: () => {
        Networking.startScanning();
    }

    altAction: event => {
        networkMenu.visible ? networkMenu.close() : networkMenu.open();
    }

    contentItem: RowLayout {
        id: contentLayout
        anchors.centerIn: parent
        spacing: 6

        MaterialSymbol {
            iconSize: 18
            text: Networking.icon
        }

        Variants {
            model: Networking.availableNetworks
            StyledText {
                required property var modelData
                text: modelData
                font.pixelSize: Appearance.font.size.small
            }
        }
    }
    PopupWindow {
        id: networkMenu
        color: "transparent"
        width: popupBackground.width
        height: popupBackground.height

        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }

        HyprlandFocusGrab {
            id: focusGrab
            windows: [networkMenu]
            onCleared: if (networkMenu.visible)
                networkMenu.close()
        }

        function open() {
            networkMenu.visible = true;
            focusGrab.active = true;
        }

        function close() {
            focusGrab.active = false;
            networkMenu.visible = false;
        }

        Rectangle {
            id: popupBackground
            width: 250 
            implicitHeight: menuLayout.implicitHeight + 16

            color: Appearance.colors.colLayer0
            radius: 12
            border.width: 1
            border.color: Appearance.colors.colLayer0Border

            ColumnLayout {
                id: menuLayout
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: 8
                }
                spacing: 4

                StyledText {
                    text: "Available Networks"
                    font.pixelSize: Appearance.font.size.small
                    opacity: 0.6
                    Layout.leftMargin: 8
                    Layout.bottomMargin: 4
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: Appearance.colors.colLayer0Border
                    Layout.bottomMargin: 4
                }

                Repeater {
                    model: Networking.availableNetworks

                    delegate: RippleButton {
                        id: networkButton
                        required property string modelData

                        Layout.fillWidth: true
                        implicitHeight: 32
                        buttonRadius: 6

                        contentItem: StyledText {
                            text: networkButton.modelData
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                        }

                        releaseAction: () => {
                            console.log("Attempting to connect to:", modelData);
                            networkMenu.close();
                        }
                    }
                }

                StyledText {
                    visible: Networking.availableNetworks.length === 0
                    text: Networking.isWifiEnabled ? "Scanning..." : "Wi-Fi is disabled"
                    Layout.alignment: Qt.AlignHCenter
                    opacity: 0.5
                }
            }
        }
    }
}

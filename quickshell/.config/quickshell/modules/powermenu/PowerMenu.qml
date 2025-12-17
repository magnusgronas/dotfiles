pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.services
import qs.common
import qs.common.widgets

Scope {
    id: root
    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
    property bool packageManagerRunning: false
    property bool downloadRunning: false

    component Description: Rectangle {
        id: description
        property string text
        property color textColor: Appearance.colors.colOnTooltip
        color: Appearance.colors.colTooltip
        clip: true
        radius: Appearance.rounding.normal

        Behavior on implicitWidth {
            animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
        }

        StyledText {
            id: descriptionText
            anchors.centerIn: parent
            color: description.textColor
            text: description.text
        }
    }

    function processIsRunning() {
        packageManagerRunning = false;
        downloadRunning = false;
        packageManagerProcIsRunning.running = false
        packageManagerProcIsRunning.running = true
        downloadProcIsRunning.running = false
        downloadProcIsRunning.running = true

    }

    Process {
        id: packageManagerProcIsRunning
        command: ["bash", "-c", "pidof pacman yay"]
        onExited: (exitCode, exitStatus) => {
            root.packageManagerRunning = (exitCode === 0);
        }
    }

    Process {
        id: downloadProcIsRunning
        command: ["bash", "-c", "pidof curl wget || rg --files --glob '*.part' $(xdg-user-dir DOWNLOAD)"]
        onExited: (exitCode, exitStatus) => {
            root.downloadRunning = (exitCode === 0);
        }
    }

    Loader {
        id: powerMenuLoader
        active: States.powerMenuOpen
        onActiveChanged: {
            if (powerMenuLoader.active) root.processIsRunning();
        }

        Connections {
            target: States
            function onScreenLockedChanged() {
                if (States.screenLocked) States.powerMenuOpen = false;
            }
        }

        sourceComponent: PanelWindow {
            id: menuRoot
            visible: powerMenuLoader.active
            property string subtitle: ""

            function hide() {
                States.powerMenuOpen = false;
            }

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:power-menu"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

            color: ColorUtils.transparantize(Appearance.m3colors.m3background, 0.04)
            
            anchors {
                top: true
                left: true
                right: true
            }

            implicitWidth: root.focusedScreen?.width ?? 0
            implicitHeight: root.focusedScreen?.height ?? 0

            MouseArea {
                id: menuMouseArea
                anchors.fill: parent
                onClicked: {
                    menuRoot.hide();
                }
            }

            ColumnLayout {
                id: content
                anchors.centerIn: parent
                spacing: 15

                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape || event.key === Qt.Key_Q) menuRoot.hide(); 
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 0
                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        font {
                            family: Appearance.font.family.title
                            pixelSize: Appearance.font.size.title
                            variableAxes: Appearance.font.variableAxes.title
                        }
                        text: "Power Menu"
                    }

                    StyledText {
                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Appearance.font.size.normal
                        text: "Arrow keys to navigate, Enter to select\nEsc or click anywhere to cancel"
                    }
                }
                GridLayout {
                    columns: 4
                    columnSpacing: 15
                    rowSpacing: 15

                    // TODO: Make `PowerMenuButton.qml`
                    PowerMenuButton {
                        id: lock
                        focus: menuRoot.visible
                        buttonIcon: "lock"
                        buttonText: "Lock"
                        onClicked: {
                            Session.lock();
                            menuRoot.hide();
                        }
                        onFocusChanged: {
                            if (focus) menuRoot.subtitle = buttonText;
                        }
                        // KeyNavigation.left:
                    }
                }

            }
            Description {
                Layout.alignment: Qt.AlignHCenter
                text: menuRoot.subtitle
            }


        }
    }
}

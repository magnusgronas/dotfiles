pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Qt5Compat.GraphicalEffects

import qs.services
import qs.common
import qs.common.widgets
import qs.common.functions

Scope {
    id: root

    readonly property var player: MprisController.activePlayer
    readonly property bool hasPlayer: player !== null
    readonly property bool hasTrack: MprisController.activeTrack !== undefined && MprisController.activeTrack !== null

    readonly property string trackTitle: hasTrack ? (MprisController.activeTrack.title || "Unknown Title") : "No Media Playing"
    readonly property string trackArtist: hasTrack && MprisController.activeTrack.artist !== "Unknown Artist" ? MprisController.activeTrack.artist : "Waiting for playback..."
    readonly property string artUrl: hasTrack ? (MprisController.activeTrack.artUrl || "") : ""

    readonly property real playerPos: hasPlayer && player.canSeek && player.positionSupported ? player.position : 0
    readonly property real playerLen: hasPlayer && player.lengthSupported ? player.length : 1

    function formatTime(milliseconds) {
        let seconds = Math.floor(milliseconds);
        let m = Math.floor(seconds / 60);
        let s = seconds % 60;
        return m + ":" + (s < 10 ? "0" : "") + s;
    }

    Timer {
        running: root.player && root.player.playbackState === MprisPlaybackState.Playing
        interval: 16
        repeat: true
        onTriggered: {
            root.player.positionChanged();
        }
    }

    Loader {
        id: menuLoader
        active: States.mediaMenuOpen

        Connections {
            target: States
            function onScreenLockedChanged() {
                if (States.screenLocked)
                    States.mediaMenuOpen = false;
            }
        }

        sourceComponent: PanelWindow {
            id: popupWindow

            readonly property int shadowMargin: 8

            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:media-controls"
            WlrLayershell.layer: WlrLayer.Overlay

            anchors {
                top: true
                left: true
            }

            margins {
                top: Appearance.sizes.barHeight + 20 - shadowMargin
                left: States.mediaWidgetCenterX - (implicitWidth / 2)
            }

            implicitWidth: 480 + (shadowMargin * 2)
            implicitHeight: contentLayout.implicitHeight + (shadowMargin * 2) + 60
            color: "transparent"

            HyprlandFocusGrab {
                windows: [popupWindow]
                active: States.mediaMenuOpen
                onCleared: States.mediaMenuOpen = false
            }

            StyledShadow {
                target: background
            }

            Rectangle {
                id: background
                anchors.fill: parent
                anchors.margins: popupWindow.shadowMargin

                color: ColorUtils.transparentize(Colors.md3.surface_container_high, 0.1)
                radius: Appearance?.rounding.large

                Rectangle {
                    id: imageMask
                    anchors.fill: parent
                    radius: parent.radius
                    visible: false
                }

                Image {
                    id: albumImage
                    anchors.fill: parent
                    source: root.artUrl
                    fillMode: Image.PreserveAspectCrop
                    visible: false
                }

                OpacityMask {
                    anchors.fill: parent
                    source: albumImage
                    maskSource: imageMask
                    visible: root.hasTrack && root.artUrl !== ""
                }

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: ColorUtils.transparentize(Colors.md3.surface, 0.25)
                    visible: root.hasTrack && root.artUrl !== ""
                }

                ColumnLayout {
                    id: contentLayout
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        ColumnLayout {
                            StyledText {
                                Layout.fillWidth: true
                                text: root.trackTitle
                                font.pixelSize: Appearance?.font?.size?.large
                                font.weight: Font.Bold
                                elide: Text.ElideRight
                            }

                            StyledText {
                                Layout.fillWidth: true
                                text: root.trackArtist
                                font.pixelSize: Appearance?.font?.size?.normal
                                font.weight: Font.Medium
                                elide: Text.ElideRight
                            }
                        }
                        RippleButton {
                            id: repeatButton
                            implicitWidth: 38
                            implicitHeight: 38
                            buttonRadius: implicitHeight / 2
                            onClicked: MprisController.cycleLoopState()

                            readonly property bool isLoopNone: MprisController.loopState === MprisLoopState.None
                            readonly property bool isLoopTrack: MprisController.loopState === MprisLoopState.Track

                            contentItem: MaterialSymbol {
                                symbol: repeatButton.isLoopTrack ? "repeat_one" : "repeat"
                                iconSize: 24
                                color: ColorUtils.transparentize(Colors.md3.inverse_surface, repeatButton.isLoopNone ? 0.6 : 0)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        RippleButton {
                            implicitWidth: 38
                            implicitHeight: 38
                            buttonRadius: implicitHeight / 2
                            colBackground: "transparent"
                            onClicked: MprisController.setShuffle(!MprisController.hasShuffle)
                            visible: MprisController.shuffleSupported
                            contentItem: MaterialSymbol {
                                iconSize: 24
                                color: ColorUtils.transparentize(Colors.md3.inverse_surface, MprisController.hasShuffle ? 0 : 0.6)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                symbol: "shuffle"
                            }
                        }
                        RippleButton {
                            implicitWidth: 64
                            implicitHeight: 64
                            buttonRadius: MprisController.isPlaying ? Appearance.rounding.normal : implicitHeight / 2
                            scale: down ? 1.15 : 1.00
                            colBackground: Colors.md3.primary
                            colBackgroundHover: ColorUtils.colorWithLightness(Colors.md3.primary, 0.9)
                            onClicked: MprisController.togglePlaying()

                            contentItem: MaterialSymbol {
                                symbol: MprisController.isPlaying ? "pause" : "play_arrow"
                                iconSize: 36
                                color: Colors.md3.on_primary
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            Behavior on buttonRadius {
                                NumberAnimation {
                                    duration: 250
                                    easing.type: Easing.OutCubic
                                }
                            }
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 350
                                    easing.type: Easing.OutBack
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        visible: root.hasPlayer && root.playerLen > 0

                        RippleButton {
                            implicitWidth: 40
                            implicitHeight: 40
                            buttonRadius: 20
                            colBackground: "transparent"
                            colBackgroundHover: ColorUtils.transparentize(Colors.md3.surface_variant, 0.7)
                            onClicked: MprisController.previous()

                            contentItem: MaterialSymbol {
                                symbol: "skip_previous"
                                iconSize: 24
                                color: Colors.md3.on_surface
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        StyledSlider {
                            id: progressSlider
                            Layout.fillWidth: true
                            wavy: true
                            isAnimated: MprisController.isPlaying
                            shouldShowHandle: true
                            tooltipContent: root.formatTime(progressSlider.value)
                            lineWidth: 6

                            from: 0
                            to: root.playerLen > 0 ? root.playerLen : 1

                            Binding on value {
                                when: !progressSlider.pressed
                                value: root.playerPos
                            }
                            onPressedChanged: {
                                if (!pressed)
                                    MprisController.seekTo(progressSlider.value);
                            }
                        }
                        RippleButton {
                            implicitWidth: 40
                            implicitHeight: 40
                            buttonRadius: 20
                            colBackground: "transparent"
                            colBackgroundHover: ColorUtils.transparentize(Colors.md3.surface_variant, 0.7)
                            onClicked: MprisController.next()

                            contentItem: MaterialSymbol {
                                symbol: "skip_next"
                                iconSize: 24
                                color: Colors.md3.on_surface
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                    StyledText {
                        Layout.topMargin: -40
                        Layout.alignment: Qt.AlignHCenter
                        text: `${root.formatTime(root.playerPos)} / ${root.formatTime(root.playerLen)}`
                        font.family: Appearance?.font.family.mono
                        font.pixelSize: Appearance?.font.size.small
                        font.weight: Font.DemiBold
                        color: Colors.md3.on_surface
                    }
                }
            }
        }
    }
}

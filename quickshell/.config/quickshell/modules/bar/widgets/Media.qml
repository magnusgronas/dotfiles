import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import qs.common
import qs.common.widgets
import qs.services

Item {
    id: root
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property string title: activePlayer?.trackTitle || ""
    readonly property string artist: activePlayer?.trackArtist ? ` • ${activePlayer?.trackArtist}` : ""

    Layout.fillHeight: true
    implicitWidth: rowLayout.implicitWidth + rowLayout.spacing * 2
    implicitHeight: 50

    Timer {
        running: root.activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: 3000
        repeat: true
        onTriggered: root.activePlayer.positionChanged()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton | Qt.BackButton | Qt.ForwardButton | Qt.RightButton | Qt.LeftButton
        hoverEnabled: true
        onPressed: event => {
            if (event.button === Qt.MiddleButton) {
                root.activePlayer.togglePlaying();
            } else if (event.button === Qt.BackButton) {
                root.activePlayer.previous();
            } else if (event.button === Qt.ForwardButton || event.button === Qt.RightButton) {
                root.activePlayer.next();
            } else if (event.button === Qt.LeftButton) {
                States.mediaPopupOpen = !States.mediaPopupOpen
            }
        }
    }

    RowLayout {
        id: rowLayout

        spacing: 10
        anchors.fill: parent

        Item {
            Layout.alignment: Qt.AlignVCenter
            CircularProgress {
                id: mediaCircProg
                anchors.centerIn: parent
                visible: root.activePlayer?.trackTitle ? true : false
                lineWidth: 2
                value: root.activePlayer?.position / root.activePlayer?.length
                implicitSize: 30
                colPrimary: "#dde2f9"
                enableAnimation: false

                Item {
                    anchors.centerIn: parent
                    width: mediaCircProg.implicitSize
                    height: mediaCircProg.implicitSize

                    MaterialSymbol {
                        anchors.centerIn: parent
                        fill: 1
                        text: root.activePlayer?.isPlaying ? "pause" : "music_note"
                        iconSize: mediaCircProg.implicitSize / 2
                        color: "#dde2f9"
                    }
                }
            }
            MaterialSymbol {
                anchors.centerIn: parent
                visible: !mediaCircProg.visible
                fill: 1
                text: "music_off"
                iconSize: mediaCircProg.implicitSize - 6
                color: "#45464f"
            }
        }

        StyledText {
            visible: true
            // width: rowLayout.width - (mediaCircProg.implicitWidth + rowLayout.spacing * 2)
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.rightMargin: rowLayout.spacing
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            color: "#45464f"
            text: `${root.title}${root.artist}`
        }
    }
}

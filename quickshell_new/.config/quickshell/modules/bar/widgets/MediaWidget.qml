pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import Qt5Compat.GraphicalEffects

import qs.common
import qs.common.widgets
import qs.services

Item {
    id: root

    property bool isHovered: false

    readonly property bool hasMedia: MprisController.activePlayer !== null
    readonly property string trackTitle: hasMedia ? MprisController.activeTrack.title : "No Media"
    readonly property string trackArtist: {
        if (!hasMedia)
            return "";
        return MprisController.activeTrack.artist !== "Unknown Artist" ? MprisController.activeTrack.artist : "";
    }

    readonly property real textTrans: MprisController.isPlaying ? 1 : 0.4

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onEntered: root.isHovered = true
        onExited: root.isHovered = false

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onEntered: root.isHovered = true
            onExited: root.isHovered = false

            onClicked: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    let absolutePos = mapToItem(null, width / 2, 0);
                    States.mediaWidgetCenterX = absolutePos.x;
                    States.mediaMenuOpen = !States.mediaMenuOpen;
                } else if (mouse.button === Qt.MiddleButton) {
                    MprisController.togglePlaying();
                } else if (mouse.button === Qt.RightButton) {
                    if (MprisController.activePlayer)
                        MprisController.activePlayer.next();
                }
            }
        }
    }
    RowLayout {
        id: layout
        anchors.centerIn: parent
        width: Math.min(implicitWidth, parent.width)
        spacing: 10

        Item {
            id: content
            width: 30
            height: 30
            Layout.alignment: Qt.AlignVCenter

            Rectangle {
                id: imageMask
                anchors.fill: parent
                radius: content.height / 2
                visible: false
            }

            Image {
                id: albumImage
                anchors.fill: parent
                source: MprisController.activeTrack.artUrl
                fillMode: Image.PreserveAspectCrop
                opacity: (source !== "" && !root.isHovered) ? root.textTrans : 0
                visible: false
            }

            OpacityMask {
                anchors.fill: parent
                source: albumImage
                maskSource: imageMask

                opacity: (albumImage.source !== "" && !root.isHovered) ? root.textTrans : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }

            MaterialSymbol {
                anchors.centerIn: parent
                iconSize: Appearance.font.size.large
                symbol: "music_note"
                color: Colors.md3.on_surface

                opacity: !root.hasMedia ? root.textTrans : (MprisController.activeTrack.artUrl == "" && !root.isHovered) ? root.textTrans : 0
                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }
            Row {
                anchors.centerIn: parent
                spacing: 4
                opacity: root.isHovered ? 1 : 0
                visible: opacity > 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }

                MaterialSymbol {
                    iconSize: Appearance.font.size.normal
                    symbol: MprisController.isPlaying ? "pause" : "play_arrow"
                    visible: root.hasMedia
                    color: Colors.md3.primary
                }
            }
        }

        Column {
            id: textContainer
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: -4

            Layout.preferredWidth: Math.max(titleText.implicitWidth, artistText.implicitWidth)

            StyledText {
                id: titleText
                width: parent.width + 5
                text: root.trackTitle
                font.pixelSize: Appearance.font.size.small
                font.weight: Font.Medium
                color: Colors.md3.on_surface_variant
                opacity: root.textTrans
                elide: Text.ElideRight

                axes: ({
                        "ROND": 100
                    })

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }

            StyledText {
                id: artistText
                width: parent.width
                text: root.trackArtist
                font.pixelSize: Appearance.font.size.smallest + 2
                color: Colors.md3.on_surface
                opacity: MprisController.isPlaying ? 0.6 : root.textTrans - 0.1
                elide: Text.ElideRight
                visible: text !== ""

                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }
        }
    }
}

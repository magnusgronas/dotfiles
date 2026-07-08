pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.common
import qs.common.widgets
import qs.common.functions
import qs.services

Scope {
    id: root
    property int shadowPadding: 30

    PanelWindow {
        anchors {
            top: true
            right: true
        }
        margins {
            top: Appearance.sizes.barHeight + 12
            right: 12
        }
        implicitWidth: 380 + (root.shadowPadding * 2)
        implicitHeight: Math.max(1, column.implicitHeight) + (root.shadowPadding * 2)

        WlrLayershell.namespace: "quickshell:notification"
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        ColumnLayout {
            id: column
            anchors.fill: parent
            anchors.margins: root.shadowPadding
            spacing: 4

            Repeater {
                id: repeater
                model: NotifServer.trackedNotifications

                delegate: Rectangle {
                    id: card
                    required property var modelData

                    Timer {
                        running: card.modelData.urgency !== NotificationUrgency.Critical
                        // TODO: Make part of config
                        interval: 5000
                        onTriggered: card.modelData.dismiss()
                    }

                    required property int index
                    color: ColorUtils.transparentize(Colors.md3.surface_container, 0.4)

                    Layout.fillWidth: true
                    Layout.preferredHeight: layout.implicitHeight + 20

                    topLeftRadius: index === 0 ? Appearance.rounding.normal : 4
                    topRightRadius: index === 0 ? Appearance.rounding.normal : 4
                    bottomLeftRadius: index === repeater.count - 1 ? Appearance.rounding.normal : 4
                    bottomRightRadius: index === repeater.count - 1 ? Appearance.rounding.normal : 4

                    StyledShadow {
                        z: -1
                        target: card
                    }

                    RowLayout {
                        id: layout
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10
                        Rectangle {
                            id: notifRect

                            readonly property bool isRich: card.modelData.image && card.modelData.image.toString() !== "" && !notifImage.source.toString().includes("assets/icons")

                            Layout.preferredHeight: 50
                            Layout.preferredWidth: 50
                            Layout.alignment: Qt.AlignTop
                            radius: width / 2
                            color: isRich ? "transparent" : Colors.md3.surface_container_highest

                            Item {
                                width: notifRect.isRich ? notifRect.width : 32
                                height: notifRect.isRich ? notifRect.height : 32
                                anchors.centerIn: parent

                                Image {
                                    id: notifImage
                                    anchors.fill: parent
                                    visible: !overlay.visible
                                    fillMode: Image.PreserveAspectCrop

                                    source: {
                                        if (card.modelData.image && card.modelData.image.toString() !== "") {
                                            return card.modelData.image;
                                        }
                                        if (card.modelData.appIcon && card.modelData.appIcon.toString() !== "") {
                                            return Quickshell.iconPath(card.modelData.appIcon, "/home/magnus/.config/quickshell/assets/icons/info.svg");
                                        }
                                        return Quickshell.iconPath("/home/magnus/.config/quickshell/assets/icons/info.svg");
                                    }
                                    layer.enabled: true
                                    layer.effect: OpacityMask {
                                        maskSource: Rectangle {
                                            width: notifImage.width
                                            height: notifImage.height

                                            radius: notifImage.width / 2
                                        }
                                    }
                                }
                                ColorOverlay {
                                    id: overlay
                                    anchors.fill: notifImage
                                    source: notifImage
                                    color: Colors.md3.on_surface
                                    visible: notifImage.source.toString().includes("assets/icons")
                                }
                            }
                        }
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2
                            StyledText {
                                Layout.fillWidth: true
                                text: card.modelData.summary
                                font.bold: true
                                elide: Text.ElideRight
                            }
                            StyledText {
                                Layout.fillWidth: true
                                visible: text !== ""
                                text: card.modelData.body
                                wrapMode: Text.WordWrap
                            }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: card.modelData.dismiss()
                    }
                }
            }
        }
    }
}

pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

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
                        Item {
                            Layout.preferredHeight: 42
                            Layout.preferredWidth: 42
                            Layout.alignment: Qt.AlignTop

                            IconImage {
                                id: notifImage
                                anchors.fill: parent
                                visible: card.modelData.image && card.modelData.image.toString() !== ""
                                source: visible ? card.modelData.image : ""
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

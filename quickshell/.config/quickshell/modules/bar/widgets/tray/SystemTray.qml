import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

import qs.common.widgets

// TODO: MAKE PART OF GLOBAL CONFIG
Item {
    id: root
    implicitHeight: gridLayout.implicitHeight
    implicitWidth: gridLayout.implicitWidth

    RowLayout {
        id: gridLayout
        anchors.fill: parent

        Repeater {
            model: ScriptModel {
                values: SystemTray.items.values.filter(i => i.status !== Status.Passive)
            }
            SysTrayItem {
                required property var modelData
                item: modelData
                Layout.fillWidth: true
                onClicked: event => {
                    if (event.button === Qt.LeftButton) {
                        modelData.activate()
                    } else {
                        modelData.secondaryActivate()
                    }
                }
            }
        }
        MaterialSymbol {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "circle"
            fill: 1
            iconSize: 8
            visible: SystemTray.items.values.length > 0
        }
    }
}

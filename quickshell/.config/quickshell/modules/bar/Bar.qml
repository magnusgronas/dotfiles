import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.modules.bar.widgets
import qs.common.widgets
import qs.common

Scope {
    id: root

    // NOTE: Variants makes the module get copied for each specified "model",
    // here the PanelWindow will be copied for every item in Quickshell.screens
    Variants {
        model: Quickshell.screens

        PanelWindow {
            visible: States.showBar
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 50
            color: "#121318"

            Text {
                id: test
                anchors.centerIn: parent
                text: "Test"
                color: "white"
            }

            RowLayout {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 40
                BatteryIndicator {
                    Layout.leftMargin: 40
                }
                ClockWidget {

                }
                WindowWidget {
                    Layout.leftMargin: 200
                }
                Media {
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.common
import qs.common.widgets
import qs.common.functions

import qs.modules.bar.widgets

Row {
    id: root
    required property bool shouldBeTransparent

    spacing: 8

    RippleButton {
        implicitWidth: iconsRow.implicitWidth + 20
        implicitHeight: 38

        anchors.verticalCenter: parent.verticalCenter

        buttonRadius: height / 2
        colBackgroundHover: ColorUtils.transparentize(Colors.md3.surface_container, 0.6)

        Row {
            id: iconsRow
            anchors.centerIn: parent
            spacing: 12

            // TODO: Make Bluetooth widget
            BluetoothWidget {
                anchors.verticalCenter: parent.verticalCenter
            }

            NetworkWidget {
                anchors.verticalCenter: parent.verticalCenter
            }

        }

        onClicked: {
            console.log("Wifi / Bluetooth menu opened");
        }
    }

    BatteryWidget {
        anchors.verticalCenter: parent.verticalCenter
    }
}

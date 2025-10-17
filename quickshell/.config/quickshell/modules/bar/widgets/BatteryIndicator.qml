import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.common.widgets

MouseArea {
    id: root
    property bool borderless: false
    property bool isHovering: containsMouse
    readonly property var chargeState: Battery.chargeState
    readonly property bool isCharging: Battery.isCharging
    readonly property bool isPluggedIn: Battery.isPluggedIn
    readonly property real percentage: Battery.percentage
    readonly property bool isLow: Battery.isLow
    readonly property bool isCritical: Battery.isCritical
    property var progressType: BatteryProgressBar

    implicitWidth: batteryProgress.implicitWidth
    implicitHeight: batteryProgress.implicitHeight

    hoverEnabled: true
    onEntered: console.log("Battery indicator mousearea entered")
    onExited: isHovering = false

    BatteryProgressBar {
        id: batteryProgress
        anchors.centerIn: parent
        value: root.percentage
        highlightColor: Battery.statusColor
        valueBarWidth: 30
        fontSize: 14
        RowLayout {
            anchors.centerIn: parent
            spacing: 0

            MaterialSymbol {
                id: boltIcon
                Layout.leftMargin: -4
                Layout.rightMargin: -2
                fill: 1
                text: "bolt"
                iconSize: batteryProgress.fontSize
                color: "#070A07"
                visible: root.isCharging && root.percentage < 1
            }
            Text {
                text: batteryProgress.text
                font.pixelSize: batteryProgress.fontSize
            }
        }
    }
    BatteryPopup {
        id: batteryPopup
        hoverTarget: root
    }
}

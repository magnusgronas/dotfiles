import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.services
import qs.common.widgets
import qs.common

// TODO: MAKE PART OF GLOBAL CONFIG
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

    property bool showProfileIndicator: false

    implicitWidth: batteryProgress.implicitWidth
    implicitHeight: batteryProgress.implicitHeight

    hoverEnabled: true
    onExited: isHovering = false

    onClicked: cyclePowerProfile()

    Timer {
        id: powerProfileChangedTimer
        repeat: false
        running: false

        interval: 1000
        onTriggered: root.showProfileIndicator = false
    }

    function cyclePowerProfile() {
        showProfileIndicator = true
        powerProfileChangedTimer.restart();
        Battery.cyclePowerProfiles();
    }

    MaterialSymbol {
        text: Battery.profileIcon
        anchors {
            right: batteryProgress.left
            verticalCenter: batteryProgress.verticalCenter
            rightMargin: 2
        }
        iconSize: 18
        opacity: root.showProfileIndicator ? 1 : 0
        color: Battery.profileColor
        fill: 1
        Behavior on opacity {
            animation: Appearance?.animation.elementMoveFast.numberAnimation.createObject(this)
        }
    }
    BatteryProgressBar {
        id: batteryProgress
        anchors.centerIn: parent
        value: root.percentage
        highlightColor: Battery.statusColor
        RowLayout {
            anchors.centerIn: parent
            spacing: -2

            MaterialSymbol {
                id: boltIcon
                Layout.leftMargin: -2
                fill: 1
                text: "bolt"
                iconSize: batteryProgress.fontSize
                color: Appearance.colors.colSurface
                visible: root.isCharging && root.percentage < 1
            }
            StyledText {
                Layout.topMargin: 4
                text: batteryProgress.text
                font.pixelSize: batteryProgress.fontSize
                color: Appearance.colors.colSurface
            }
        }
    }
    BatteryPopup {
        id: batteryPopup
        hoverTarget: root
    }

}

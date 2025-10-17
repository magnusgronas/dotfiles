import QtQuick
import QtQuick.Layouts

import qs.common.widgets
import qs.services
StyledPopup {
    id: root
    
    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        spacing: 4

        // Header
        Row {
            id: header
            spacing: 5

            MaterialSymbol {
                anchors.verticalCenter: parent.verticalCenter
                fill: 0
                font.weight: Font.Medium
                text: "battery_android_full"
                iconSize: 17
                color: "#c5c6d0"
            }

            StyledText {
                anchors.verticalCenter: parent.verticalCenter
                text: "Battery"
                font {
                    weight: Font.Medium
                    pixelSize: 13
                }
                color: "#c5c6d0"
            }
        }

        // This row is hidden when the battery is full.
        RowLayout {
            spacing: 5
            Layout.fillWidth: true
            property bool rowVisible: {
                let timeValue = Battery.isCharging ? Battery.timeToFull : Battery.timeToEmpty;
                let power = Battery.energyRate;
                return !(Battery.chargeState == 4 || timeValue <= 0 || power <= 0.01);
            }
            visible: rowVisible
            opacity: rowVisible ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 500
                }
            }

            MaterialSymbol {
                text: "schedule"
                color: "#c5c6d0"
                iconSize: 17
            }
            StyledText {
                text: Battery.isCharging ? "Time to full:" : "Time to empty:"
                color: "#c5c6d0"
            }
            StyledText {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                color: "#c5c6d0"
                text: {
                    function formatTime(seconds) {
                        var h = Math.floor(seconds / 3600);
                        var m = Math.floor((seconds % 3600) / 60);
                        if (h > 0)
                            return `${h}h, ${m}m`;
                        else
                            return `${m}m`;
                    }
                    if (Battery.isCharging)
                        return formatTime(Battery.timeToFull);
                    else
                        return formatTime(Battery.timeToEmpty);
                }
            }
        }

        RowLayout {
            spacing: 5
            Layout.fillWidth: true

            property bool rowVisible: !(Battery.chargeState != 4 && Battery.energyRate == 0)
            visible: rowVisible
            opacity: rowVisible ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 500
                }
            }

            MaterialSymbol {
                text: "bolt"
                color: "#c5c6d0"
                iconSize: 17
            }

            StyledText {
                text: {
                    if (Battery.chargeState == 4) {
                        return "Fully charged";
                    } else if (Battery.chargeState == 1) {
                        return "Charging:";
                    } else {
                        return "Discharging:";
                    }
                }
                color: "#c5c6d0"
            }

            StyledText {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                color: "#c5c6d0"
                text: {
                    if (Battery.chargeState == 4) {
                        return "";
                    } else {
                        return `${Battery.energyRate.toFixed(2)}W`;
                    }
                }
            }
        }
    }
}

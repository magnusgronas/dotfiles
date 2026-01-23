import QtQuick
import QtQuick.Layouts

import qs.common.widgets
import qs.services

// TODO: MAKE PART OF GLOBAL CONFIG
StyledPopup {
    id: root
    
    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        // spacing: 4

        // Header
        Row {
            id: header
            spacing: 5

            MaterialSymbol {
                // anchors.verticalCenter: parent.verticalCenter
                fill: 0
                text: "battery_android_full"
                iconSize: 20
                color: "#c5c6d0"
            }

            StyledText {
                id: headerText
                anchors.verticalCenter: parent.verticalCenter
                text: `${Math.round(Battery.percentage * 100)} %`
                font {
                    weight: Font.DemiBold
                    pixelSize: 18
                }
                color: "#c5c6d0"
            }
        }

        RowLayout {
            Layout.fillWidth: true
            MaterialSymbol {
                text: "charger"
                color: "#c5c6d0"
                fill: 1
                iconSize: 20
            }
            StyledText {
                text: Battery.currentPowerProfile
                color: "#c5c6d0"
                font.pixelSize: 16
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
                fill: 1
                iconSize: 20
            }
            StyledText {
                text: Battery.isCharging ? "Time to full:" : "Time to empty:"
                color: "#c5c6d0"
                font.pixelSize: 16
            }
            StyledText {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                color: "#c5c6d0"
                font.pixelSize: 16
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
                fill: 1
                iconSize: 20
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
                font.pixelSize: 16
            }

            StyledText {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignRight
                color: "#c5c6d0"
                font.pixelSize: 16
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

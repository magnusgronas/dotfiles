pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

import qs.common

// TODO: MAKE PART OF GLOBAL CONFIG
Singleton {

    property bool available: UPower.displayDevice.isLaptopBattery
    property var chargeState: UPower.displayDevice.state
    property bool isCharging: chargeState == UPowerDeviceState.Charging
    property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1

    property bool isLow: available && (percentage <= 20 / 100)
    property bool isCritical: available && (percentage <= 5 / 100)

    property bool isLowAndNotCharging: isLow && !isCharging
    property bool isCriticalAndNotCharging: isCritical && !isCharging
    property bool isLowOrCriticalAndIsCharging: ( isLow || isCritical ) && isCharging

    property real energyRate: UPower.displayDevice.changeRate
    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property real timeToFull: UPower.displayDevice.timeToFull

    property var statusColor: getColor(percentage)

    function getColor(percentage) {
        let color = ""
        if (isCharging) return Appearance.colors.green
        if (!(isLow || isCritical)) return Appearance.colors.colPrimary
        else if (isLow) color = Appearance.colors.yellow
        else if (isCritical) color = Appearance.colors.colError
        return color


    }

    onIsLowAndNotChargingChanged: {
        if (available && isLowAndNotCharging) Quickshell.execDetached([
            "notify-send",
            "Low Battery",
            "Battery low, please charge your device",
            "-u", "critical",
            "-a", "Shell"
        ]);
    }

    onIsCriticalAndNotChargingChanged: {
        if (available && isCriticalAndNotCharging) Quickshell.execDetached([
            "notify-send",
            "Battery Critical",
            "Please charge! Laptop will soon shut down",
            "-u", "critical",
            "-a", "Shell"
        ]);
    }

    onIsLowOrCriticalAndIsChargingChanged: {
        if (available && isLowOrCriticalAndIsCharging) Quickshell.execDetached([
            "notify-send",
            "Battery Charging",
            "Battery is now charging",
            "-u", "normal",
            "-t", "3000",
            "-a", "Shell"
        ])
            
        
    }
    

}


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

    property var profile: PowerProfiles.profile

    property var profileColor: getProfileColor(profile)
    property string profileIcon: getProfileIcon(profile)
    property var currentPowerProfile: PowerProfile.toString(profile)


    function cyclePowerProfiles() {
        PowerProfiles.hasPerformanceProfile ? PowerProfiles.profile = (profile + 1) % 3 : PowerProfiles.profile = (profile + 1) % 2
    } 

    function getProfileColor(profile) {
        if (profile === 0) return Appearance.colors.green;
        if (profile === 2) return Appearance.colors.colError;
        return Appearance.colors.colPrimary
    }

    function getProfileIcon(profile) {
        if (profile === 0) return "energy_savings_leaf"
        if (profile === 2) return "bolt"
        return "do_not_disturb_on"
    }

    function getPowerProfile(profile) {
        return PowerProfile.toString(profile)
    }

    function getColor() {
        if (isCharging) return Appearance.colors.green;
        if (isCritical) return Appearance.colors.colError;
        if (isLow) return Appearance.colors.yellow;
        return Appearance.colors.colPrimary;
    }

    onIsLowAndNotChargingChanged: {
        PowerProfiles.profile = 0
        if (available && isLowAndNotCharging) Quickshell.execDetached([
            "notify-send",
            "Low Battery",
            "Battery low. Power saver enabled",
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
        PowerProfiles.profile = 1
        if (available && isLowOrCriticalAndIsCharging) Quickshell.execDetached([
            "notify-send",
            "Battery Charging",
            "Battery is now charging",
            "-u", "normal",
            "-t", "3000",
            "-a", "Shell"
        ])
    }

    onIsChargingChanged: {
        if (isCharging && PowerProfiles.profile === 0) {
            PowerProfiles.profile = 1
        }
    }
    

}


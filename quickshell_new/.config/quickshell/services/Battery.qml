pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Services.UPower

import qs.common

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property double percentage: device.percentage
    readonly property var state: device.state

    // States
    readonly property bool isCharging: state === UPowerDeviceState.Charging
    readonly property bool isFull: state === UPowerDeviceState.FullyCharged
    readonly property bool isLow: percentage <= 25.0 / 100 && !isCharging && !isFull
    readonly property bool isCritical: percentage <= 10.0 / 100 && !isCharging && !isFull

    readonly property real energyRate: device.changeRate
    readonly property real timeToEmpty: device.timeToEmpty
    readonly property real timeToFull: device.timeToFull

    readonly property var statusColor: {
        if (isCharging)
            return Colors?.md3.green;
        if (isCritical)
            return Colors?.md3.error;
        if (isLow)
            return Colors?.md3.yellow;
        return Colors?.md3.primary;
    }

    readonly property var profile: PowerProfiles.profile
    readonly property string currentProfile: PowerProfile.toString(profile)

    readonly property var allDevices: UPower.devices

    property var peripheralDevices: {
        let periphs = [];
        for (let i = 0; i < allDevices.length; i++) {
            let d = allDevices[i];
            if (d && d.type !== UPowerDeviceType.Battery && d.type !== UPowerDeviceType.LinePower && d.type !== UPowerDeviceType.Unknown) {
                periphs.push(d);
            }
        }
        return periphs;
    }
}

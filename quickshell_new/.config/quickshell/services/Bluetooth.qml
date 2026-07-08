pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick

import qs.common
import qs.common.functions

Singleton {
    id: root

    readonly property bool available: Bluetooth.adapters.values.length > 0
    readonly property bool enabled: Bluetooth.defaultAdapter?.enabled ?? false
    readonly property BluetoothDevice firstActiveDevice: Bluetooth.defaultAdapter?.devices.values.find(device => device.connected) ?? null
    readonly property int activeDeviceCount: Bluetooth.defaultAdapter?.devices.values.filter(device => device.connected).length ?? 0
    readonly property bool connected: Bluetooth.devices.values.some(d => d.connected)
    readonly property bool searching: Bluetooth.defaultAdapter?.discovering ?? false

    readonly property var symbol: {
        if (!enabled)
            return "bluetooth_disabled";
        if (searching)
            return "bluetooth_searching";
        if (connected)
            return "bluetooth_connected";
        if (!connected)
            return "bluetooth";
    }

    readonly property string color: {
        if (!enabled)
            return ColorUtils.transparentize(Colors.md3.on_surface, 0.5);
        else
            return Colors.md3.on_surface;
    }

    function toggleBluetooth() {
        if (Bluetooth.defaultAdapter) {
            Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled;
        }
    }

    function sortFunction(a, b) {
        // Ones with meaningful names before MAC addresses
        const macRegex = /^([0-9A-Fa-f]{2}-){5}[0-9A-Fa-f]{2}$/;
        const aIsMac = macRegex.test(a.name);
        const bIsMac = macRegex.test(b.name);
        if (aIsMac !== bIsMac)
            return aIsMac ? 1 : -1;

        // Alphabetical by name
        return a.name.localeCompare(b.name);
    }
    property list<var> connectedDevices: Bluetooth.devices.values.filter(d => d.connected).sort(sortFunction)
    property list<var> pairedButNotConnectedDevices: Bluetooth.devices.values.filter(d => d.paired && !d.connected).sort(sortFunction)
    property list<var> unpairedDevices: Bluetooth.devices.values.filter(d => !d.paired && !d.connected).sort(sortFunction)
    property list<var> friendlyDeviceList: [...connectedDevices, ...pairedButNotConnectedDevices, ...unpairedDevices]
}

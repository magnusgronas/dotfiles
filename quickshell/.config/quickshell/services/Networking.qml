pragma Singleton

import Quickshell
import Quickshell.Networking

Singleton {
    readonly property WifiDevice adapter: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    readonly property WiredDevice eth: Networking.devices.values.find(d => d.type === DeviceType.Wired)

    readonly property NetworkDevice activeDevice: Networking.devices.values.find(d => d.connected)

    readonly property Network activeNetwork: {
        if (activeDevice && activeDevice.networks) {
            return activeDevice.networks.values.find(n => n.connected || n.stateChanging) || null;
        }
        return null;
    }

    readonly property var availableNetworks: activeDevice?.networks?.values.map(a => a.name) ?? []

    readonly property bool isWifiEnabled: Networking.wifiEnabled
    readonly property bool isConnected: activeDevice !== null && activeNetwork !== null && activeNetwork.connected

    readonly property string currentNetworkName: {
        if (!isWifiEnabled)
            return "Wi-Fi Disabled";

        if (activeNetwork && activeNetwork.stateChanging) {
            return "Connecting...";
        }

        if (activeDevice && activeDevice.type === DeviceType.Wired) {
            return "Ethernet";
        }

        if (activeNetwork && activeNetwork.connected) {
            return activeNetwork.name;
        }

        return "Disconnected";
    }

    readonly property string icon: {
        if (!isWifiEnabled)
            return "wifi_off";
        if (!isConnected)
            return "signal_wifi_off";

        if (activeDevice && activeDevice.type === DeviceType.Wired) {
            return "lan";
        }

        if (activeDevice && activeDevice.type === DeviceType.Wifi && activeNetwork) {
            let strength = activeNetwork.signalStrength;

            if (strength > 0.80)
                return "network_wifi";
            if (strength > 0.55)
                return "network_wifi_3_bar";
            if (strength > 0.25)
                return "network_wifi_2_bar";
            return "network_wifi_1_bar";
        }

        return "wifi";
    }

    function toggleWifi() {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }

    function startScanning() {
        if (adapter) {
            adapter.scannerEnabled = true;
        }
    }

    function stopScanning() {
        if (adapter) {
            adapter.scannerEnabled = false;
        }
    }
}

pragma Singleton

import Quickshell
import Quickshell.Networking

import qs.common
import qs.common.functions

Singleton {
    property var devices: Networking.devices.values

    readonly property var adapter: devices.find(d => d.type === DeviceType.Wifi)
    readonly property var eth: devices.find(d => d.type === DeviceType.Wired)

    readonly property var activeDevice: devices.find(d => d.connected)

    readonly property Network activeNetwork: {
        if (activeDevice && activeDevice.networks) {
            return activeDevice.networks.values.find(n => n.connected || n.stateChanging) || null;
        }
        return null;
    }

    readonly property var availableNetworks: activeDevice?.networks?.values.map(a => a.name) ?? []

    readonly property bool isWifiEnabled: Networking.wifiEnabled
    readonly property bool isConnected: activeDevice !== null && activeNetwork !== null && activeNetwork.connected
    readonly property bool isWifiActive: isWifiEnabled && isConnected && activeDevice?.type === DeviceType.Wifi

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

    readonly property string color: {
        if (!isWifiEnabled)
            return Colors.md3.error;
        if (!isConnected)
            return ColorUtils.transparentize(Colors.md3.on_surface, 0.5);
        return Colors.md3.on_surface;
    }

    readonly property string icon: {
        if (!isWifiEnabled)
            return "wifi_off";
        if (!isConnected)
            return "wifi_off";
        if (activeNetwork && activeNetwork.stateChanging)
            return "android_wifi_3_bar_question";

        if (activeDevice && activeDevice.type === DeviceType.Wired)
            return "lan";

        if (activeDevice && activeDevice.type === DeviceType.Wifi && activeNetwork) {
            let strength = activeNetwork.signalStrength;

            if (strength > 0.66)
                return "wifi";
            if (strength > 0.33)
                return "wifi_2_bar";
            if (strength > 0.25)
                return "wifi_1_bar";
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

    onIsConnectedChanged: {
        console.log("Wifi chagned");
        if (activeNetwork) {
            Quickshell.execDetached(["notify-send", "Network connected", `Connected to ${activeNetwork.name}`, "-u", "normal", "-t", "3000", "-i", "network-wireless", "-a", "NetworkService"]);
        }
    }
}

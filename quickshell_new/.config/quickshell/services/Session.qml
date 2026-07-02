pragma Singleton

import Quickshell

Singleton {
    id: root

    function lock() {
        Quickshell.execDetached(["loginctl", "lock-session"]);
    }

    function suspend() {
        Quickshell.execDetached(["bash", "-c", "systemctl suspend"])
    }

    function logout() {
        Quickshell.execDetached(["pkill", "-i", "Hyprland"]);
    }

    function launchTaskManager() {
        Quickshell.execDetached(["ghostty", "-e", "btop"]);
    }

    function hibernate() {
        Quickshell.execDetached(["bash", "-c", "systemctl hybrid-sleep"]);
    }

    function shutdown() {
        Quickshell.execDetached(["bash", "-c", "systemctl poweroff"]);
    }

    function reboot() {
        Quickshell.execDetached(["bash", "-c", "systemctl reboot"]);
    }

    function rebootToFirmware() {
        Quickshell.execDetached(["bash", "-c", "systemctl reboot --firmware-setup"]);
    }
}

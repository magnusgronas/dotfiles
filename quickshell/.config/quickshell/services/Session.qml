pragma Singleton

import Quickshell

import qs.services

Singleton {
    id: root

    function closeAllWindows() {
        HyprlandData.windowList.map(w => w.pid).forEach(pid => {
            Quickshell.execDetached(["kill", pid]);
        });
    }

    function lock() {
        Quickshell.execDetached(["loginctl", "lock-session"]);
    }

    function suspend() {
        Quickshell.execDetached(["bash", "-c", "systemctl suspend"])
    }

    function logout() {
        closeAllWindows();
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
        closeAllWindows();
        Quickshell.execDetached(["bash", "-c", "systemctl reboot"]);
    }

    function rebootToFirmware() {
        closeAllWindows();
        Quickshell.execDetached(["bash", "-c", "systemctl reboot --firmware-setup"]);
    }
}


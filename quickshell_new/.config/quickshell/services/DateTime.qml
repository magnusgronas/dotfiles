pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var clock: SystemClock {}
    property var uptime: ""
    property string time: Qt.locale().toString(clock.date, "hh:mm")
    property string hour: Qt.locale().toString(clock.date, "hh")
    property string shortDate: Qt.locale().toString(clock.date, "dd.MM")
    property string date: Qt.locale().toString(clock.date, "dddd, dd.MM")

    Process {
        id: uptimeProc
        command: ["cat", "/proc/uptime"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.uptime = root.cleanUptime(text)
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
            uptimeProc.running = true;
        }
    }

    function cleanUptime(seconds) {
        const words = seconds.split(" ");
        const hours = Math.floor(words[0] / 3600);
        const remainingSeconds = words[0] % 3600;
        const minutes = Math.floor(remainingSeconds / 60);
        return minutes === 0 ? `${hours}h` : `${hours}h ${minutes}m`;
    }
}

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {

    id: root
    property string time: Qt.locale().toString(clock.date, "hh:mm")
    property string shortDate: Qt.locale().toString(clock.date, "dd.MM")
    property string date: Qt.locale().toString(clock.date, "dddd, dd.MM")
    property var uptime: ""

    property var clock: SystemClock {
        id: clock
    }

    Process {
        command: ["cat", "/proc/uptime"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.uptime = root.cleanUptime(text)
        }
    }

    function cleanUptime(seconds) {
        const words = seconds.split(" ");
        const hours = Math.floor(words[0] / 3600);
        const remainingSeconds = words[0] % 3600;
        const minutes = Math.floor(remainingSeconds / 60)
        return minutes === 0 ? `${hours}h` : `${hours}h ${minutes}m`
    }

}

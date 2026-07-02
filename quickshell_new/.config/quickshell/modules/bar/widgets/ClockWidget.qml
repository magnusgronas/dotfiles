pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.common
import qs.common.widgets
import qs.services

/**
* Clock widget with hidden Pomodoro timer
*/
Item {
    id: root

    width: layout.implicitWidth
    height: Appearance.sizes.barHeight

    readonly property bool isFocusMode: Pomodoro.currentPhase !== Pomodoro.Phase.Idle

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                Pomodoro.toggle();
            } else if (mouse.button === Qt.RightButton) {
                Pomodoro.stop();
            }
        }
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        StyledText {
            text: root.isFocusMode ? Pomodoro.displayTime : DateTime.time
            font.pixelSize: Appearance.font.size.huge
            color: root.isFocusMode ? Pomodoro.phaseColor : Colors.md3.on_surface

            readonly property real currentWeight: 100 + (Math.sin((DateTime.hour / 24) * Math.PI) * 400)
            font.weight: currentWeight

            axes: ({
                    "wdth": 110,
                    "ROND": 100
                })

            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }

        MaterialSymbol {
            symbol: {
                if (!root.isFocusMode)
                    return "󰧞";
                return Pomodoro.isRunning ? "pause" : "play_arrow";
            }
            color: root.isFocusMode ? Pomodoro.phaseColor : Colors.md3.on_surface
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }
        }

        StyledText {
            text: {
                if (!root.isFocusMode)
                    return DateTime.date;
                if (Pomodoro.currentPhase === Pomodoro.Phase.Work)
                    return "Focus " + (Pomodoro.sessionsCompleted + 1) + " / 4";
                if (Pomodoro.currentPhase === Pomodoro.Phase.ShortBreak)
                    return "Short Break";
                return "Long Break";
            }
            opacity: (!root.isFocusMode || Pomodoro.isRunning) ? 1.0 : 0.5
            font.pixelSize: Appearance.font.size.normal

            color: Colors.md3.on_surface
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }
    }
}

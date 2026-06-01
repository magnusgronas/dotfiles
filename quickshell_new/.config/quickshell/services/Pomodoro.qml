pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

import qs.common

Singleton {
    id: root

    enum Phase {
        Idle,
        Work,
        ShortBreak,
        LongBreak
    }

    property int workDuration: 25
    property int shortBreakDuration: 5
    property int longBreakDuration: 15
    property int sessionsBeforeLongBreak: 4

    property int currentPhase: Pomodoro.Phase.Idle
    property int sessionsCompleted: 0
    property int secondsRemaining: workDuration * 60
    property bool isRunning: timer.running

    readonly property string displayTime: {
        let m = Math.floor(secondsRemaining / 60);
        let s = secondsRemaining % 60;
        return (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s;
    }

    readonly property color phaseColor: {
        if (currentPhase === Pomodoro.Phase.Idle)
            return Colors?.md3.on_surface;
        if (currentPhase === Pomodoro.Phase.Work)
            return Colors?.md3.error;
        return Colors?.md3.green;
    }

    readonly property real progress: {
        if (currentPhase === Pomodoro.Phase.Idle)
            return 0.0;

        let totalSeconds = (currentPhase === Pomodoro.Phase.Work ? workDuration : (currentPhase === Pomodoro.Phase.ShortBreak ? shortBreakDuration : longBreakDuration)) * 60;

        return secondsRemaining / totalSeconds;
    }

    property QtObject timer: Timer {
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            if (root.secondsRemaining > 0) {
                root.secondsRemaining--;
            } else {
                root.advancePhase();
            }
        }
    }

    function toggle() {
        if (currentPhase === Pomodoro.Phase.Idle) {
            startWork();
        } else {
            timer.running = !timer.running;
        }
    }

    function stop() {
        timer.running = false;
        currentPhase = Pomodoro.Phase.Idle;
        secondsRemaining = workDuration * 60;
        sessionsCompleted = 0;
    }

    function startWork() {
        currentPhase = Pomodoro.Phase.Work;
        secondsRemaining = workDuration * 60;
        timer.running = true;
    }

    function advancePhase() {
        timer.running = false;
        if (currentPhase === Pomodoro.Phase.Work) {
            sessionsCompleted++;
            if (sessionsCompleted >= sessionsBeforeLongBreak) {
                currentPhase = Pomodoro.Phase.LongBreak;
                secondsRemaining = longBreakDuration * 60;
                sessionsCompleted = 0;
            } else {
                currentPhase = Pomodoro.Phase.ShortBreak;
                secondsRemaining = shortBreakDuration * 60;
            }
        } else {
            startWork();
        }
        timer.running = true;
    }
}

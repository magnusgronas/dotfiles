pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.Pipewire

QtObject {
    id: root

    readonly property PwNode defaultSink: Pipewire.defaultAudioSink
    readonly property PwNodeAudio audio: defaultSink ? defaultSink.audio : null

    readonly property real volume: audio ? audio.volume : 0.0
    readonly property bool isMuted: audio ? audio.muted : false

    readonly property int volumePercent: Math.round(volume * 100)

    function setVolume(newVolume) {
        if (audio) {
            audio.volume = Math.max(0.0, Math.min(1.0, newVolume));
        }
    }

    function toggleMute() {
        if (audio) {
            audio.muted = !audio.muted;
        }
    }
}

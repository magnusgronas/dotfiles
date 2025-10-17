pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    // Sink and Source
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool muted: sink?.audio.muted
    readonly property real volume: sink?.audio.volume
    readonly property string volumeText: {
        (muted) ? "󰖁" : (volume > 0.66) ? "󰕾" : (volume > 0.33) ? "󰖀" : (volume > 0) ? "󰕿" : "󰖁"
    }

    function volumeIcon() {
        let iconName = "";
        if (muted) {
            return Quickshell.iconPath("audio-volume-muted-symbolic");
        }

        if (volume === 0) {
            iconName = "audio-volume-off-symbolic";
        } else if (volume < 0.33) {
            iconName = "audio-volume-low-symbolic";
        } else if (volume < 0.66) {
            iconName = "audio-volume-medium-symbolic";
        } else {
            iconName = "audio-volume-high-symbolic";
        }

        return Quickshell.iconPath(iconName);
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}


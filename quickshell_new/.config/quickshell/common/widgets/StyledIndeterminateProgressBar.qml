pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import qs.common

ProgressBar {
    id: root

    property color highlightColor: Colors.md3.primary
    property color barBackground: Colors.md3.surface_variant

    property bool wavy: false
    property real barWidth: 120
    property real lineThickness: 4
    property real amplitudeMultiplier: 0.5
    property real frequency: 6

    indeterminate: true

    Material.accent: root.highlightColor

    background: Rectangle {
        implicitWidth: root.barWidth
        implicitHeight: root.lineThickness
        color: root.barBackground
        radius: height / 2
    }
}

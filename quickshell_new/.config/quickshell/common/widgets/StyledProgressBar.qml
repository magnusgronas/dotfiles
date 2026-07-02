pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

import qs.common

ProgressBar {
    id: root

    property color highlightColor: Colors.md3.primary
    property color barBackground: Colors.md3.surface_variant

    property bool wavy: false
    property bool isAnimated: false

    property real barWidth: 120
    property real lineThickness: 4
    property real barGap: 6

    property real amplitudeMultiplier: 0.5
    property real frequency: 6

    background: Item {
        implicitWidth: root.barWidth
        implicitHeight: (root.lineThickness * root.amplitudeMultiplier * 2) + root.lineThickness
    }

    contentItem: Item {
        id: contentItem
        anchors.fill: parent

        Loader {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * root.visualPosition
            height: parent.height
            active: root.wavy

            sourceComponent: WavyLine {
                color: root.highlightColor
                lineWidth: root.lineThickness
                amplitudeMultiplier: root.amplitudeMultiplier
                frequency: root.frequency
                isAnimated: root.isAnimated
                fullLength: contentItem.width
            }
        }

        Loader {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * root.visualPosition
            height: root.lineThickness
            active: !root.wavy

            sourceComponent: Rectangle {
                color: root.highlightColor
                radius: height / 2
            }
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: Math.max(0, ((1 - root.visualPosition) * parent.width) - root.barGap)
            height: root.lineThickness
            radius: height / 2
            color: root.barBackground
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: root.lineThickness
            height: root.lineThickness
            radius: height / 2
            color: root.highlightColor
        }
    }
}

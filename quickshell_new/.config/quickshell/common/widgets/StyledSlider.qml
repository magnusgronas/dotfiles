pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

import qs.common
import qs.common.widgets

Slider {
    id: root

    property color color: Colors.md3.primary
    property color barBackground: Colors.md3.surface_variant

    property bool wavy: false
    property bool isAnimated: false

    property real barWidth: 120
    property real lineWidth: 4
    property real barGap: 6

    property real amplitudeMultiplier: 0.5
    property real frequency: 6

    property bool shouldShowHandle: false
    property real handleWidth: 3
    property real handleHeight: 22
    property real effectiveDraggingWidth: width - leftPadding - rightPadding

    property bool usePercentTooltip: false
    property string tooltipContent: usePercentTooltip ? `${Math.round(((value - from) / (to - from)) * 100)}%` : `${Math.round(value)}`

    background: Item {
        implicitWidth: root.barWidth
        implicitHeight: (root.lineWidth * root.amplitudeMultiplier * 2) + root.lineWidth
    }

    handle: Rectangle {
        id: handle

        implicitWidth: root.handleWidth
        implicitHeight: root.handleHeight
        x: root.leftPadding + (root.visualPosition * root.effectiveDraggingWidth) - (root.handleWidth / 2)
        anchors.verticalCenter: parent.verticalCenter
        radius: implicitHeight / 2
        color: Colors.md3.inverse_surface

        Behavior on implicitWidth {
            animation: Appearance?.animation.elementMoveFast.numberAnimation.createObject(this)
        }

        StyledTooltip {
            extraVisibleCondition: root.pressed
            text: root.tooltipContent
            font {
                family: Appearance.font.family.numbers
                variableAxes: Appearance.font.variableAxes.numbers
            }
        }
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
                color: root.color
                lineWidth: root.lineWidth
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
            height: root.lineWidth
            active: !root.wavy

            sourceComponent: Rectangle {
                color: root.color
                radius: height / 2
            }
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: Math.max(0, ((1 - root.visualPosition) * parent.width) - root.barGap)
            height: root.lineWidth
            radius: height / 2
            color: root.barBackground
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: root.lineWidth
            height: root.lineWidth
            radius: height / 2
            color: root.color
        }
    }
}

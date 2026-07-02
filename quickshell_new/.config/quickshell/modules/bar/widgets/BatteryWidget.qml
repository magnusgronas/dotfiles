import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import qs.common
import qs.common.functions
import qs.common.widgets
import qs.services

Item {
    id: root
    property real valueBarWidth: 32
    property real valueBarHeight: 17
    property real fontSize: Appearance.font.size.small
    property color highlightColor: Battery.statusColor
    property color trackColor: ColorUtils.transparentize(Colors.md3.on_surface, 0.6)
    property alias radius: contentItem.radius
    property var value: Battery.percentage
    property string text: Math.round(value * 100)

    property color textColor: ColorUtils.transparentize(Colors.md3.surface, 0.4)

    implicitWidth: progressRoot.implicitWidth
    implicitHeight: progressRoot.implicitHeight

    ProgressBar {
        id: progressRoot
        property real valueBarWidth: root.valueBarWidth
        property real valueBarHeight: root.valueBarHeight
        property real fontSize: root.fontSize
        property alias radius: root.radius

        anchors.centerIn: parent
        value: root.value

        background: Item {
            implicitHeight: progressRoot.valueBarHeight
            implicitWidth: progressRoot.valueBarWidth
        }

        contentItem: Rectangle {
            id: contentItem
            anchors.fill: progressRoot
            radius: height / 4
            color: root.trackColor
            visible: false

            Rectangle {
                id: progressFill
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: undefined
                }
                width: parent.width * progressRoot.visualPosition
                height: parent.height

                color: root.highlightColor
            }
            Behavior on color {
                animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
            }
        }

        OpacityMask {
            id: roundingMask
            anchors.fill: parent
            source: contentItem
            maskSource: Rectangle {
                width: contentItem.width
                height: contentItem.height
                radius: contentItem.radius
            }
        }

        StyledText {
            anchors.left: parent.left
            anchors.leftMargin: progressRoot.implicitWidth / 2 - this.implicitWidth / 2
            font.pixelSize: Appearance.font.size.small
            font.weight: Font.Bold
            axes: Appearance.font.variableAxes.round
            renderType: Text.QtRendering
            text: root.text
            color: root.textColor
        }
    }

    // cap
    Rectangle {
        implicitHeight: progressRoot.implicitHeight / 2.5
        anchors.left: progressRoot.right
        anchors.leftMargin: 1

        bottomRightRadius: height / 4
        topRightRadius: height / 4

        implicitWidth: 2
        anchors.verticalCenter: progressRoot.verticalCenter

        color: progressRoot.value == 1.0 ? root.highlightColor : root.trackColor
    }

    // Charge state
    MaterialSymbol {
        anchors.leftMargin: -8
        anchors.left: progressRoot.right
        anchors.top: progressRoot.top
        anchors.topMargin: -2
        symbol: "electric_bolt"
        style: Text.Outline
        color: Colors.md3.inverse_surface
        opacity: Battery.isCharging ? 1 : 0
        font.pixelSize: 16

        Behavior on opacity {
            animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
        }
    }

    // power-saver state
    MaterialSymbol {
        anchors.leftMargin: -10
        anchors.left: progressRoot.right
        anchors.top: progressRoot.top
        anchors.topMargin: -5
        symbol: "add"
        font.pixelSize: 24
        style: Text.Outline
        color: Colors.md3.inverse_surface
        opacity: !Battery.isCharging && Battery.isPowerSaver ? 1 : 0

        Behavior on opacity {
            animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
        }
    }

    // performance state
    MaterialSymbol {
        anchors.leftMargin: -8
        anchors.left: progressRoot.right
        anchors.top: progressRoot.top
        anchors.topMargin: -5
        symbol: "rocket"
        font.pixelSize: 24
        style: Text.Outline
        color: Colors.md3.inverse_surface
        opacity: !Battery.isCharging && Battery.isPerformance ? 1 : 0

        Behavior on opacity {
            animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
        }
    }
}

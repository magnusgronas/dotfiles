import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import qs.common
import qs.common.functions
import qs.common.widgets
import qs.services

Item {
    id: root
    property real valueBarWidth: 34
    property real valueBarHeight: 18
    property real fontSize: Appearance.font.size.small
    property color highlightColor: Battery.statusColor
    property color trackColor: ColorUtils.transparentize(highlightColor, 0.5)
    property alias radius: contentItem.radius
    property var value: Battery.percentage
    property string text: Math.round(value * 100)

    implicitWidth: progressRoot.implicitWidth
    implicitHeight: progressRoot.implicitHeight

    ProgressBar {
        id: progressRoot
        property real valueBarWidth: root.valueBarWidth
        property real valueBarHeight: root.valueBarHeight
        property real fontSize: root.fontSize
        property alias radius: root.radius
        default property Item textMask: Item {
            width: progressRoot.valueBarWidth
            height: progressRoot.valueBarHeight
            StyledText {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Appearance.font.size.small
                font.weight: Font.Bold
                axes: Appearance.font.variableAxes.round
                renderType: Text.QtRendering
                text: root.text
            }
        }

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
        }

        OpacityMask {
            id: roundingMask
            visible: false
            anchors.fill: parent
            source: contentItem
            maskSource: Rectangle {
                width: contentItem.width
                height: contentItem.height
                radius: contentItem.radius
            }
        }

        OpacityMask {
            anchors.fill: parent
            source: roundingMask
            invert: true
            maskSource: progressRoot.textMask
        }
    }

    Rectangle {
        id: cap
        implicitHeight: progressRoot.implicitHeight / 2.5
        anchors.left: progressRoot.right
        anchors.leftMargin: 1

        bottomRightRadius: height / 4
        topRightRadius: height / 4

        implicitWidth: 2
        anchors.verticalCenter: progressRoot.verticalCenter

        color: progressRoot.value == 1.0 ? root.highlightColor : root.trackColor
    }

    MaterialSymbol {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: cap.horizontalCenter
        symbol: "bolt"
        style: Text.Outline
        color: Colors.md3.inverse_surface
        visible: Battery.isCharging
        font.pixelSize: 18
    }
}

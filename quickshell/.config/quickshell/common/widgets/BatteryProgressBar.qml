import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

/**
 * Yoinked and modified from end-4's ClippedProgressbar
 */

Item {
    id: root
    property real valueBarWidth: 30
    property real valueBarHeight: 18
    property real fontSize: 13
    property color highlightColor: "#685496"
    property color trackColor: Qt.alpha(highlightColor, 0.5) ?? "#000000"
    property alias radius: contentItem.radius
    property var value
    property string text: Math.round(value * 100)

    implicitWidth: progressRoot.implicitWidth
    implicitHeight: progressRoot.implicitHeight


    ProgressBar {
        id: progressRoot
        property real valueBarWidth: root.valueBarWidth
        property real valueBarHeight: root.valueBarHeight
        property real fontSize: 13
        property alias radius: root.radius 
        default property Item textMask: Item {
            width: progressRoot.valueBarWidth
            height: progressRoot.valueBarHeight
            Text {
                anchors.centerIn: parent
                font: progressRoot.font
                // text: root.text
            }
        }

        anchors.centerIn: parent

        value: root.value

        // root.text: Math.round(value * 100)
        font {
            pixelSize: progressRoot.fontSize
            weight: root.text.length > 2 ? Font.Bold : Font.DemiBold
        }

        background: Item {
            implicitHeight: progressRoot.valueBarHeight
            implicitWidth: progressRoot.valueBarWidth
        }

        contentItem: Rectangle {
            id: contentItem
            anchors.fill: progressRoot
            radius: parent.height / 4
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

                radius: progressRoot.height / 4
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
    // Battery tip
    Rectangle {
        implicitHeight: progressRoot.implicitHeight / 2
        anchors.left: progressRoot.right
        anchors.leftMargin: 1

        bottomRightRadius: height / 4
        topRightRadius: height / 4

        implicitWidth: 2
        anchors.verticalCenter: progressRoot.verticalCenter

        color: progressRoot.value == 1.0 ? root.highlightColor : root.trackColor
    }
}

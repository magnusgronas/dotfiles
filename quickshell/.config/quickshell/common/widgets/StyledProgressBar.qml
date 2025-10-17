pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls


ProgressBar {
    id: root

    property color highlightColor: "#b3c5ff"
    property color barBackground: "#414659"

    property real barWidth: 120
    property real barHeight: 4
    property real barGap: 2

    background: Item {
        implicitWidth: root.barWidth
        implicitHeight: root.barHeight
    }

    contentItem: Item {
        id: contentItem
        anchors.fill: parent

        // Left side
        Loader {
            active: true
            sourceComponent: Rectangle {
                anchors.left: parent.left
                width: contentItem.width * root.visualPosition
                height: contentItem.height
                radius: height / 2
                color: root.highlightColor
            }
        }
    }

    // Right side
    Rectangle {
        anchors.right: parent.right
        width: (1 - root.visualPosition) * parent.width - root.barGap
        height: parent.height
        radius: height / 2
        color: root.barBackground
    }

    // Dot
    Rectangle {
        anchors.right: parent.right
        width: root.barHeight
        height: root.barHeight
        radius: height / 2
        color: root.highlightColor
    }
}

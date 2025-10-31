import QtQuick
import QtQuick.Layouts

import qs.common

Item {
    id: root
    property real padding: 5
    default property alias items: rowLayout.children
    implicitWidth: rowLayout.implicitWidth + padding * 2
    implicitHeight: 50

    Rectangle {
        id: background
        anchors {
            fill: parent
            topMargin: 4
            bottomMargin: 4
        }
        color: "#1e1f25"
        radius: height / 3
    }

    RowLayout {
        id: rowLayout

        spacing: 12
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: root.padding
        }
    }
}

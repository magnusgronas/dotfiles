import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.common.widgets
import qs.services

// TODO: MAKE PART OF GLOBAL CONFIG
Item {
    id: root
    property bool showDate: true

    implicitWidth: rowLayout.implicitWidth
    implicitHeight: 50

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 4

        StyledText {
            font.pixelSize: 24
            color: "#e3e2e9"
            text: DateTime.time
        }
        StyledText {
            font.pixelSize: 16
            Layout.topMargin: 4
            color: "#e3e2e9"
            text: "󰧞"
        }
        StyledText {
            Layout.alignment: Qt.AlignBottom
            font.pixelSize: 20
            color: "#e3e2e9"
            text: DateTime.date
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton

        ClockWidgetPopup {
            hoverTarget: mouseArea
        }
    }
}

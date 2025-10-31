import QtQuick
import QtQuick.Controls

import qs.common.widgets

Button {
    id: root
    property string symbol: ""
    property int buttonSize: 120
    property int iconSize: 60

    

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton
    }

    background: Rectangle {
        id: background
        radius: 999
        implicitHeight: root.buttonSize
        implicitWidth: root.buttonSize
        color: focus ? "#FFFFFF" : "#292a2f"
    }

    contentItem: MaterialSymbol {
        text: root.symbol
        horizontalAlignment: Qt.AlignHCenter
        iconSize: root.iconSize
    }
}

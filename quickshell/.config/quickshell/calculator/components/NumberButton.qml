import QtQuick
import QtQuick.Controls

import qs.common.widgets

Button {
    id: root
    property string buttonText: ""
    property int buttonSize: 120
    
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
        color: focus ? "" : "#292a2f"
    }

    contentItem: StyledText {
        text: root.buttonText
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 50
    }
}

pragma ComponentBehavior: Bound

import QtQuick

import qs.common
import qs.common.widgets
import qs.common.functions

Item {
    id: root

    // ==========================================
    // 1. PUBLIC API (What you set from the outside)
    // ==========================================
    property string symbol: ""
    property string text: ""
    property bool isNerdFont: false
    signal clicked()


    // ==========================================
    // 2. SIZING (Self-calculating dimensions)
    // ==========================================
    // Automatically wraps the text with 16px padding on each side
    implicitWidth: contentContainer.implicitWidth + 32
    implicitHeight: 40

    // ==========================================
    // 3. INTERNAL STATE (Tracking user input)
    // ==========================================
    property bool isHovered: mouseArea.containsMouse
    property bool isPressed: mouseArea.pressed || keyboardDown
    property bool keyboardDown: false


    // ==========================================
    // 4. BACKGROUND (The visual container)
    // ==========================================
    Rectangle {
        id: background
        anchors.fill: parent

        radius: Appearance?.rounding?.small ?? 8

        // Example: Outline by default, slightly tinted on hover, solid on press
        color: root.isPressed ? Colors.md3.primary
             : root.isHovered ? ColorUtils.transparentize(Colors.md3.on_surface, 0.92)
             : "transparent"
             

        // Smoothly transition background color changes
        Behavior on color { ColorAnimation { duration: 150 } }
    }

    // ==========================================
    // 5. CONTENT (Text, Icons, Layout)
    // ==========================================
    Row {
        id: contentContainer
        anchors.centerIn: parent
        spacing: 8

        StyledText {
            text: root.text
            font.pixelSize: Appearance?.font?.size?.normal ?? 14
            
            // Example: Swap to contrast color when the background goes solid
            color: root.isPressed ? Colors.md3.on_primary : Colors.md3.on_surface
        }
    }

    // ==========================================
    // 6. INTERACTION (Mouse & Touch)
    // ==========================================
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

    // ==========================================
    // 7. ACCESSIBILITY (Keyboard Navigation)
    // ==========================================
    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
            root.keyboardDown = true;
            event.accepted = true;
        }
    }
    
    Keys.onReleased: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter || event.key === Qt.Key_Space) {
            root.keyboardDown = false;
            root.clicked();
            event.accepted = true;
        }
    }
}

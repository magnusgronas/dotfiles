pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

import qs.common
import qs.common.widgets
import qs.common.functions

Switch {
    id: control

    property real scale: 1.0

    implicitWidth: 52 * control.scale
    implicitHeight: 32 * control.scale

    property bool showIcon: true
    property string activeIcon: "check"

    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }

    property bool isHeld: false
    onDownChanged: {
        if (down)
            holdTimer.restart();
        else {
            holdTimer.stop();
            isHeld = false;
        }
    }
    Timer {
        id: holdTimer
        interval: 150
        onTriggered: control.isHeld = true
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        radius: Appearance.rounding.full

        color: control.checked ? Colors.md3.primary : Colors.md3.surface_container_highest
        border.color: control.checked ? Colors.md3.primary : Colors.md3.outline
        border.width: 2 * control.scale

        Behavior on color {
            animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
        }
        Behavior on border.color {
            animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
        }
    }

    indicator: Rectangle {
        property real targetSize: control.isHeld ? 28 : (control.checked ? 24 : 16)
        width: targetSize * control.scale
        height: targetSize * control.scale

        radius: Appearance.rounding.full
        color: control.checked ? Colors.md3.on_primary : Colors.md3.outline

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: (control.isHeld ? (control.checked ? 22 : 2) : (control.checked ? 24 : 8)) * control.scale

        Behavior on anchors.leftMargin {
            animation: Appearance.animation.elementMove.numberAnimation.createObject(this)
        }
        Behavior on width {
            animation: Appearance.animation.elementResize.numberAnimation.createObject(this)
        }
        Behavior on height {
            animation: Appearance.animation.elementResize.numberAnimation.createObject(this)
        }
        Behavior on color {
            animation: Appearance.animation.elementMoveFast.colorAnimation.createObject(this)
        }

        MaterialSymbol {
            anchors.centerIn: parent
            symbol: control.activeIcon
            iconSize: 16 * control.scale
            color: Colors.md3.primary

            opacity: (control.checked && control.showIcon) ? 1.0 : 0.0
            scale: (control.checked && control.showIcon) ? 1.0 : 0.0

            Behavior on opacity {
                animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
            }
            Behavior on scale {
                animation: Appearance.animation.elementResize.numberAnimation.createObject(this)
            }
        }
    }
}

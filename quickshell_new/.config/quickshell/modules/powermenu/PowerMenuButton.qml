import QtQuick

import qs.common.widgets
import qs.common.functions
import qs.common

RippleButton {
    id: root

    property string buttonIcon
    property bool keyboardDown: false
    property real size: Appearance.sizes.powerMenuButton

    buttonRadius: (root.focus || root.down) ? size / 2 : Appearance.rounding.verylarge

    colBackground: root.keyboardDown ? ColorUtils.transparentize(Colors.md3.primary, 0.8) : root.focus ? Colors.md3.primary : ColorUtils.transparentize(Colors.md3.surface_container, 0.6)

    colBackgroundHover: Colors.md3.primary
    colRipple: ColorUtils.transparentize(Colors.md3.surface, 0.8)

    property color colText: (root.down || root.keyboardDown || root.focus || root.hovered) ? Colors.md3.on_primary : Colors.md3.on_surface

    background.implicitWidth: size
    background.implicitHeight: size

    Behavior on buttonRadius {
        animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    }

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            keyboardDown = true;
            root.clicked();
            event.accepted = true;
        }
    }

    Keys.onReleased: event => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            keyboardDown = false;
            event.accepted = true;
        }
    }

    contentItem: MaterialSymbol {
        id: icon
        anchors.fill: parent
        color: root.colText
        horizontalAlignment: Text.AlignHCenter
        iconSize: root.size / 2
        symbol: root.buttonIcon
    }

    StyledTooltip {
        text: root.buttonText
    }
}

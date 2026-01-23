import QtQuick

import qs.common.widgets
import qs.common

RippleButton {
    id: root

    property string buttonIcon
    property string buttonText
    property bool keyboardDown: false
    property real size: Appearance.sizes.powerMenuButton

    buttonRadius: (root.focus || root.down) ? size / 2 : Appearance.rounding.verylarge
    colBackground: root.keyboardDown
        ? Appearance.colors.colSecondaryContainerActive
        : root.focus ? Appearance.colors.colPrimary
        : Appearance.colors.colSecondaryContainer
    colBackgroundHover: Appearance.colors.colPrimary
    colRipple: Appearance.colors.colPrimaryActive
    property color colText: (root.down || root.keyboardDown || root.focus || root.hovered)
        ? Appearance.m3colors.m3onPrimary : Appearance.colors.colOnLayer0

    // Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    background.implicitWidth: size
    background.implicitHeight: size

    Behavior on buttonRadius {
        animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
    }

    Keys.onPressed: (event) => {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            keyboardDown = true;
            root.clicked();
            event.accepted = true;
        }
    }

    Keys.onReleased: (event) => {
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
        text: root.buttonIcon
    }

    StyledToolTip {
        text: root.buttonText
    }
}



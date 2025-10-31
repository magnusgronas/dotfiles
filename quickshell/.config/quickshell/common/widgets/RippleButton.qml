import QtQuick
import QtQuick.Controls

import Qt5Compat.GraphicalEffects

import qs.common.functions

Button {
    id: root
    property bool toggled
    property string buttonText
    property bool pointingHandCursor: true
    property real buttonRadius: 12
    property real buttonRadiusPressed: buttonRadius
    property real buttonEffectiveRadius: root.down ? root.buttonRadiusPressed : root.buttonRadius
    property int rippleDuration: 1200
    property bool rippleEnabled: true
    property var downAction // When left clicking (down)
    property var releaseAction // When left clicking (release)
    property var altAction // When right clicking
    property var middleClickAction // When middle clicking

    property color colBackground
    property color colBackgroundHover
    property color colBackgroundToggled
    property color colBackgroundToggledHover
    property color colRipple
    property color colRippleToggled

    opacity: root.enabled ? 0.4 : 1
}

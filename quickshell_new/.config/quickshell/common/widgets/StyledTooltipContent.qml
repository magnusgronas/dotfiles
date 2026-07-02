import QtQuick

import qs.common
import qs.common.widgets

Item {
    id: root
    required property string text
    property bool shown: false
    property real horizontalPadding: 10
    property real verticalPadding: 10
    property alias font: tooltipText.font
    implicitWidth: tooltipText.implicitWidth + horizontalPadding * 2
    implicitHeight: tooltipText.implicitHeight + verticalPadding * 2

    property bool isVisible: background.implicitHeight > 0

    Rectangle {
        id: background
        anchors {
            bottom: root.bottom
            horizontalCenter: root.horizontalCenter
        }
        color: Colors.md3.inverse_surface
        radius: Appearance?.rounding.slight
        opacity: root.shown ? 1 : 0
        implicitWidth: root.shown ? (tooltipText.implicitWidth + root.horizontalPadding * 2) : 0
        implicitHeight: root.shown ? (tooltipText.implicitHeight + root.verticalPadding * 2) : 0
        clip: true

        Behavior on implicitWidth {
            animation: Appearance?.animation.elementMoveFast.numberAnimation.createObject(this)
        }
        Behavior on implicitHeight {
            animation: Appearance?.animation.elementMoveFast.numberAnimation.createObject(this)
        }
        Behavior on opacity {
            animation: Appearance?.animation.elementMoveFast.numberAnimation.createObject(this)
        }

        StyledText {
            id: tooltipText
            anchors.centerIn: parent
            text: root.text
            font.pixelSize: Appearance?.font.size.small
            font.hintingPreference: Font.PreferNoHinting
            color: Colors.md3.surface
            wrapMode: Text.Wrap
        }
    }
}

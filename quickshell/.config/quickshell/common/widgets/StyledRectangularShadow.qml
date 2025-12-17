import QtQuick
import QtQuick.Effects

import qs.common

RectangularShadow {
    required property var target
    anchors.fill: target
    radius: target.radius
    blur: 0.9 * 10
    offset: Qt.vector2d(0.0, 1.0)
    spread: 2
    color: Appearance.colors.colShadow
    cached: true
}

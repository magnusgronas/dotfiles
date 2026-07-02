import QtQuick
import QtQuick.Effects

import qs.common
import qs.common.functions

RectangularShadow {
    required property var target
    anchors.fill: target
    radius: target.radius
    topLeftRadius: target.topLeftRadius
    topRightRadius: target.topRightRadius
    bottomLeftRadius: target.bottomLeftRadius
    bottomRightRadius: target.bottomRightRadius
    blur: 0.9 * 10
    offset: Qt.vector2d(0.0, 1.0)
    spread: 2
    color: ColorUtils.transparentize(Colors.md3.shadow, 0.3)
}

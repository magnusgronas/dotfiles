import QtQuick
import QtQuick.Effects

RectangularShadow {
    required property var target
    anchors.fill: target
    radius: target.radius
    blur: 0.9 * 10
    offset: Qt.vector2d(0.0, 1.0)
    spread: 2
    color: Qt.alpha("#000000", 0.4)
    cached: true
}

import QtQuick
import QtQuick.Shapes

import qs.common

Shape {
    id: root

    enum Side {
        Left,
        Right
    }

    property int radius: Appearance.sizes.roundCornerSize
    property color color: "#FF0000" // Appearance.colors.colLayer0
    property int side: RoundCorner.Side.Left

    width: radius
    height: radius

    layer.enabled: true
    layer.smooth: true
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
        fillColor: root.side === RoundCorner.Side.Left ? root.color : "transparent"
        strokeColor: "transparent"
        strokeWidth: 1
        startX: 0
        startY: 0
        PathLine {
            x: root.radius
            y: 0
        }
        PathArc {
            x: 0
            y: root.radius
            radiusX: root.radius
            radiusY: root.radius
            direction: PathArc.Counterclockwise
        }
        PathLine {
            x: 0
            y: 0
        }
    }
    ShapePath {
        fillColor: root.side === RoundCorner.Side.Right ? root.color : "transparent"
        strokeColor: "transparent"
        strokeWidth: 1
        startX: 0
        startY: 0
        PathLine {
            x: root.radius
            y: 0
        }
        PathLine {
            x: root.radius
            y: root.radius
        }
        PathArc {
            x: 0
            y: 0
            radiusX: root.radius
            radiusY: root.radius
            direction: PathArc.Counterclockwise
        }
    }
}

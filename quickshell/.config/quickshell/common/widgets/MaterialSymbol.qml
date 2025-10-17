import QtQuick

StyledText {
    id: root
    property real iconSize: 16
    property real fill: 0
    property real truncatedFill: Math.round(fill * 100) / 100
    renderType: fill !== 0 ? Text.CurveRendering : Text.NativeRendering
    font {
        hintingPreference: Font.PreferFullHinting
        family: "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * fill
        variableAxes: {
            "FILL": truncatedFill,
            "opsz": iconSize
        }
    }
}

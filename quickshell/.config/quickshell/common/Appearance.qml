pragma Singleton

import Quickshell

import QtQuick

import qs.common.functions

// NOTE: THIS FILE IS A MATUGEN TEMPLATE TO EDIT THIS FILE, EDIT THE MATUGEN TEMPLATE INSTEAD

Singleton {
    id: root
    property QtObject m3colors
    property QtObject animation
    property QtObject animationCurves
    property QtObject colors
    property QtObject rounding
    property QtObject font
    property QtObject sizes
    property string syntaxHighlightingTheme

    property real backgroundTransparency: 0.11
    property real contentTransparency: 0.57

    m3colors: QtObject {
        property bool darkmode: true
        property bool transparent: false
        property color m3background: "#b3c5ff"
        property color m3error: "#ffb4ab"
        property color m3errorContainer: "#93000a"
        property color m3inverseOnSurface: "#2f3036"
        property color m3inversePrimary: "#495d92"
        property color m3inverseSurface: "#e3e2e9"
        property color m3onBackground: "#e3e2e9"
        property color m3onError: "#690005"
        property color m3onErrorContainer: "#ffdad6"
        property color m3onPrimary: "#192e60"
        property color m3onPrimaryContainer: "#dae1ff"
        property color m3onPrimaryFixed: "#001849"
        property color m3onPrimaryFixedVariant: "#314578"
        property color m3onSecondary: "#2a3042"
        property color m3onSecondaryContainer: "#dde2f9"
        property color m3onSecondaryFixed: "#151b2c"
        property color m3onSecondaryFixedVariant: "#414659"
        property color m3onSurface: "#e3e2e9"
        property color m3onSurfaceVariant: "#c5c6d0"
        property color m3onTertiary: "#422741"
        property color m3onTertiaryContainer: "#ffd6f9"
        property color m3onTertiaryFixed: "#2b122b"
        property color m3onTertiaryFixedVariant: "#5a3d58"
        property color m3outline: "#8f909a"
        property color m3outlineVariant: "#45464f"
        property color m3primary: "#b3c5ff"
        property color m3primaryContainer: "#314578"
        property color m3primaryFixed: "#dae1ff"
        property color m3primaryFixedDim: "#b3c5ff"
        property color m3scrim: "#000000"
        property color m3secondary: "#c1c6dd"
        property color m3secondaryContainer: "#414659"
        property color m3secondaryFixed: "#dde2f9"
        property color m3secondaryFixedDim: "#c1c6dd"
        property color m3shadow: "#000000"
        property color m3sourceColor: "#0c1f4a"
        property color m3surface: "#121318"
        property color m3surfaceBright: "#38393f"
        property color m3surfaceContainer: "#1e1f25"
        property color m3surfaceContainerHigh: "#292a2f"
        property color m3surfaceContainerHighest: "#33343a"
        property color m3surfaceContainerLow: "#1a1b21"
        property color m3surfaceContainerLowest: "#0d0e13"
        property color m3surfaceDim: "#121318"
        property color m3surfaceTint: "#b3c5ff"
        property color m3surfaceVariant: "#45464f"
        property color m3tertiary: "#e1bbdc"
        property color m3tertiaryContainer: "#5a3d58"
        property color m3tertiaryFixed: "#ffd6f9"
        property color m3tertiaryFixedDim: "#e1bbdc"
        property color m3green: "#9ed49d"
        property color m3yellow: "#e5c36c"
    }

    colors: QtObject {
        property color colSubtext: m3colors.m3outline
        property color colLayer0: ColorUtils.mix(ColorUtils.transparentize(m3colors.m3background, root.backgroundTransparency), m3colors.m3primary, Config.options.appearance.extraBackgroundTint ? 0.99 : 1)
        property color colOnLayer0: m3colors.m3onBackground
        property color colLayer0Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.9, root.contentTransparency))
        property color colLayer0Active: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.8, root.contentTransparency))
        property color colLayer0Border: ColorUtils.mix(root.m3colors.m3outlineVariant, colLayer0, 0.4)
        property color colLayer1: ColorUtils.transparentize(m3colors.m3surfaceContainerLow, root.contentTransparency)
        property color colOnLayer1: m3colors.m3onSurfaceVariant
        property color colOnLayer1Inactive: ColorUtils.mix(colOnLayer1, colLayer1, 0.45)
        property color colLayer2: ColorUtils.transparentize(m3colors.m3surfaceContainer, root.contentTransparency)
        property color colOnLayer2: m3colors.m3onSurface
        property color colOnLayer2Disabled: ColorUtils.mix(colOnLayer2, m3colors.m3background, 0.4)
        property color colLayer1Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.92), root.contentTransparency)
        property color colLayer1Active: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.85), root.contentTransparency)
        property color colLayer2Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.90), root.contentTransparency)
        property color colLayer2Active: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.80), root.contentTransparency)
        property color colLayer2Disabled: ColorUtils.transparentize(ColorUtils.mix(colLayer2, m3colors.m3background, 0.8), root.contentTransparency)
        property color colLayer3: ColorUtils.transparentize(m3colors.m3surfaceContainerHigh, root.contentTransparency)
        property color colOnLayer3: m3colors.m3onSurface
        property color colLayer3Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.90), root.contentTransparency)
        property color colLayer3Active: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.80), root.contentTransparency)
        property color colLayer4: ColorUtils.transparentize(m3colors.m3surfaceContainerHighest, root.contentTransparency)
        property color colOnLayer4: m3colors.m3onSurface
        property color colLayer4Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer4, colOnLayer4, 0.90), root.contentTransparency)
        property color colLayer4Active: ColorUtils.transparentize(ColorUtils.mix(colLayer4, colOnLayer4, 0.80), root.contentTransparency)
        property color colPrimary: m3colors.m3primary
        property color colOnPrimary: m3colors.m3onPrimary
        property color colPrimaryHover: ColorUtils.mix(colors.colPrimary, colLayer1Hover, 0.87)
        property color colPrimaryActive: ColorUtils.mix(colors.colPrimary, colLayer1Active, 0.7)
        property color colPrimaryContainer: m3colors.m3primaryContainer
        property color colPrimaryContainerHover: ColorUtils.mix(colors.colPrimaryContainer, colors.colOnPrimaryContainer, 0.9)
        property color colPrimaryContainerActive: ColorUtils.mix(colors.colPrimaryContainer, colors.colOnPrimaryContainer, 0.8)
        property color colOnPrimaryContainer: m3colors.m3onPrimaryContainer
        property color colSecondary: m3colors.m3secondary
        property color colOnSecondary: m3colors.m3onSecondary
        property color colSecondaryHover: ColorUtils.mix(m3colors.m3secondary, colLayer1Hover, 0.85)
        property color colSecondaryActive: ColorUtils.mix(m3colors.m3secondary, colLayer1Active, 0.4)
        property color colSecondaryContainer: m3colors.m3secondaryContainer
        property color colSecondaryContainerHover: ColorUtils.mix(m3colors.m3secondaryContainer, m3colors.m3onSecondaryContainer, 0.90)
        property color colSecondaryContainerActive: ColorUtils.mix(m3colors.m3secondaryContainer, m3colors.m3onSecondaryContainer, 0.54)
        property color colTertiary: m3colors.m3tertiary
        property color colTertiaryHover: ColorUtils.mix(m3colors.m3tertiary, colLayer1Hover, 0.85)
        property color colTertiaryActive: ColorUtils.mix(m3colors.m3tertiary, colLayer1Active, 0.4)
        property color colTertiaryContainer: m3colors.m3tertiaryContainer
        property color colTertiaryContainerHover: ColorUtils.mix(m3colors.m3tertiaryContainer, m3colors.m3onTertiaryContainer, 0.90)
        property color colTertiaryContainerActive: ColorUtils.mix(m3colors.m3tertiaryContainer, colLayer1Active, 0.54)
        property color colOnTertiary: m3colors.m3onTertiary
        property color colOnTertiaryContainer: m3colors.m3onTertiaryContainer
        property color colOnSecondaryContainer: m3colors.m3onSecondaryContainer
        property color colSurfaceContainerLow: ColorUtils.transparentize(m3colors.m3surfaceContainerLow, root.contentTransparency)
        property color colSurfaceContainer: ColorUtils.transparentize(m3colors.m3surfaceContainer, root.contentTransparency)
        property color colBackgroundSurfaceContainer: ColorUtils.transparentize(m3colors.m3surfaceContainer, root.backgroundTransparency)
        property color colSurfaceContainerHigh: ColorUtils.transparentize(m3colors.m3surfaceContainerHigh, root.contentTransparency)
        property color colSurfaceContainerHighest: ColorUtils.transparentize(m3colors.m3surfaceContainerHighest, root.contentTransparency)
        property color colSurfaceContainerHighestHover: ColorUtils.mix(m3colors.m3surfaceContainerHighest, m3colors.m3onSurface, 0.95)
        property color colSurfaceContainerHighestActive: ColorUtils.mix(m3colors.m3surfaceContainerHighest, m3colors.m3onSurface, 0.85)
        property color colOnSurface: m3colors.m3onSurface
        property color colOnSurfaceVariant: m3colors.m3onSurfaceVariant
        property color colTooltip: m3colors.m3inverseSurface
        property color colOnTooltip: m3colors.m3inverseOnSurface
        property color colScrim: ColorUtils.transparentize(m3colors.m3scrim, 0.5)
        property color colShadow: ColorUtils.transparentize(m3colors.m3shadow, 0.7)
        property color colOutline: m3colors.m3outline
        property color colOutlineVariant: m3colors.m3outlineVariant
        property color colError: m3colors.m3error
        property color colErrorHover: ColorUtils.mix(m3colors.m3error, colLayer1Hover, 0.85)
        property color colErrorActive: ColorUtils.mix(m3colors.m3error, colLayer1Active, 0.7)
        property color colOnError: m3colors.m3onError
        property color colErrorContainer: m3colors.m3errorContainer
        property color colErrorContainerHover: ColorUtils.mix(m3colors.m3errorContainer, m3colors.m3onErrorContainer, 0.90)
        property color colErrorContainerActive: ColorUtils.mix(m3colors.m3errorContainer, m3colors.m3onErrorContainer, 0.70)
        property color colOnErrorContainer: m3colors.m3onErrorContainer
        property color green: m3colors.m3green
        property color yellow: m3colors.m3yellow
    }
}

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import qs.common.widgets

// TODO: MAKE PART OF GLOBAL CONFIG
Scope {
    id: corners
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    component CornerPanelWindow: PanelWindow {
        id: cornerPanelWindow
        property var screen: QsWindow.window?.screen
        visible: true
        property var corner

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "quickshell:corners"
        WlrLayershell.layer: WlrLayer.Overlay
        color: "transparent"
        
        anchors {
            top: corner.isTop
            bottom: corner.isBottom
            left: corner.isLeft
            right: corner.isRight
        }


        implicitWidth: corner.implicitWidth
        implicitHeight: corner.implicitHeight

        RoundCorner {
            id: corner
            anchors.fill: parent
            corner: cornerPanelWindow.corner

            implicitSize: 30
            implicitWidth: implicitSize
            implicitHeight: implicitSize
        }

    }
    Variants {
        model: Quickshell.screens

        Scope {
            id: monitorScope
            required property var modelData
            property HyprlandMonitor monitor: Hyprland.monitorFor(modelData)

            CornerPanelWindow {
                screen: monitorScope.modelData
                corner: RoundCorner.CornerEnum.TopLeft
            }
            CornerPanelWindow {
                screen: monitorScope.modelData
                corner: RoundCorner.CornerEnum.TopRight
            }
            CornerPanelWindow {
                screen: monitorScope.modelData
                corner: RoundCorner.CornerEnum.BottomLeft
            }
            CornerPanelWindow {
                screen: monitorScope.modelData
                corner: RoundCorner.CornerEnum.BottomRight
            }
        }
    }
}

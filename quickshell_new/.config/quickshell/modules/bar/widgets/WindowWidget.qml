import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.common.widgets
import qs.common.functions
import qs.common

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true

        StyledTooltip {
            extraVisibleCondition: false
            alternativeVisibleCondition: hoverArea.containsMouse && (root.activeWindow?.title.length > 40)
            text: root.activeWindow?.title ?? `Workspace ${root.monitor?.activeWorkspace?.id}`
        }
    }

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    ColumnLayout {
        id: content
        spacing: -4

        StyledText {
            Layout.fillWidth: true
            color: ColorUtils.transparentize(Colors.md3.on_surface, 0.6)
            text: root.activeWindow?.appId ?? "Desktop"
        }

        StyledText {
            Layout.fillWidth: true
            Layout.maximumWidth: 400
            elide: Text.ElideRight
            font.pixelSize: Appearance.font.size.large
            text: root.activeWindow?.title ?? `Workspace ${root.monitor?.activeWorkspace?.id}`
        }
    }
}

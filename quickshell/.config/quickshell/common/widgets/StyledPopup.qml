pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland

import qs.common.widgets

LazyLoader {
    id: root

    property Item hoverTarget
    default property Item contentItem
    property real popupBackgroundMargin: 0

    active: hoverTarget && hoverTarget.containsMouse

    component: PanelWindow {
        id: popupWindow
        color: "transparent"

        anchors {
            left: true
            right: false
            top: true
            bottom: false
        }

        implicitWidth: popupBackground.implicitWidth + 10 * 2 + root.popupBackgroundMargin
        implicitHeight: popupBackground.implicitHeight + 10 * 2 + root.popupBackgroundMargin

        mask: Region {
            item: popupBackground
        }

        exclusionMode: ExclusionMode.Ignore
        exclusiveZone: 0

        margins {
            left: {
                return root.QsWindow?.mapFromItem(
                    root.hoverTarget,
                    (root.hoverTarget.width - popupBackground.implicitWidth) / 2, 0
                ).x;
            }
            top: 50
            bottom: 50
        }

        WlrLayershell.namespace: "quickshell:popup"
        WlrLayershell.layer: WlrLayer.Overlay

        StyledRectangularShadow {
            target: popupBackground
        }

        Rectangle {
            id: popupBackground
            readonly property real margin: 10
            anchors {
                fill: parent
                leftMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.left)
                rightMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.right)
                topMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.top)
                bottomMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.bottom)
            }
            implicitWidth: root.contentItem.implicitWidth + margin * 2
            implicitHeight: root.contentItem.implicitHeight + margin * 2
            color: "#1e1f25"
            radius: 12
            children: [root.contentItem]

            border.width: 1
            border.color: "#8f909a"
        }
    }
}

pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.common
import qs.common.functions
import qs.common.widgets

RippleButton {
    id: root
    required property QsMenuEntry menuEntry
    property bool forceIconColumn: false
    property bool forceSpecialInteractionColumn: false

    readonly property bool isSeparator: menuEntry?.isSeparator ?? false
    readonly property bool hasIcon: (menuEntry?.icon.length ?? 0) > 0
    readonly property bool hasSpecialInteraction: (menuEntry?.buttonType ?? QsMenuButtonType.None) !== QsMenuButtonType.None

    signal dismiss()
    signal openSubmenu(handle: QsMenuHandle)

    colBackground: menuEntry.isSeparator ? Appearance.m3colors.m3outlineVariant : ColorUtils.transparentize(Appearance.colors.colLayer0)
    enabled: !root.isSeparator
    opacity: 1

    horizontalPadding: 12
    implicitWidth: contentItem.implicitWidth + horizontalPadding * 2
    implicitHeight: root.isSeparator ? 1 : 36
    Layout.topMargin: root.isSeparator ? 4 : 0
    Layout.bottomMargin: root.isSeparator ? 4 : 0
    Layout.fillWidth: true

    Component.onCompleted: {
        if (root.isSeparator) root.buttonColor = root.colBackground;
    }

    releaseAction: () => {
        if (menuEntry.hasChildren) {
            root.openSubmenu(root.menuEntry);
            return;
        }
        menuEntry.triggered();
        root.dismiss();
    }

    altAction: (event) => {
        event.accepted = false;
    }

    contentItem: RowLayout {
        id: contentItem
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: root.horizontalPadding
            rightMargin: root.horizontalPadding
        }

        spacing: 8
        visible: !root.isSeparator

        // Interaction: checkbox or radio button
        Item {
            visible: root.hasSpecialInteraction || root.forceSpecialInteractionColumn
            implicitWidth: 20
            implicitHeight: 20

            Loader {
                anchors.fill: parent
                active: (root.menuEntry?.buttonType ?? QsMenuButtonType.None) === QsMenuButtonType.RadioButton

                sourceComponent: StyledRadioButton {
                    enabled: false
                    padding: 0
                    checked: root.menuEntry.checkState === Qt.Checked
                }
            }

            Loader {
                anchors.fill: parent
                active: (root.menuEntry?.buttonType ?? QsMenuButtonType.None) === QsMenuButtonType.CheckBox && (root.menuEntry?.checkState ?? Qt.Unchecked) !== Qt.Unchecked 

                sourceComponent: MaterialSymbol {
                    text: root.menuEntry.checkState === Qt.PartiallyChecked ? "check_indeterminate_small" : "check"
                    iconSize: 20
                }
            }
        }

        Item {
            visible: root.hasIcon || root.forceIconColumn
            implicitWidth: 20
            implicitHeight: 20

            Loader {
                anchors.centerIn: parent
                active: root.hasIcon
                sourceComponent: IconImage {
                    asynchronous: true
                    source: root.menuEntry.icon
                    implicitSize: 20
                    mipmap: true
                }
            }
        }
        StyledText {
            id: label
            text: root.menuEntry.text ?? ""
            font.pixelSize: Appearance.font.size.normal
            Layout.fillWidth: true
        }

        Loader {
            active: root.menuEntry?.hasChildren ?? false
            sourceComponent: MaterialSymbol {
                text: "chevron_right"
                iconSize: 20
            }
        }

    }
}

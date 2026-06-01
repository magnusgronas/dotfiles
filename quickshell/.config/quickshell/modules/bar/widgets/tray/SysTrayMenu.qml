pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.common
import qs.common.widgets
import qs.common.functions

// TODO: MAKE PART OF GLOBAL CONFIG
PopupWindow {
    id: root
    required property QsMenuHandle trayItemMenuHandle
    property real popupBackgroundMargin: 0
    property string trayItemId: ""

    property bool isOpen: false

    signal menuClosed
    signal menuOpened(qsWindow: var)

    HyprlandFocusGrab {
        id: focusGrab
        windows: [root]
        onCleared: {
            if (root.visible) {
                root.close();
            }
        }
    }

    // Animate closing the menu
    Timer {
        id: closeTimer
        interval: 200
        onTriggered: {
            root.visible = false;
            while (stackView.depth > 1) {
                stackView.pop();
            }
            root.menuClosed();
        }
    }

    color: "transparent"
    property real padding: 10

    implicitHeight: {
        let result = 0;
        for (let child of stackView.children) {
            result = Math.max(child.implicitHeight, result);
        }
        return result + popupBackground.padding * 2 + root.padding * 2;
    }
    implicitWidth: {
        let result = 0;
        for (let child of stackView.children) {
            result = Math.max(child.implicitWidth, result);
        }
        return result + popupBackground.padding * 2 + root.padding * 2;
    }

    function open() {
        root.visible = true;
        focusGrab.active = true;
        root.isOpen = true;
        root.menuOpened(root);
    }

    function close() {
        if(!root.isOpen) return;
        focusGrab.active = false;
        root.isOpen = false;
        closeTimer.start();
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.BackButton | Qt.RightButton

        onPressed: event => {
            if ((event.button === Qt.BackButton || event.button === Qt.RightButton) && stackView.depth > 1) {
                stackView.pop();
            }
        }

        StyledRectangularShadow {
            target: popupBackground
            opacity: popupBackground.opacity
        }

        Rectangle {
            id: popupBackground
            readonly property real padding: 4
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: root.padding
            }

            color: Appearance.colors.colLayer0
            radius: 16
            border.width: 1
            border.color: Appearance.colors.colLayer0Border
            clip: true

            opacity: root.isOpen ? 1 : 0
            implicitWidth: stackView.implicitWidth + popupBackground.padding * 2
            implicitHeight: stackView.implicitHeight + popupBackground.padding * 2

            Behavior on opacity {
                animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
            }
            Behavior on implicitHeight {
                animation: Appearance.animation.elementResize.numberAnimation.createObject(this)
            }
            Behavior on implicitWidth {
                animation: Appearance.animation.elementResize.numberAnimation.createObject(this)
            }

            StackView {
                id: stackView
                anchors {
                    fill: parent
                    margins: popupBackground.padding
                }
                pushEnter: NoAnim {}
                pushExit: NoAnim {}
                popEnter: NoAnim {}
                popExit: NoAnim {}

                implicitWidth: currentItem.implicitWidth
                implicitHeight: currentItem.implicitHeight

                initialItem: SubMenu {
                    handle: root.trayItemMenuHandle
                }
            }
        }
    }

    component NoAnim: Transition {
        NumberAnimation {
            duration: 0
        }
    }

    component SubMenu: ColumnLayout {
        id: submenu
        required property QsMenuHandle handle
        property bool isSubMenu: false
        property bool shown: false
        opacity: shown ? 1 : 0

        Behavior on opacity {
            animation: Appearance.animation.elementMoveFast.numberAnimation.createObject(this)
        }

        Component.onCompleted: shown = true
        StackView.onActivating: shown = true
        StackView.onDeactivating: shown = false
        StackView.onRemoved: destroy()

        QsMenuOpener {
            id: menuOpener
            menu: submenu.handle
        }

        spacing: 0

        Loader {
            Layout.fillWidth: true
            Layout.topMargin: 4
            visible: submenu.isSubMenu
            active: visible
            sourceComponent: RippleButton {
                id: backButton
                buttonRadius: popupBackground.radius - popupBackground.padding
                horizontalPadding: 12
                implicitWidth: contentItem.implicitWidth + horizontalPadding * 2
                implicitHeight: 36

                releaseAction: () => stackView.pop()

                contentItem: RowLayout {
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        right: parent.right
                        leftMargin: backButton.horizontalPadding
                        rightMargin: backButton.horizontalPadding
                    }
                    spacing: 0
                    MaterialSymbol {
                        iconSize: 20
                        text: "chevron_left"
                    }
                    StyledText {
                        Layout.fillWidth: true
                        text: "Back"
                    }
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            visible: submenu.isSubMenu
            implicitHeight: 1
            color: ColorUtils.transparentize(Appearance.colors.colSubtext, 0.4)
            Layout.topMargin: 2
            Layout.bottomMargin: 4
        }
        Repeater {
            id: menuEntriesRepeater
            property bool iconColumnNeeded: {
                for (let i = 0; i < menuOpener.children.values.length; i++) {
                    if (menuOpener.children.values[i].icon.length > 0)
                        return true;
                }
                return false;
            }
            property bool specialInteractionColumnNeeded: {
                for (let i = 0; i < menuOpener.children.values.length; i++) {
                    if (menuOpener.children.values[i].buttonType !== QsMenuButtonType.None)
                        return true;
                }
                return false;
            }
            model: menuOpener.children
            delegate: SysTrayMenuEntry {
                required property QsMenuEntry modelData
                forceIconColumn: menuEntriesRepeater.iconColumnNeeded
                forceSpecialInteractionColumn: menuEntriesRepeater.specialInteractionColumnNeeded
                menuEntry: modelData

                buttonRadius: popupBackground.radius - popupBackground.padding

                onDismiss: root.close()
                onOpenSubmenu: handle => {
                    stackView.push(subMenuComponent.createObject(null, {
                        handle: handle,
                        isSubMenu: true
                    }));
                }
            }
        }
    }
    Component {
        id: subMenuComponent
        SubMenu {}
    }
}

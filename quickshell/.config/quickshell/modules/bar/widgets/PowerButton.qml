import QtQuick
import QtQuick.Layouts

import qs.common.widgets
import qs.common

RippleButton {
    id: root

    padding: 8
    implicitWidth: symbol.implicitWidth + padding * 2
    implicitHeight: symbol.implicitWidth + padding * 2
    buttonRadius: Appearance.rounding.full

    colBackgroundHover: Appearance.colors.colLayer1Hover
    colRipple: Appearance.colors.colLayer1Active
    colBackgroundToggled: Appearance.colors.colSecondaryContainer
    colBackgroundToggledHover: Appearance.colors.colSecondaryContainerHover 
    colRippleToggled: Appearance.colors.colSecondaryContainerActive
    toggled: States.powerMenuOpen


    onPressed: {
        States.powerMenuOpen = !States.powerMenuOpen
    }

    contentItem: StyledText {
        id: symbol
        font.family: Appearance.font.family.nerdIcon
        font.pixelSize: Appearance.sizes.osIcon
        // anchors.fill: parent
        anchors.centerIn: parent
        text: "󰣇"
    }
}


import qs.common.widgets
import qs.common.functions
import qs.common

RippleButton {
    id: root

    padding: 8
    implicitWidth: symbol.implicitWidth + padding * 2
    implicitHeight: symbol.implicitWidth + padding * 2
    buttonRadius: Appearance.rounding.full
    colBackgroundHover: ColorUtils.transparentize(Colors.md3.surface_container, 0.8)

    onPressed: {
        States.powerMenuOpen = !States.powerMenuOpen;
    }

    contentItem: StyledText {
        id: symbol
        font.family: Appearance.font.family.nerdIcon
        font.pixelSize: Appearance.sizes.osIcon
        anchors.centerIn: parent

        color: Colors.md3.primary
        text: "󰣇"
    }
}

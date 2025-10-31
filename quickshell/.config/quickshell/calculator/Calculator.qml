import Quickshell
import Quickshell.Wayland

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.calculator.components

FloatingWindow {
    id: root
    title: "Calculator"

    color: "#121318"

    property var size: Qt.size(600, 800)

    maximumSize: size
    minimumSize: size

    Numpad {

    }
    
}

import Quickshell
import QtQuick

import qs.services
import qs.common
import qs.common.widgets

Item {
    id: root

    implicitWidth: wifiIcon.implicitWidth
    implicitHeight: wifiIcon.implicitHeight

    MaterialSymbol {
        anchors.centerIn: parent
        symbol: "wifi"
        iconSize: 24
        opacity: 0.3
        visible: Network.isWifiActive
    }

    MaterialSymbol {
        id: wifiIcon
        anchors.centerIn: parent
        symbol: Network.icon
        iconSize: 24
        color: Network.color
    }
}

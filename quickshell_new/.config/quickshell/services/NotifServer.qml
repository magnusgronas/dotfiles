pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

import QtQuick

Singleton {

    property var trackedNotifications: notifServer.trackedNotifications

    ListModel {
        id: history
    }

    NotificationServer {
        id: notifServer
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodySupported: true
        bodyMarkupSupported: true
        bodyImagesSupported: true
        imageSupported: true
        keepOnReload: true
        persistenceSupported: true
        actionIconsSupported: true

        onNotification: n => {
            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm"),
                appIcon: n.appIcon || "",
                image: n.image || ""
            });

            n.tracked = true;
        }
    }
}

pragma Singleton

import Quickshell

Singleton {
    property bool mediaPopupOpen: false
    property bool showBar: true
    onMediaPopupOpenChanged: console.log(`Media Popup state changed, current state: ${mediaPopupOpen}`)
}

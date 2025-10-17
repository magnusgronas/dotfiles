import QtQuick
import Quickshell
import qs.modules.osd
import qs.modules.bar
import qs.modules.bar.widgets

ShellRoot {
    // Using LazyLoader i can in the furure turn on and of modules
    LazyLoader { active: true; component: Osd {} }
    LazyLoader { active: true; component: Bar {} }
}


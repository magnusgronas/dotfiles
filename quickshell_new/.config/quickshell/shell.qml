import Quickshell
import qs.modules.bar
import qs.modules.powermenu
import qs.modules.mediaControls
import qs.modules.notifications
import qs.services

ShellRoot {
    LazyLoader { active: true; component: Bar {}}
    LazyLoader { active: true; component: PowerMenu {}}
    LazyLoader { active: true; component: MediaControls {}}
    LazyLoader { active: true; component: NotificationPopup {}}
}

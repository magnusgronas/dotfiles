import Quickshell
import qs.calculator
import qs.modules.osd
import qs.modules.bar
import qs.modules.bar.widgets
import qs.modules.powermenu
import qs.modules.corners

ShellRoot {
    // Using LazyLoader i can in the furure turn on and of modules
    LazyLoader { active: true; component: Osd {} }
    LazyLoader { active: true; component: Bar {} }
    LazyLoader { active: false; component: Calculator {} }
    LazyLoader { active: true; component: Corners {}}
    LazyLoader { active: true; component: PowerMenu {}}
}


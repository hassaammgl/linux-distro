import QtQuick
import QtQuick.Window
import QtWayland.Compositor
import QtWayland.Compositor.XdgShell

WaylandCompositor {
    id: comp
    socketName: "wayland-rat"

    ListModel { id: shells }

    WaylandOutput {
        compositor: comp
        sizeFollowsWindow: true
        window: Window {
            id: win
            visible: true
            color: "#1e1e2e"
            width: 1024
            height: 576

            // All client windows live here
            Repeater {
                model: shells
                ShellSurfaceItem {
                    shellSurface: model.shellSurface
                    onSurfaceDestroyed: shells.remove(index)
                }
            }
        }
    }

    XdgShell {
        onToplevelCreated: (toplevel, xdgSurface) => {
            shells.append({ shellSurface: xdgSurface })
        }
    }
}

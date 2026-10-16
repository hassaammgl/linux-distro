import QtQuick
import QtQuick.Window
import QtWayland.Compositor

WaylandCompositor {
    id: comp
    socketName: "wayland-rat"

    WaylandOutput {
        compositor: comp
        sizeFollowsWindow: true
        window: Window {
            visible: true
            color: "#1e1e2e"

            // Top bar
            Rectangle {
                id: bar
                anchors { top: parent.top; left: parent.left; right: parent.right }
                height: 36
                color: "#181825"

                Text {
                    anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
                    text: "ratwm"
                    color: "#89b4fa"
                    font { pixelSize: 16; bold: true }
                }
                Text {
                    id: clock
                    anchors { right: parent.right; rightMargin: 14; verticalCenter: parent.verticalCenter }
                    color: "#cdd6f4"
                    font.pixelSize: 16
                }
                Timer {
                    interval: 1000; running: true; repeat: true; triggeredOnStart: true
                    onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd hh:mm:ss")
                }
            }

            // Area where client windows are shown (below the bar)
            Item {
                id: workspace
                anchors { top: bar.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
            }
        }
    }

    // One of these is created for every client window
    Component {
        id: chrome
        ShellSurfaceItem {
            x: 60; y: 60
            onSurfaceDestroyed: destroy()
        }
    }

    XdgShell {
        onToplevelCreated: (toplevel, xdgSurface) => {
            chrome.createObject(workspace, { "shellSurface": xdgSurface })
        }
    }
}

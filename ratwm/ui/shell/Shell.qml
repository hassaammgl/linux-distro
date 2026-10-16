import QtQuick
import QtQuick.Window

Window {
    id: win
    visible: true
    width: 1280
    height: 720
    title: "rat-shell"
    color: "#1e1e2e"

    Wallpaper {
        anchors.fill: parent
    }

    TopBar {
        id: topBar
        anchors { top: parent.top; left: parent.left; right: parent.right }
        onMenuClicked: sideBar.open = !sideBar.open
    }

    Sidebar {
        id: sideBar
        anchors { top: topBar.bottom; left: parent.left; bottom: dock.top }
    }

    // Desktop content area (between sidebar / topbar / dock)
    Item {
        id: desktop
        anchors {
            top: topBar.bottom
            left: sideBar.right
            right: parent.right
            bottom: dock.top
        }
    }

    Dock {
        id: dock
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
    }
}

import QtQuick

Rectangle {
    id: root
    width: open ? 220 : 0
    color: "#181825"
    clip: true

    property bool open: false
    property var items: [
        { label: "Home",     icon: "⌂" },
        { label: "Apps",     icon: "▦" },
        { label: "Files",    icon: "▤" },
        { label: "Settings", icon: "⚙" },
    ]

    Behavior on width { NumberAnimation { duration: 160; easing.type: Easing.OutCubic } }

    Column {
        anchors { fill: parent; topMargin: 12; leftMargin: 10; rightMargin: 10 }
        spacing: 4

        Repeater {
            model: root.items
            Rectangle {
                width: parent.width
                height: 40
                radius: 8
                color: ma.containsMouse ? "#313244" : "transparent"

                Row {
                    anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                    spacing: 12
                    Text { text: modelData.icon; color: "#89b4fa"; font.pixelSize: 16 }
                    Text { text: modelData.label; color: "#cdd6f4"; font.pixelSize: 14 }
                }
                MouseArea {
                    id: ma
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}

import QtQuick

Item {
    id: root
    height: 64

    // cwd optional — relative to shell working dir (ui/)
    property var apps: [
        { name: "Clock", icon: "⏱", color: "#f38ba8",
          program: "./build/rat-clock", args: [], cwd: "" },
        { name: "Files", icon: "▤", color: "#89b4fa",
          program: "./build/rat-files", args: [], cwd: "" },
        { name: "PyQt",  icon: "🐍", color: "#a6e3a1",
          program: "python3", args: ["main.py"], cwd: "apps/pyqt" },
        { name: "Node",  icon: "⬢", color: "#cba6f7",
          program: "./node_modules/.bin/qode", args: ["main.js"], cwd: "apps/nodeqt" },
    ]

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: row.width + 24
        height: 56
        radius: 16
        color: "#181825"
        opacity: 0.95

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: root.apps
                Rectangle {
                    width: 44; height: 44
                    radius: 12
                    color: ma.containsMouse ? "#313244" : "#1e1e2e"

                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon
                        color: modelData.color
                        font.pixelSize: 22
                    }
                    MouseArea {
                        id: ma
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Launcher.run(modelData.program, modelData.args, modelData.cwd || "")
                    }
                }
            }
        }
    }
}

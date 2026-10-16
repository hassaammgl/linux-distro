import QtQuick

Rectangle {
    id: root
    height: 36
    color: "#181825"

    signal menuClicked()

    Row {
        anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
        spacing: 14

        Text {
            text: "☰"
            color: "#cdd6f4"
            font.pixelSize: 16
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.menuClicked()
            }
        }
        Text {
            text: "rat"
            color: "#89b4fa"
            font { pixelSize: 15; bold: true }
        }
    }

    Text {
        id: clock
        anchors { right: parent.right; rightMargin: 14; verticalCenter: parent.verticalCenter }
        color: "#cdd6f4"
        font.pixelSize: 14
    }
    Timer {
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd  hh:mm")
    }
}

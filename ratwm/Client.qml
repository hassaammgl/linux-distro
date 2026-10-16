import QtQuick
import QtQuick.Window

Window {
    visible: true
    width: 420; height: 240
    title: "rat-client"
    color: "#313244"

    Text {
        id: label
        anchors.centerIn: parent
        color: "#cdd6f4"
        font.pixelSize: 48
    }
    Timer {
        interval: 1000; running: true; repeat: true; triggeredOnStart: true
        onTriggered: label.text = Qt.formatTime(new Date(), "hh:mm:ss")
    }
}

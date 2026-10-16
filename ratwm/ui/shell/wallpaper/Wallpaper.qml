import QtQuick

Rectangle {
    color: "#1e1e2e"

    // Soft gradient backdrop
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1e1e2e" }
            GradientStop { position: 1.0; color: "#11111b" }
        }
    }

    Text {
        anchors.centerIn: parent
        text: "rat"
        color: "#313244"
        font { pixelSize: 120; bold: true }
    }
}

import QtQuick
import QtQuick.Window
import Qt.labs.folderlistmodel

Window {
    id: win
    visible: true
    width: 480
    height: 360
    title: "Files"
    color: "#1e1e2e"

    // homeDir comes from C++ context property (HOME)
    FolderListModel {
        id: folders
        folder: "file://" + homeDir
        showDirsFirst: true
        showDotAndDotDot: true
        showHidden: false
    }

    Text {
        id: pathLabel
        anchors { top: parent.top; left: parent.left; right: parent.right; margins: 12 }
        text: folders.folder.toString().replace("file://", "")
        color: "#89b4fa"
        font.pixelSize: 14
        elide: Text.ElideMiddle
    }

    ListView {
        anchors {
            top: pathLabel.bottom; left: parent.left; right: parent.right
            bottom: parent.bottom; margins: 12; topMargin: 8
        }
        clip: true
        model: folders
        spacing: 2

        delegate: Rectangle {
            required property string fileName
            required property bool fileIsDir
            required property url fileURL

            width: ListView.view.width
            height: 32
            radius: 6
            color: ma.containsMouse ? "#313244" : "transparent"

            Text {
                anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                text: (fileIsDir ? "[dir]  " : "[file] ") + fileName
                color: "#cdd6f4"
                font.pixelSize: 14
            }
            MouseArea {
                id: ma
                anchors.fill: parent
                hoverEnabled: true
                onDoubleClicked: {
                    if (fileIsDir)
                        folders.folder = fileURL
                }
            }
        }
    }
}

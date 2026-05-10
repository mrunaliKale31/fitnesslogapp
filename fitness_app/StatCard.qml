import QtQuick 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
    property string label
    property var value
    property string icon

    spacing: 8

    Rectangle {
        width: 50
        height: 50
        radius: 25
        color: "#3498db"
        Layout.alignment: Qt.AlignHCenter

        Text {
            anchors.centerIn: parent
            text: icon
            color: "white"
            font.bold: true
            font.pixelSize: 24
        }
    }

    Text {
        text: label
        font.pixelSize: 12
        color: "#7f8c8d"
        Layout.alignment: Qt.AlignHCenter
    }

    Text {
        text: value
        font.pixelSize: 18
        font.bold: true
        color: "#2c3e50"
        Layout.alignment: Qt.AlignHCenter
    }
}

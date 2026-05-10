import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string label
    property var value
    property string cardColor

    Layout.fillWidth: true
    height: 120
    radius: 8
    border.color: "#ecf0f1"
    border.width: 1
    color: "white"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10

        Rectangle {
            width: 40
            height: 40
            radius: 20
            color: cardColor
            Layout.alignment: Qt.AlignHCenter
            opacity: 0.2
        }

        Text {
            text: label
            font.pixelSize: 12
            color: "#95a5a6"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: value
            font.pixelSize: 20
            font.bold: true
            color: cardColor
            Layout.alignment: Qt.AlignHCenter
        }

        Item { Layout.fillHeight: true }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    property bool active: false

    background: Rectangle {
        color: active ? "#3498db" : "transparent"
        radius: 4
    }

    contentItem: Text {
        text: parent.text
        color: parent.active ? "white" : "#ecf0f1"
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.pixelSize: 12
    }

    hoverEnabled: true
    onHoveredChanged: {
        if (hovered && !active) {
            background.color = "#34495e"
        } else if (!active) {
            background.color = "transparent"
        }
    }
}

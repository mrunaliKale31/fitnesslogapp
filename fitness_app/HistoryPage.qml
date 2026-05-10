import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property var logs
    signal deleteWorkout(int id)

    color: "#f5f5f5"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        Text {
            text: "Workout History"
            font.pixelSize: 20
            font.bold: true
            color: "#2c3e50"
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "white"
            radius: 8
            border.color: "#ecf0f1"
            border.width: 1

            ScrollView {
                anchors.fill: parent
                anchors.margins: 1

                ColumnLayout {
                    width: parent.width - 20
                    anchors.margins: 10
                    spacing: 8

                    Repeater {
                        model: logs

                        Rectangle {
                            Layout.fillWidth: true
                            height: 80
                            color: index % 2 === 0 ? "#fafafa" : "white"
                            radius: 4
                            border.color: "#ecf0f1"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 15

                                Rectangle {
                                    width: 50
                                    height: 50
                                    radius: 25
                                    color: "#3498db"

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.exercise.charAt(0).toUpperCase()
                                        color: "white"
                                        font.bold: true
                                        font.pixelSize: 20
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 5

                                    Text {
                                        text: modelData.exercise
                                        font.pixelSize: 15
                                        font.bold: true
                                        color: "#2c3e50"
                                    }

                                    Text {
                                        text: new Date(modelData.timestamp).toLocaleString()
                                        font.pixelSize: 12
                                        color: "#95a5a6"
                                    }

                                    RowLayout {
                                        spacing: 20

                                        Text {
                                            text: "Duration: " + modelData.duration + " min"
                                            font.pixelSize: 12
                                            color: "#7f8c8d"
                                        }

                                        Text {
                                            text: "Calories: " + modelData.calories
                                            font.pixelSize: 12
                                            color: "#7f8c8d"
                                        }
                                    }
                                }

                                Button {
                                    text: "Remove"
                                    Layout.preferredWidth: 80
                                    background: Rectangle {
                                        color: "#e74c3c"
                                        radius: 4
                                    }
                                    contentItem: Text {
                                        text: parent.text
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: 11
                                        font.bold: true
                                    }
                                    onClicked: deleteWorkout(modelData.id)
                                }
                            }
                        }
                    }

                    Item { Layout.fillHeight: true }
                }
            }
        }
    }
}

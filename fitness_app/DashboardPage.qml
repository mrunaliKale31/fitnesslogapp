import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property var stats
    property var logs
    signal addWorkout(string exercise, string duration, string calories)
    signal deleteWorkout(int id)

    color: "#f5f5f5"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // Stats Section
        Rectangle {
            Layout.fillWidth: true
            height: 120
            color: "white"
            radius: 8
            border.color: "#ecf0f1"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 20

                StatCard {
                    label: "Total Workouts"
                    value: stats.total_workouts || 0
                    icon: "W"
                }

                StatCard {
                    label: "Total Calories"
                    value: stats.total_calories || 0
                    icon: "C"
                }

                StatCard {
                    label: "Total Duration"
                    value: (stats.total_duration || 0) + " min"
                    icon: "D"
                }

                StatCard {
                    label: "Avg Duration"
                    value: ((stats.average_duration || 0).toFixed(1)) + " min"
                    icon: "A"
                }

                Item { Layout.fillWidth: true }
            }
        }

        // Add Workout Section
        Rectangle {
            Layout.fillWidth: true
            height: 140
            color: "white"
            radius: 8
            border.color: "#ecf0f1"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 10

                Text {
                    text: "Add New Workout"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }

                RowLayout {
                    spacing: 10

                    TextField {
                        id: exerciseInput
                        placeholderText: "Exercise (e.g., Running)"
                        Layout.fillWidth: true
                        background: Rectangle {
                            border.color: "#ecf0f1"
                            border.width: 1
                            radius: 4
                            color: "#fafafa"
                        }
                    }

                    TextField {
                        id: durationInput
                        placeholderText: "Duration (min)"
                        inputMethodHints: Qt.ImhDigitsOnly
                        Layout.preferredWidth: 130
                        background: Rectangle {
                            border.color: "#ecf0f1"
                            border.width: 1
                            radius: 4
                            color: "#fafafa"
                        }
                    }

                    TextField {
                        id: caloriesInput
                        placeholderText: "Calories"
                        inputMethodHints: Qt.ImhDigitsOnly
                        Layout.preferredWidth: 130
                        background: Rectangle {
                            border.color: "#ecf0f1"
                            border.width: 1
                            radius: 4
                            color: "#fafafa"
                        }
                    }

                    Button {
                        text: "Add"
                        Layout.preferredWidth: 80
                        background: Rectangle {
                            color: "#27ae60"
                            radius: 4
                        }
                        contentItem: Text {
                            text: parent.text
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: true
                        }
                        onClicked: {
                            if (exerciseInput.text && durationInput.text && caloriesInput.text) {
                                addWorkout(exerciseInput.text, durationInput.text, caloriesInput.text)
                                exerciseInput.text = ""
                                durationInput.text = ""
                                caloriesInput.text = ""
                            }
                        }
                    }
                }
            }
        }

        // Recent Workouts
        Text {
            text: "Recent Workouts"
            font.pixelSize: 16
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
                        model: logs.slice(0, 5)

                        Rectangle {
                            Layout.fillWidth: true
                            height: 70
                            color: index % 2 === 0 ? "#fafafa" : "white"
                            radius: 4
                            border.color: "#ecf0f1"
                            border.width: 1

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 15

                                Rectangle {
                                    width: 40
                                    height: 40
                                    radius: 20
                                    color: "#3498db"

                                    Text {
                                        anchors.centerIn: parent
                                        text: modelData.exercise.charAt(0).toUpperCase()
                                        color: "white"
                                        font.bold: true
                                        font.pixelSize: 18
                                    }
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 3

                                    Text {
                                        text: modelData.exercise
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#2c3e50"
                                    }

                                    Text {
                                        text: new Date(modelData.timestamp).toLocaleString()
                                        font.pixelSize: 12
                                        color: "#95a5a6"
                                    }
                                }

                                Text {
                                    text: modelData.duration + " min"
                                    font.pixelSize: 12
                                    color: "#2c3e50"
                                    font.bold: true
                                    Layout.preferredWidth: 70
                                }

                                Text {
                                    text: modelData.calories + " cal"
                                    font.pixelSize: 12
                                    color: "#2c3e50"
                                    font.bold: true
                                    Layout.preferredWidth: 70
                                }

                                Button {
                                    text: "Delete"
                                    Layout.preferredWidth: 70
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

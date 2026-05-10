import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property var stats

    color: "#f5f5f5"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Fitness Profile"
            font.pixelSize: 20
            font.bold: true
            color: "#2c3e50"
        }

        // Profile Header
        Rectangle {
            Layout.fillWidth: true
            height: 150
            color: "white"
            radius: 8
            border.color: "#ecf0f1"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    text: "Your Fitness Journey"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#2c3e50"
                }

                Text {
                    text: "Keep track of your workouts and achieve your fitness goals"
                    font.pixelSize: 14
                    color: "#95a5a6"
                }

                Item { Layout.fillHeight: true }
            }
        }

        // Statistics Grid
        GridLayout {
            Layout.fillWidth: true
            columns: 2
            rowSpacing: 15
            columnSpacing: 15

            ProfileStatCard {
                label: "Total Workouts"
                value: stats.total_workouts || 0
                cardColor: "#3498db"
            }

            ProfileStatCard {
                label: "Total Calories Burned"
                value: stats.total_calories || 0
                cardColor: "#e74c3c"
            }

            ProfileStatCard {
                label: "Total Duration"
                value: (stats.total_duration || 0) + " minutes"
                cardColor: "#27ae60"
            }

            ProfileStatCard {
                label: "Average Duration"
                value: ((stats.average_duration || 0).toFixed(1)) + " min"
                cardColor: "#f39c12"
            }
        }

        // About Section
        Rectangle {
            Layout.fillWidth: true
            height: 150
            color: "white"
            radius: 8
            border.color: "#ecf0f1"
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Text {
                    text: "About This App"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#2c3e50"
                }

                Text {
                    text: "Fitness Log Application v1.0\n\nA modern fitness tracking application built with Qt QML and Python Flask.\n\nTrack your workouts, monitor your progress, and achieve your fitness goals."
                    font.pixelSize: 12
                    color: "#7f8c8d"
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 900
    height: 700
    visible: true
    title: "Fitness Log Application"
    color: "#f5f5f5"

    property string apiUrl: "http://127.0.0.1:5000/api"
    property var logs: []
    property var stats: ({})
    property int currentPage: 0  // 0: loading, 1: dashboard, 2: history, 3: profile
    property var refreshInterval: null

    // Loading timer
    Timer {
        id: loadingTimer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            fetchLogs()
            fetchStats()
            currentPage = 1
            startRefreshTimer()
        }
    }

    // Refresh timer
    Timer {
        id: refreshTimer
        interval: 3000
        running: false
        repeat: true
        onTriggered: {
            if (currentPage !== 0) {
                fetchLogs()
                fetchStats()
            }
        }
    }

    // Close event handler
    onClosing: {
        close.accepted = false
        quitDialog.open()
    }

    function startRefreshTimer() {
        refreshTimer.running = true
    }

    function stopRefreshTimer() {
        refreshTimer.running = false
    }

    // Loading Screen
    Rectangle {
        id: loadingScreen
        anchors.fill: parent
        color: "#2c3e50"
        visible: currentPage === 0
        z: 1000

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 30

            Text {
                text: "Fitness Log"
                font.pixelSize: 48
                font.bold: true
                color: "white"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Application"
                font.pixelSize: 32
                color: "#3498db"
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                width: 60
                height: 60
                radius: 30
                color: "transparent"
                border.color: "#3498db"
                border.width: 3
                Layout.alignment: Qt.AlignHCenter

                RotationAnimation on rotation {
                    from: 0
                    to: 360
                    duration: 2000
                    loops: Animation.Infinite
                }

                Rectangle {
                    width: 50
                    height: 50
                    radius: 25
                    anchors.centerIn: parent
                    color: "transparent"
                    border.color: "#3498db"
                    border.width: 2
                    opacity: 0.5
                }
            }

            Text {
                text: "Loading..."
                font.pixelSize: 16
                color: "#95a5a6"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Main Application
    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
        visible: currentPage !== 0

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // Header
            Rectangle {
                Layout.fillWidth: true
                height: 70
                color: "#2c3e50"
                Layout.margins: 0

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 15
                    spacing: 20

                    Text {
                        text: "Fitness Log"
                        font.pixelSize: 24
                        font.bold: true
                        color: "white"
                    }

                    Item { Layout.fillWidth: true }

                    // Navigation buttons
                    NavButton {
                        text: "Dashboard"
                        active: currentPage === 1
                        onClicked: currentPage = 1
                    }

                    NavButton {
                        text: "History"
                        active: currentPage === 2
                        onClicked: currentPage = 2
                    }

                    NavButton {
                        text: "Profile"
                        active: currentPage === 3
                        onClicked: currentPage = 3
                    }
                }
            }

            // Content Area
            StackLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: currentPage - 1

                // Dashboard Page
                DashboardPage {
                    stats: root.stats
                    logs: root.logs
                    onAddWorkout: {
                        root.addWorkout(exercise, duration, calories)
                    }
                    onDeleteWorkout: {
                        root.deleteWorkout(id)
                    }
                }

                // History Page
                HistoryPage {
                    logs: root.logs
                    onDeleteWorkout: {
                        root.deleteWorkout(id)
                    }
                }

                // Profile Page
                ProfilePage {
                    stats: root.stats
                }
            }
        }
    }

    // Quit Confirmation Dialog
    Rectangle {
        id: quitDialog
        anchors.centerIn: parent
        width: 400
        height: 200
        color: "white"
        radius: 10
        border.color: "#ddd"
        border.width: 1
        visible: false
        z: 2000

        function open() {
            visible = true
        }

        function close() {
            visible = false
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Text {
                text: "Exit Application?"
                font.pixelSize: 18
                font.bold: true
                color: "#2c3e50"
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: "Are you sure you want to quit the Fitness Log application?"
                font.pixelSize: 14
                color: "#7f8c8d"
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
            }

            Item { Layout.fillHeight: true }

            RowLayout {
                spacing: 10
                Layout.fillWidth: true

                Button {
                    text: "Cancel"
                    Layout.fillWidth: true
                    background: Rectangle {
                        color: "#95a5a6"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                    }
                    onClicked: quitDialog.close()
                }

                Button {
                    text: "Quit"
                    Layout.fillWidth: true
                    background: Rectangle {
                        color: "#e74c3c"
                        radius: 4
                    }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        font.bold: true
                    }
                    onClicked: Qt.quit()
                }
            }
        }
    }

    // API Functions
    function addWorkout(exercise, duration, calories) {
        var xhr = new XMLHttpRequest()
        xhr.open("POST", apiUrl + "/logs", true)
        xhr.setRequestHeader("Content-Type", "application/json")
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 201) {
                    fetchLogs()
                    fetchStats()
                }
            }
        }
        xhr.send(JSON.stringify({
            exercise: exercise,
            duration: parseInt(duration),
            calories: parseInt(calories)
        }))
    }

    function deleteWorkout(id) {
        var xhr = new XMLHttpRequest()
        xhr.open("DELETE", apiUrl + "/logs/" + id, true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    fetchLogs()
                    fetchStats()
                }
            }
        }
        xhr.send()
    }

    function fetchLogs() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", apiUrl + "/logs", true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = JSON.parse(xhr.responseText)
                    root.logs = response.reverse()
                }
            }
        }
        xhr.send()
    }

    function fetchStats() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", apiUrl + "/stats", true)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    root.stats = JSON.parse(xhr.responseText)
                }
            }
        }
        xhr.send()
    }

    Component.onCompleted: {
        // Show loading screen for 2 seconds
        loadingTimer.start()
    }

    Component.onDestruction: {
        stopRefreshTimer()
    }
}

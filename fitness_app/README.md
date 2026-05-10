# Fitness Log Application

A professional fitness tracking application built with Python Flask backend and Qt QML frontend.

## Quick Start

```bash
cd fitness_app
clickable desktop
```

That's it! Clickable will automatically:
- Install all dependencies
- Build the project
- Start the Flask backend
- Load the QML frontend
- Display the application

## Features

- **Loading Screen**: Animated splash screen on startup
- **Dashboard**: Quick stats overview and recent workouts
- **History**: Complete workout history with detailed information
- **Profile**: Comprehensive fitness statistics and journey overview
- **Real-time Stats**: Total workouts, calories burned, duration tracking
- **Workout Management**: Add, view, and delete workouts
- **Persistent Storage**: JSON-based data persistence
- **Professional UI**: Modern, responsive design with smooth animations
- **Quit Confirmation**: Safe app exit with confirmation dialog

## Technology Stack

- **Backend**: Python 3.8+ with Flask 3.0.0
- **Frontend**: Qt QML with PySide6 6.6.0
- **Data Storage**: JSON file-based
- **Framework**: Clickable (Ubuntu Touch compatible)

## Usage

### Adding a Workout

1. Click on the **Dashboard** tab
2. Fill in the workout details:
   - **Exercise**: Type of exercise (e.g., Running, Cycling, Swimming)
   - **Duration**: Time spent in minutes
   - **Calories**: Calories burned
3. Click **Add** button
4. Workout appears in the recent workouts list and stats update

### Viewing Workouts

- **Dashboard**: Shows recent 5 workouts and quick stats
- **History**: Shows all workouts with full details
- **Profile**: Shows comprehensive statistics and fitness journey

### Deleting a Workout

1. Navigate to **History** or **Dashboard**
2. Find the workout you want to delete
3. Click **Delete** or **Remove** button
4. Workout is removed and stats update

### Exiting the App

1. Click the close button (X) in the window
2. Confirmation dialog appears
3. Click **Quit** to exit or **Cancel** to continue

## API Endpoints

### Workouts
```
GET    /api/logs              - Get all workouts
POST   /api/logs              - Add new workout
DELETE /api/logs/<id>         - Delete workout
```

### Statistics
```
GET    /api/stats             - Get overall statistics
GET    /api/stats/daily       - Get daily breakdown
GET    /api/stats/exercises   - Get exercise-specific stats
```

### Profile
```
GET    /api/profile           - Get user profile
POST   /api/profile           - Update user profile
```

### Health
```
GET    /api/health            - Health check
```

## Project Structure

```
fitness_app/
├── app.py                    # Main entry point
├── backend.py                # Flask backend
├── main.qml                  # Main UI
├── DashboardPage.qml         # Dashboard
├── HistoryPage.qml           # History
├── ProfilePage.qml           # Profile
├── NavButton.qml             # Nav button
├── StatCard.qml              # Stat card
├── ProfileStatCard.qml       # Profile stat
├── clickable.json            # Clickable config
├── manifest.json             # Ubuntu Touch manifest
├── apparmor.json             # Security policy
├── fitness-log.desktop       # Desktop entry
├── setup.py                  # Package setup
├── requirements.txt          # Dependencies
├── fitness_data.json         # App data
├── .gitignore                # Git ignore
└── README.md                 # This file
```

## Building for Ubuntu Touch

```bash
clickable build --click
```

## Deploying to Ubuntu Touch Device

```bash
adb push fitness-log_1.0.0_all.click /tmp/
adb shell pkcon install-local /tmp/fitness-log_1.0.0_all.click
```

## License

MIT License

---

**Enjoy tracking your fitness journey with Fitness Log!**

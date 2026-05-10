# Fitness Log Application

A professional fitness tracking application with QML frontend and Python Flask backend.

## Quick Start

### 1. Install Dependencies
```bash
brew install qt
```

### 2. Setup
```bash
bash install.sh
```

### 3. Run
```bash
python3 app.py
```

## Features

- Loading screen with animation
- Multi-page interface (Dashboard, History, Profile)
- Workout logging and management
- Real-time statistics
- Persistent JSON storage
- Quit confirmation dialog
- Professional UI design

## API Endpoints

```
GET    /api/logs              - Get all workouts
POST   /api/logs              - Add new workout
DELETE /api/logs/<id>         - Delete workout
GET    /api/stats             - Get statistics
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
├── install.sh                # Installation script
├── run.sh                    # Run script
├── requirements.txt          # Dependencies
└── fitness_data.json         # App data
```

## Running Options

### Direct Python (Recommended)
```bash
python3 app.py
```

### Using Run Script
```bash
bash run.sh
```

## Testing

### Test Backend
```bash
curl http://127.0.0.1:5000/api/health
```

### Add Workout
```bash
curl -X POST http://127.0.0.1:5000/api/logs \
  -H "Content-Type: application/json" \
  -d '{"exercise":"Running","duration":30,"calories":300}'
```

## Building for Ubuntu Touch

```bash
clickable build --click
```

## Deployment

```bash
adb push fitness-log_1.0.0_all.click /tmp/
adb shell pkcon install-local /tmp/fitness-log_1.0.0_all.click
```

## License

MIT

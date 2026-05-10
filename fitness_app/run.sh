#!/bin/bash
# Fitness Log App - Run Script

set -e

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Virtual environment not found. Running installation..."
    bash install.sh
fi

echo "Activating virtual environment..."
source venv/bin/activate

echo ""
echo "Starting Fitness Log Application..."
echo "=========================================="
echo "Backend: http://127.0.0.1:5000"
echo "Frontend: QML Window"
echo "=========================================="
echo ""

python3 app.py

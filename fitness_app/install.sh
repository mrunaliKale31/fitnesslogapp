#!/bin/bash
# Fitness Log App - Installation Script for macOS

set -e

echo "=========================================="
echo "Fitness Log App - Installation Script"
echo "=========================================="
echo ""

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed"
    echo "Install it with: brew install python3"
    exit 1
fi

echo "Python version: $(python3 --version)"
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
else
    echo "Virtual environment already exists"
fi

echo ""
echo "Activating virtual environment..."
source venv/bin/activate

echo ""
echo "Installing dependencies..."
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

echo ""
echo "Verifying installations..."
python3 -c "from PySide6.QtGui import QGuiApplication; print('✓ PySide6 installed')"
python3 -c "import flask; print('✓ Flask installed')"
python3 -c "import werkzeug; print('✓ Werkzeug installed')"

echo ""
echo "=========================================="
echo "Installation complete!"
echo "=========================================="
echo ""
echo "To run the app:"
echo "  source venv/bin/activate"
echo "  python3 app.py"
echo ""
echo "Or use Clickable:"
echo "  clickable desktop"
echo ""

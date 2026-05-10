#!/bin/bash
# Build script for Clickable

set -e

echo "Building Fitness Log App..."

# Install Python dependencies
echo "Installing Python dependencies..."
pip3 install --upgrade pip setuptools wheel
pip3 install -r requirements.txt

echo "Build complete!"

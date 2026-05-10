#!/usr/bin/env python3
"""
Fitness Log App - Main Entry Point for Clickable
Integrates Flask backend with QML frontend using PySide6
"""

import sys
import os
import threading
import time
from pathlib import Path

# Add current directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))

try:
    from PySide6.QtGui import QGuiApplication
    from PySide6.QtQml import QQmlApplicationEngine
except ImportError:
    print("Error: PySide6 not found. Installing...")
    os.system("pip3 install PySide6==6.6.0")
    from PySide6.QtGui import QGuiApplication
    from PySide6.QtQml import QQmlApplicationEngine

from backend import create_app

class FitnessLogApp:
    """Main application class that manages backend and frontend"""
    
    def __init__(self):
        self.backend_thread = None
        self.app = None
        self.engine = None
        
    def start_backend(self):
        """Start Flask backend in a separate thread"""
        try:
            flask_app = create_app()
            # Run Flask in debug=False for production
            flask_app.run(
                debug=False,
                port=5000,
                host='127.0.0.1',
                use_reloader=False,
                threaded=True
            )
        except Exception as e:
            print(f"Error starting backend: {e}")
            sys.exit(1)
    
    def run(self):
        """Start the application"""
        try:
            # Start Flask backend in background thread
            self.backend_thread = threading.Thread(target=self.start_backend, daemon=True)
            self.backend_thread.start()
            
            # Wait for backend to initialize
            time.sleep(1.5)
            
            # Initialize Qt application
            self.app = QGuiApplication(sys.argv)
            
            # Create QML engine
            self.engine = QQmlApplicationEngine()
            
            # Get the directory where this script is located
            qml_dir = Path(__file__).parent
            
            # Load main QML file
            qml_file = qml_dir / "main.qml"
            
            if not qml_file.exists():
                print(f"Error: QML file not found at {qml_file}")
                return 1
            
            self.engine.load(str(qml_file))
            
            # Check if QML loaded successfully
            if not self.engine.rootObjects():
                print("Error: Failed to load QML file")
                return 1
            
            print("Application started successfully")
            print("Backend: http://127.0.0.1:5000")
            print("Frontend: QML Window")
            
            # Run the application
            return self.app.exec()
        
        except Exception as e:
            print(f"Error: {e}")
            import traceback
            traceback.print_exc()
            return 1

def main():
    """Main entry point"""
    app = FitnessLogApp()
    sys.exit(app.run())

if __name__ == '__main__':
    main()

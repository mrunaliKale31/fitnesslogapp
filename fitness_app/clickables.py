#!/usr/bin/env python3
"""
Clickables configuration for Fitness Log App
"""

import os
import sys
from pathlib import Path

# Add app directory to path
app_dir = Path(__file__).parent
sys.path.insert(0, str(app_dir))

# Import and run the app
from app import main

if __name__ == '__main__':
    main()

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-dev \
    python3-pip \
    qt5-qmake \
    qtbase5-dev \
    qml-module-qtquick-controls2 \
    qml-module-qtquick-layouts \
    qml-module-qtquick-window2 \
    libqt5gui5 \
    libqt5core5a \
    libqt5qml5 \
    libqt5quick5 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Set environment variables
ENV QT_QPA_PLATFORM=offscreen
ENV QML2_IMPORT_PATH=/usr/lib/x86_64-linux-gnu/qt5/qml
ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/qt5/plugins

# Run the application
CMD ["python3", "app.py"]

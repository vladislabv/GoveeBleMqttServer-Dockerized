# Use Python 3.7 slim as base
FROM python:3.7-slim

# Install required system packages for BLE/BlueZ and DBus
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    bluez \
    dbus \
    libdbus-1-dev \
    libglib2.0-0 \
    libglib2.0-dev \
    libdbus-1-3 \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Upgrade pip and install Python dependencies
RUN pip install --no-cache-dir -U pip \
 && pip install --no-cache-dir paho-mqtt bleak

# Ensure Python logs are flushed immediately
ENV PYTHONUNBUFFERED=1

# Default command
CMD ["python", "main.py"]

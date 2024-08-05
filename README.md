# Linux Conky Setup

![Conky](https://img.shields.io/badge/Conky-%23000000.svg?style=for-the-badge&logo=conky&logoColor=white)

## 📋 Description

This project provides a customizable Conky configuration for monitoring system information on your Linux desktop. Conky is a lightweight system monitor that can display various information such as CPU usage, memory usage, disk usage, network activity, and more.

## 🚀 Features

- **CPU Monitoring**: Display current CPU usage and temperature.
- **Memory Usage**: Show current RAM and swap usage.
- **Disk Usage**: Monitor free and used disk space.
- **Network Activity**: Display upload and download speeds.
- **Customizable**: Easily modify the Conky configuration to suit your needs.

## 📦 Installation

1. **Install Conky**:

```bash
sudo apt-get update
sudo apt-get install conky
```

2. **Clone the Repository**:

```bash
git clone https://github.com/SSTechInd-Tec/Conky-For-Linux.git
cd Conky-For-Linux
```

3. **Copy Files to ~/.conky directory**:

```bash
cp ./* ~/.conky
```

4. **Run Following Command to Start Conky**:

```bash
bash conky-startup.sh
```

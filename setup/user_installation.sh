#!/bin/sh
# Desktop Environment
pacman -S --noconfirm plasma plasma-wayland-session # Desktop Environment
pacman -S --noconfirm packagekit-qt5 # Required for Discoverer integration for Arch
systemctl enable sddm # Enable desktop manager

# Utilities
pacman -S --noconfirm cups # Printing System

# Development Tools
# pacman -S --noconfirm neovim # Neovim
pacman -S --noconfirm git # Version control system
pacman -S --noconfirm code # Visual Studio Code - Open Source

# Rust
pacman -S --noconfirm rustup # Install rustup
rustup default stable # Have rustup install the defaul stable toolchain

# Terminal Applications
pacman -S --noconfirm man-db # Command manual
pacman -S --noconfirm openssh # SSH client and server
pacman -S --noconfirm nmap # Network mapper

# GUI Applications
pacman -S --noconfirm konsole # Terminal emulator
pacman -S --noconfirm dolphin # File manager
pacman -S --noconfirm firefox # Web browser
pacman -S --noconfirm torbrowser-launcher # TOR broswer
pacman -S --noconfirm spectacle # Screenshot utility
pacman -S --noconfirm gwnview # Image viewer
pacman -S --noconfirm qbittorrent # Torrent client
pacman -S --noconfirm vlc # Media Player

# Docker
pacman -S --noconfirm docker docker-compose
systemctl enable docker
systemctl start docker

# Teardown
rm ~/user_installation.sh #Tidy up

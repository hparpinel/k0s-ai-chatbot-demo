#!/bin/bash

set -e  # Exit immediately on unhandled error

# Helper function to check the success of the last command
check_success() {
    if [ $? -ne 0 ]; then
        echo "❌ ERROR: $1 failed."
        exit 1
    else
        echo "✅ $1 completed successfully."
    fi
}

echo "=== Installing k0s ==="
curl -sSLf https://get.k0s.sh | sudo sh
check_success "Downloading and installing k0s"

echo "=== Initializing the k0s Cluster ==="
sudo k0s install controller --single
check_success "k0s install"

sudo k0s start
check_success "k0s start"

# Wait for the k0s status socket to be available (up to 20 seconds)
echo "Waiting for k0s to become ready..."
for i in {1..20}; do
    if [ -e /run/k0s/status.sock ]; then
        sudo k0s status
        check_success "k0s status"
        break
    else
        sleep 1
    fi
    if [ $i -eq 20 ]; then
        echo "❌ ERROR: k0s status.sock not available after 20 seconds."
        exit 1
    fi
done

echo "=== Installing Docker ==="
sudo apt update
sudo apt install -y docker.io
check_success "Installing Docker"

sudo systemctl enable docker
check_success "Enabling Docker service"

sudo systemctl start docker
check_success "Starting Docker service"

sudo usermod -aG docker $USER
check_success "Adding user to docker group"

echo "=== Installing Python Dependencies ==="

if ! command -v python3 &> /dev/null; then
    echo "Python 3 not found. Installing..."
    sudo apt install -y python3
    check_success "Installing Python 3"
else
    echo "✅ Python 3 already installed."
fi

if ! command -v pip3 &> /dev/null; then
    echo "pip3 not found. Installing..."
    sudo apt install -y python3-pip
    check_success "Installing pip3"
else
    echo "✅ pip3 already installed."
fi

echo "Upgrading pip and installing Python packages..."
pip3 install --upgrade pip
check_success "Upgrading pip"

pip3 install flask transformers
check_success "Installing flask and transformers"

pip3 install torch
check_success "Installing torch"

pip3 install flask transformers
check_success "Installing flask and transformers"

echo "=== Installing VS Code (Optional) ==="

if ! command -v code &> /dev/null; then
    echo "VS Code not found. Installing via snap..."
    sudo snap install code --classic
    check_success "Installing VS Code"
else
    echo "✅ VS Code already installed."
fi

echo "🎉 All components installed successfully. You may need to log out and back in for Docker group changes to apply."

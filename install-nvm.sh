#!/bin/bash

# Update the script to remove system Node.js installation

# Check if Node.js is installed
if command -v node &> /dev/null
then
    echo "Node.js is installed. Removing the system installation..."
    sudo apt-get remove -y nodejs
    echo "System Node.js installation removed."
else
    echo "Node.js is not installed."
fi

# Install NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js via NVM
nvm install node

echo "NVM and Node.js have been installed successfully!"
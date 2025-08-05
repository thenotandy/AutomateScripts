mkdir asetup
cd asetup
wget –O agentsetup.run https://prod.setup.itsupport247.net/linux/BareboneAgent/64/KDS_NOC-K_GROUP_COMPANIES_Linux_Server_ITSPlatform_TKNe9510cf0-92b1-4525-a3ea-6bdbebf0fead/RUN/setup
chmod 777 agentsetup.run
TOKEN=e9510cf0-92b1-4525-a3ea-6bdbebf0fead ./agentsetup.run

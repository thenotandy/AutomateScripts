apt install -y --fix-missing
wget "https://kgroupcompanies.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=9216783e995155b129ad43c2cd224338" -O agent.zip
unzip ./agent.zip
cd LTechAgent
chmod +x install.sh
./install.sh

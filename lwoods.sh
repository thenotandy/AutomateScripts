apt install -y --fix-missing
wget "https://kgroupcompanies.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=3da69af6ec95d379a10dc386361fd14a -O agent.zip
unzip ./agent.zip
cd LTechAgent
chmod +x install.sh
./install.sh

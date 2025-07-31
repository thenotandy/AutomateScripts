apt install -y --fix-missing
wget "https://kgroupcompanies.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=24ecf37d20cc22d6aa57c3388867cbd2" -O agent.zip
unzip ./agent.zip
cd LTechAgent
chmod +x install.sh
./install.sh

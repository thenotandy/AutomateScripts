apt install -y --fix-missing
wget "https://kgroupcompanies.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=f117a366838c001d222fea8384a66b05" -O agent.zip
unzip ./agent.zip
cd LTechAgent
chmod +x install.sh
./install.sh

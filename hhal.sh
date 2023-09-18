java -version
apt install -y openjdk-17-jre
java -version
apt install -y --fix-missing
wget "https://kgroupcompanies.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=8afbd05898880cad81bf6cf1ea059a95" -O agent.zip
unzip ./agent.zip
cd LTechAgent
chmod +x install.sh
./install.sh
sed -i 's/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

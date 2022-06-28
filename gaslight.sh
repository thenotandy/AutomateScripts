java -v
apt install -y openjdk-17-jre
java -v
apt install -y --fix-missing
wget "https://kgroupcompanies.hostedrmm.com/LabTech/Deployment.aspx?InstallerToken=a38d0bfcc8897305ec515861d3eec266" -O agent.zip
unzip ./agent.zip
cd LTechAgent
chmod +x install.sh
./install.sh
sed -i 's/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

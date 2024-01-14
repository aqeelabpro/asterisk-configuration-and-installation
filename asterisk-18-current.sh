sudo su
apt update
apt -y upgrade
apt update
add-apt-repository universe
apt -y install git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev  uuid-dev
apt policy asterisk
cd ~
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz
tar xvf asterisk-18-current.tar.gz
cd asterisk-18*/
contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure
make menuselect
make
make install
make samples
make config
ldconfig
make basic-pbx
groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk.asterisk /etc/asterisk
chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk.asterisk /usr/lib/asterisk
chmod -R 750 /var/{lib,log,run,spool}/asterisk /usr/lib/asterisk /etc/asterisk
# Define the file path
file_path="/etc/default/asterisk"

# Use sed to uncomment AST_USER and AST_GROUP lines
sed -i -e 's/^#AST_USER/AST_USER/' -e 's/^#AST_GROUP/AST_GROUP/' "$file_path"

echo "Uncommenting AST_USER and AST_GROUP in $file_path completed successfully!"
sed -i -e 's/^;runuser = asterisk/runuser = asterisk/' -e 's/^;rungroup = asterisk/rungroup = asterisk/' /etc/asterisk/asterisk.conf
systemctl restart asterisk
systemctl enable asterisk
systemctl status asterisk
asterisk -rvv
ufw allow proto tcp from any to any port 5060,5061
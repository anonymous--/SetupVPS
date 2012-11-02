#!/bin/bash
#########################################################################################
# Created by DjRaPmAn                                                                   #
#                                                                                       #
# This Script will download and install needed packages for a working desktop           #
# environment Due to bugs in centos 6 XFCE doesn't work correctly over VNC, so          #
# the script will jest install the "Desktop" group package.                             #
#                                                                                       #
#                                                                                       #
# Also since this is a server I recomend securing it even do it is only used for bot's  #
# it still is a server. Here a good read up / tutorial on how to do so                  #
# http://wiki.centos.org/HowTos/OS_Protection                                           #
#                                                                                       #
# You may edit or modify or redistribute this script.                                   #
# Version 2.00                                                                          #
# 6 September, 2012                                                                     #
#########################################################################################

read -p "What OS are you running? 'For Centos Enter 1' 'For Ubuntu Enter 2' " OS

if [[ "$OS" != "1" && "$OS" != "2" ]]
then
echo "OS Not Supported"
exit 0
fi

VERSION=$(cat /etc/redhat-release |awk '{print $3}' |sed 's/.[^.]*$//')
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
IP=$(curl -s b2ez.net/ip/; echo)

##############################
## Beginning of Centos code ##
##############################
#
###############
# centos 5 x86#
###############
#

if [[ "$OS" =  "1" && "$VERSION" =  "5" && "$ARCH" = "32" ]]
then
if [ $USER != 'root' ]
then
echo "REQUIRES ROOT"
exit 0
fi
yum -y install wget
rpm -ivh http://mirror.facebook.net/fedora/epel/5/i386/epel-release-5-4.noarch.rpm
wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=68233 -O java.rpm
rpm -Uvh java.rpm
#
### resolves issue with dependencies for xfce4
#
wget http://mirror.facebook.net/fedora/epel/5/i386/xfce4-settings-4.6.5-3.el5.i386.rpm
yum install xfce4-settings-4.6.5-3.el5.i386.rpm -y
rpm -ivh --force --nodeps http://mirror.centos.org/centos/5/extras/i386/RPMS/xfce-mcs-manager-4.4.2-1.el5.centos.i386.rpm
#
###
#yum groupinstall "XFCE-4.4" -y
yum install xfce* -y
yum -y install nano unzip xkill firefox vnc-server xorg-x11-server-Xorg gdm xorg-x11-fonts-* libXtst-devel-*
clear
echo ""
echo "Enter a password for VNC"
vncserver && vncserver -kill :1
sed -i 's/twm/startxfce4/g' ~/.vnc/xstartup
clear
vncserver
echo ""
echo "you may now connect to the vncserver at  $IP:1 or $IP:5901"
mkdir -p ~/jagexcache/runescape/LIVE
rm -rf *.rpm

###############
# centos 5 x64#
###############
#
elif [[ "$OS" = "1" && "$VERSION" = "5" && "$ARCH" = "64" ]]
then
if [ $USER != 'root' ]
then
echo "REQUIRES ROOT"
exit 0
fi
yum install wget -y
rpm -ivh http://mirror.facebook.net/fedora/epel/5/x86_64/epel-release-5-4.noarch.rpm
wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=68233 -O java.rpm
rpm -Uvh java.rpm
#yum groupinstall "XFCE-4.4" -y
yum install xfce* -y
yum -y install nano unzip xkill firefox vnc-server xorg-x11-server-Xorg gdm xorg-x11-fonts-* libXtst-devel-*
clear
echo ""
echo "Enter a password for VNC"
vncserver && vncserver -kill :1
sed -i 's/twm/startxfce4/g' ~/.vnc/xstartup
clear
vncserver
echo ""
echo "you may now connect to the vncserver at  $IP:1 or $IP:5901"
mkdir -p ~/jagexcache/runescape/LIVE
rm -rf *.rpm

###############
# centos 6 x86#
###############
#
elif [[ "$OS" = "1" && "$VERSION" = "6" && "$ARCH" = "32" ]]
then
if [ $USER != 'root' ]
then
echo "REQUIRES ROOT"
exit 0
fi
yum install wget -y
rpm -ivh http://mirror.facebook.net/fedora/epel/6/i386/epel-release-6-7.noarch.rpm
wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=68233 -O java.rpm
rpm -Uvh java.rpm
yum groupinstall "Xfce" "Desktop" -y
yum install -y nano unzip xkill firefox tigervnc-server xorg-x11-server-Xorg gdm xorg-x11-fonts-* libXtst-devel-*
clear
echo ""
echo "Enter a password for VNC"
vncserver && vncserver -kill :1
sed -i 's/twm/startxfce4/g' ~/.vnc/xstartup
clear
vncserver
echo ""
echo "you may now connect to the vncserver at  $IP:1 or $IP:5901"
mkdir -p ~/jagexcache/runescape/LIVE
rm -rf *.rpm

###############
# centos 6 x64#
###############
#
elif [[ "$OS" = "1" && "$VERSION" = "6" && "$ARCH" = "64" ]]
then
if [ $USER != 'root' ]
then
echo "REQUIRES ROOT"
exit 0
fi
yum install wget -y
rpm -ivh http://mirror.facebook.net/fedora/epel/6/x86_64/epel-release-6-7.noarch.rpm
wget http://javadl.sun.com/webapps/download/AutoDL?BundleId=68233 -O java.rpm
rpm -Uvh java.rpm
yum groupinstall "Xfce" "Desktop" -y
yum install -y nano unzip xkill firefox tigervnc-server xorg-x11-server-Xorg gdm xorg-x11-fonts-* libXtst-devel-*
clear
echo ""
echo "Enter a password for VNC"
vncserver && vncserver -kill :1
sed -i 's/twm/startxfce4/g' ~/.vnc/xstartup
clear
vncserver
echo ""
echo "you may now connect to the vncserver at  $IP:1 or $IP:5901"
mkdir -p ~/jagexcache/runescape/LIVE
rm -rf *.rpm
#
####################
#   END OF CENTOS  #
####################
#
fi
############################
# Beginning of Ubuntu code #
############################
#
if [[ "$OS" = "2" ]]
then
sudo apt-get update -y
sudo apt-get purge openjdk*
sudo apt-get install python-software-properties vnc4server xfce4 unzip firefox -y
###### Installing Java with the following Method ########
### http://www.webupd8.org/2012/01/install-oracle-java-jdk-7-in-ubuntu-via.html ##
#
sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install oracle-java7-installer -y
clear
echo ""
echo "Enter a password for VNC"
vncserver && vncserver -kill :1
sed -i 's/x-window-manager/startxfce4/g' ~/.vnc/xstartup
mkdir -p ~/jagexcache/runescape/LIVE
vncserver
clear
echo ""
echo "you may now connect to the vncserver at  $IP:1 or $IP:5901"
echo ""
echo "if asked click use default config"
echo ""
fi
#!/bin/sh

# EasySCP a Virtual Hosting Control Panel
# Copyright (C) 2010-2014 by Easy Server Control Panel - http://www.easyscp.net
#
# This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
# To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
#
# @link 		http://www.easyscp.net
# @author 		EasySCP Team

#
# find distro routine
#
fn_distro() {
arch=$(uname -m)
kernel=$(uname -r)
if [ -f /etc/lsb-release ]; then
        os=$(lsb_release -s -d)
        distro=$(lsb_release -s -i)
        distrolc=$(lsb_release -s -i | tr "[:upper:]" "[:lower:]")
        codename=$(lsb_release -s -r | tr -d '.')
        preinst="docs/$distro/$distrolc-packages-$codename"
        preinstcmd="cat $preinst | xargs aptitude -y install"
elif [ -f /etc/debian_version ]; then
        os="Debian $(cat /etc/debian_version)"
        distro=$(lsb_release -s -i)
        distrolc=$(lsb_release -s -i | tr "[:upper:]" "[:lower:]")
        codename=$(lsb_release -s -c)
        preinst="docs/$distro/$distrolc-packages-$codename"
        preinstcmd="cat $preinst | xargs aptitude -y install"
elif [ -f /etc/redhat-release ]; then
        os=`cat /etc/redhat-release`
        distro=$(echo $os| awk {'print $1'})
        distrolc=$(echo $os| awk {'print $1'} | tr "[:upper:]" "[:lower:]")
        preinst="docs/$distro/$distrolc-packages"
        preinstcmd="are listed in the file $preinst"
else
        os="$(uname -s) $(uname -r)"
        distro=$(echo $os| awk {'print $1'})
        preinst=""
        echo >&2 "Your $distro is not apt/yum based please consult the docs..."
fi
}



#
# If the command make does not exist, assume nothing is preinstalled
#
Preinstalled=make
command -v $Preinstalled >/dev/null 2>&1 || { 
	fn_distro;
	echo >&2 "I require at least $Preinstalled but it's not installed. Please check preinstallation requirements in the docs. E.g. for $distro: ./docs/$distro/INSTALL";
	echo >&2 "Aborting.";
	if [ "$preinst" != "" ] && [ -f $preinst ]; then echo "Required packages"; echo $preinstcmd; fi
	exit 1;
	}

fn_distro

#
# Determine php5-cli php.ini location
#
phpini=$(php -i | grep php.ini$ | awk -F' => ' {' print $2 '})

Auswahl=""
OS=""

clear

echo "We detected your OS as $distro"
echo ""
echo "1 = CentOS"
echo ""
echo "2 = Debian"
echo ""
echo "3 = OpenSuse"
echo ""
echo "4 = Oracle Linux"
echo ""
echo "5 = Ubuntu"
echo ""

while :
do
    read -p "Please select your distribution: " Name

    if [ "$Name" = "1" ] || [ "$Name" = "CentOS" ]; then
        Auswahl="CentOS"
    fi

    if [ "$Name" = "2" ] || [ "$Name" = "Debian" ]; then
        Auswahl="Debian"
    fi

    if [ "$Name" = "3" ] || [ "$Name" = "OpenSuse" ]; then
        Auswahl="OpenSuse"
    fi

    if [ "$Name" = "4" ] || [ "$Name" = "Oracle Linux" ]; then
        Auswahl="Oracle"
    fi

    if [ "$Name" = "5" ] || [ "$Name" = "Ubuntu" ]; then
        Auswahl="Ubuntu"
    fi

	case "$Auswahl" in
		CentOS)
			echo "Using CentOS. Please wait."

			echo "Build the Software"
			cd $(dirname $0)"/"
			make -f Makefile.$Auswahl install > /dev/null

			echo "Copy required files to your system"
			cp -RLf /tmp/easyscp/* / > /dev/null

			if [ ! -f /etc/easyscp/EasySCP_Config.xml ]; then
				cp /etc/easyscp/tpl/EasySCP_Config.xml /etc/easyscp/EasySCP_Config.xml
			fi

			while :
			do
				read -p "Secure your mysql installation [Y/N]?" MySQL
				case "$MySQL" in
					[JjYy])
						#echo "ja"
						mysql_secure_installation
						break
						;;
					[Nn])
						#echo "nein"
						break
						;;
					*)
						echo "Wrong selection"

						;;
				esac
			done

			echo "Clean the temporary folders"
			# rm -fR /tmp/easyscp/

			echo "Prepare system config"

			TIMEZONE=`cat /etc/sysconfig/clock | sed "s/^[^\"]*\"//" | sed  "s/\".*//"`
			echo $TIMEZONE > /etc/timezone
			TIMEZONE=$(cat /etc/timezone | sed "s/\//\\\\\//g")
			sed -i".bak" "s/^\;date\.timezone.*$/date\.timezone = \"${TIMEZONE}\" /g" $phpini
			# TIMEZONE=$((cat /etc/sysconfig/clock) | sed 's/^[^"]*"//' | sed  's/".*//')
			# sed -i".bak" "s/^\;date\.timezone.*$/date\.timezone = \"${TIMEZONE}\" /g" $phpini

			#touch /var/log/rkhunter.log
			#chmod 644 /var/log/rkhunter.log

			chmod 0700 -R /var/www/easyscp/daemon/

			chmod 0777 /var/www/setup/theme/templates_c/
			chmod 0777 /var/www/setup/config.xml

			chcon --reference /etc/httpd/conf.d /etc/httpd/vhost.d
			if [ ! -f /etc/httpd/conf.d/vhost.conf ]; then
				echo "Include vhost.d/*.conf" >>/etc/httpd/conf.d/vhost.conf
   			fi
			chcon --reference /etc/httpd/conf.d/README /etc/httpd/conf.d/vhost.conf

			while :
			do
				read -p "Configure iptables [Y/N]? (if unsure, select yes)" IPTables
				case "$IPTables" in
					[JjYy])
						#echo "ja"
						iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited
						iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
						iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
						break
						;;
					[Nn])
						#echo "nein"
						break
						;;
					*)
						echo "Wrong selection"

						;;
				esac
			done

			service httpd restart
			# /etc/init.d/httpd restart

			echo "Starting EasySCP Controller"
			/etc/init.d/easyscp_control start > /dev/null

			echo "Starting EasySCP Daemon"
			/etc/init.d/easyscp_daemon start > /dev/null

			echo ""
			echo "To finish Setup, please enter 'http://YOUR_DOMAIN/setup' into your Browser"

			break
			;;
		Debian|Ubuntu)
			echo "Using $Auswahl. Please wait."

			echo "Build the Software"
			cd $(dirname $0)"/"
			make -f Makefile.$Auswahl install > /dev/null

			echo "Copy required files to your system"
			cp -R /tmp/easyscp/* / > /dev/null

			if [ ! -f /etc/easyscp/EasySCP_Config.xml ]; then
				cp /etc/easyscp/tpl/EasySCP_Config.xml /etc/easyscp/EasySCP_Config.xml
			fi

			while :
			do
				read -p "Secure your mysql installation [Y/N]?" MySQL
				case "$MySQL" in
					[JjYy])
						#echo "ja"
						mysql_secure_installation
						break
						;;
					[Nn])
						#echo "nein"
						break
						;;
					*)
						echo "Wrong selection"

						;;
				esac
			done

			echo "Clean the temporary folders"
			rm -fR /tmp/easyscp/

			echo "Prepare system config"

			TIMEZONE=$(cat /etc/timezone | sed "s/\//\\\\\//g")
			sed -i".bak" "s/^\;date\.timezone.*$/date\.timezone = \"${TIMEZONE}\" /g" $phpini

			touch /var/log/rkhunter.log
			chmod 644 /var/log/rkhunter.log

			chmod 0700 -R /var/www/easyscp/daemon/

			chmod 0777 /var/www/setup/theme/templates_c/
			chmod 0777 /var/www/setup/config.xml

			# Checking for bind9 and remove them if needed
			echo "Checking for Bind9"
			if [ -f /etc/init.d/bind9 ]; then
				yes|apt-get remove bind9
			fi

			# Remove all old apache vhost/site configs
			rm /etc/apache2/sites-enabled/* > /dev/null
			# a2dissite default > /dev/null
			a2ensite easyscp-setup.conf > /dev/null
			/etc/init.d/apache2 restart

			echo "Starting EasySCP Controller"
			/etc/init.d/easyscp_control start > /dev/null

			echo "Starting EasySCP Daemon"
			/etc/init.d/easyscp_daemon start > /dev/null

			echo ""
			echo "To finish Setup, please enter 'http://YOUR_DOMAIN/setup' into your Browser"

			break
			;;
		OpenSuse)
			# echo "Using OpenSuse. Please wait."
			echo "Easy Setup currently does not support OpenSuse."
			# break
			;;
		Oracle)
			echo "Using Oracle Linux. Please wait."

			echo "Build the Software"
			cd $(dirname $0)"/"
			make -f Makefile.$Auswahl install > /dev/null

			echo "Copy required files to your system"
			cp -RLf /tmp/easyscp/* / > /dev/null

			if [ ! -f /etc/easyscp/EasySCP_Config.xml ]; then
				cp /etc/easyscp/tpl/EasySCP_Config.xml /etc/easyscp/EasySCP_Config.xml
			fi

			while :
			do
				read -p "Secure your mysql installation [Y/N]?" MySQL
				case "$MySQL" in
					[JjYy])
						#echo "ja"
						mysql_secure_installation
						break
						;;
					[Nn])
						#echo "nein"
						break
						;;
					*)
						echo "Wrong selection"

						;;
				esac
			done

			echo "Clean the temporary folders"
			# rm -fR /tmp/easyscp/

			echo "Prepare system config"

			TIMEZONE=`cat /etc/sysconfig/clock | sed "s/^[^\"]*\"//" | sed  "s/\".*//"`
			echo $TIMEZONE > /etc/timezone
			TIMEZONE=$(cat /etc/timezone | sed "s/\//\\\\\//g")
			sed -i".bak" "s/^\;date\.timezone.*$/date\.timezone = \"${TIMEZONE}\" /g" $phpini
			# TIMEZONE=$((cat /etc/sysconfig/clock) | sed 's/^[^"]*"//' | sed  's/".*//')
			# sed -i".bak" "s/^\;date\.timezone.*$/date\.timezone = \"${TIMEZONE}\" /g" $phpini

			#touch /var/log/rkhunter.log
			#chmod 644 /var/log/rkhunter.log

			chmod 0700 -R /var/www/easyscp/daemon/

			chmod 0777 /var/www/setup/theme/templates_c/
			chmod 0777 /var/www/setup/config.xml

			chcon --reference /etc/httpd/conf.d /etc/httpd/vhost.d
			if [ ! -f /etc/httpd/conf.d/vhost.conf ]; then
				echo "Include vhost.d/*.conf" >>/etc/httpd/conf.d/vhost.conf
   			fi
			chcon --reference /etc/httpd/conf.d/README /etc/httpd/conf.d/vhost.conf

			while :
			do
				read -p "Configure iptables [Y/N]? (if unsure, select no)" IPTables
				case "$IPTables" in
					[JjYy])
						#echo "ja"
						iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited
						iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
						iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
						break
						;;
					[Nn])
						#echo "nein"
						break
						;;
					*)
						echo "Wrong selection"

						;;
				esac
			done

			service httpd restart
			# /etc/init.d/httpd restart

			echo "Starting EasySCP Controller"
			/etc/init.d/easyscp_control start > /dev/null

			echo "Starting EasySCP Daemon"
			/etc/init.d/easyscp_daemon start > /dev/null

			echo ""
			echo "To finish Setup, please enter 'http://YOUR_DOMAIN/setup' into your Browser"

			break
			;;
		*)
			echo "Please type a number or the name of your distribution!"
			#Wenn vorher nichts passte
			;;
	esac
done

exit 0

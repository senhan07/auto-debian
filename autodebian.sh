#!/bin/bash
tput smcup
echo "0" > /root/.ignore
red="\033[00;31m"
green="\033[00;32m"
none="\033[0m"
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
if [ $(whoami) == "root" ];
then
while :
do
	clear
if dpkg-query -W -f '${db:Status-Abbrev}\n' bind9 2>/dev/null | grep -q '^.i $';
then
	pkgbind=$'\e[32mInstalled\e[0m    '
else
	pkgbind=$'\e[31mNot Installed\e[0m'
fi
if dpkg-query -W -f '${db:Status-Abbrev}\n' apache2 php5 2>/dev/null | grep -q '^.i $';
then
	pkgweb=$'\e[32mInstalled\e[0m    '
else
	pkgweb=$'\e[31mNot Installed\e[0m'
fi
if dpkg-query -W -f '${db:Status-Abbrev}\n' proftpd-* 2>/dev/null | grep -q '^.i $';
then
	pkgftp=$'\e[32mInstalled\e[0m    '
else
	pkgftp=$'\e[31mNot Installed\e[0m'
fi
if dpkg-query -W -f '${db:Status-Abbrev}\n' postfix dovecot-imapd dovecot-pop3d squirrelmail 2>/dev/null | grep -q '^.i $';
then
	pkgmail=$'\e[32mInstalled\e[0m    '
else
	pkgmail=$'\e[31mNot Installed\e[0m'
fi
mountloc="/mnt/usb"
if grep -qs "$mountloc" /proc/mounts;
then
	mountstat=$'\e[32mMounted\e[0m    '
else
	mountstat=$'\e[31mNot Mounted\e[0m'
fi
if grep -q 1 "/root/.ignore";
then
	ignore=$'\e[32mEnable\e[0m'
else
	ignore=$'\e[31mDisable\e[0m'
fi
	cat<<EOF

   -----------------------------------------------------------------------------------------------
  |                             Auto Debian - Automatic Configuration                             |
  |                                          by senhan07                                          |
  |                                         Version 4.4.1                                         |
   -----------------------------------------------------------------------------------------------

EOF
ipaddress(){
	hostname -i
	}
load(){
	 uptime |rev | cut -d: -f1 |rev
	}
phymem(){
	free -m| awk '/^Mem:/{print $2}'
	}
freemem(){
	free -m| awk '/^Mem:/{print $3}'
	}
swap(){
	free -m| awk '/^Swap:/{print $2}'
	}
freeswap(){
	free -m| awk '/^Swap:/{print $3}'
	}
kernel(){
	uname -a | awk '{print $3}'
	}
user(){
	whoami
	}
host(){
	hostname
	}
os(){
	cat /etc/os-release | grep PRETTY_NAME | rev | cut -c 2- | rev | cut -c 14-
}
up(){
	uptime | awk -F'( |,|:)+' '{d=h=m=0; if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes"}'
}
check(){
	cat /root/.ignore
}
gateway(){
	cat /etc/network/interfaces | grep gateway | awk '{print $2}'
}
if [[ -z $(gateway) ]];
then
	gateway="127.0.0.1"
	gatewaylocal="localhost"
else
	gateway="$(gateway)"
	gatewayip="$(gateway)"
fi
ping-gt(){
	ping -c 1 $gateway | grep time= | awk '{print $7}' | cut -c 6-
}
echo -e "  1) USB Repository            $mountstat              ${red}Login as${none}   : ${green}$(user)${none}@${green}$(host)${none}"
echo -e "                                                        ${red}OS${none}         : $(os)"
echo -e "  2) DNS Server                $pkgbind            ${red}Kernel${none}     : $(kernel)"
echo -e "                                                        ${red}Uptime${none}     : $(up)"
echo -e "  3) Web Server                $pkgweb            ${red}Load Avg${none}   :$(load)"
echo -e "                                                        ${red}Memory${none}     : $(freemem)MiB / $(phymem)MiB"
echo -e "  4) FTP Server                $pkgftp            ${red}Swap${none}       : $(freeswap)MiB / $(swap)MiB"
echo -e "                                                        ${red}IP Address${none} : $(ipaddress)"
echo -e "  5) Mail Server               $pkgmail            ${red}Gateway${none}    : ${gatewayip}${gatewaylocal} ($(ping-gt)ms) "
echo " "
echo -e "  i) Ignore USB Repository     ${ignore}"
echo ""
echo ""
echo "  Q)uit"
echo ""

	read -n1 -p $'  \e[5m\e[31mChoose:\e[0m ' -t 3
	case "$REPLY" in
	"1") while :
		do
		clear

echo ""
echo -e "  USB OPTIONS - Mount Point ${red}/mnt/usb${none}"
		cat<<EOF
  ----------------------------------

  1) Mount USB + Add Repository
  2) Eject USB + Remove Repository

  r) Return to Main Menu
  Q) Quit

EOF
		read -n1 -p $'  \e[5m\e[31mChoose:\e[0m '
		case "$REPLY" in
			"1") if grep -qs "$mountloc" /proc/mounts;
				then
					clear
					echo ""
					echo -e "  Already ${red}Mounted${none}, Exiting"
					echo ""
					sleep 0.200
					clear
					echo ""
					echo -e "  Already ${red}Mounted${none}, Exiting."
					echo ""
					sleep 0.200
					clear
					echo ""
					echo -e "  Already ${red}Mounted${none}, Exiting.."
					echo ""
					sleep 0.200
					clear
					echo ""
					echo -e "  Already ${red}Mounted${none}, Exiting..."
					echo ""
					sleep 0.50
					break
				else
				clear
				echo ""
				echo "  DETECTING, PLEASE WAIT"
				echo "  -----------------------------------------------"
				echo ""
				clear
				sleep 0.200
				echo ""
				echo "  DETECTING, PLEASE WAIT."
				echo "  -----------------------------------------------"
				echo ""
				sleep 0.300
				clear
				echo ""
				echo "  DETECTING, PLEASE WAIT.."
				echo "  -----------------------------------------------"
				echo ""
				sleep 0.300
				clear
				echo ""
				echo "  DETECTING, PLEASE WAIT..."
				echo "  -----------------------------------------------"
				echo ""
				sleep 0.300
				clear
				echo ""
				echo "  DETECTING, PLEASE WAIT...."
				echo "  -----------------------------------------------"
				echo ""
				sleep 0.300
				clear
				echo ""
				echo "  DETECTING, PLEASE WAIT....."
				echo "  -----------------------------------------------"
				echo ""
				sleep 0.300
				clear
				lsblk
				echo ""
				echo "-----------------------------------------------"
				read -p $'  Enter the Drive Name (ex. \e[5m\e[31msdb1\e[0m): ' mount
				if [[ $mount =~ ^[s][d][b-z][1-9]{1,1}$ ]];then
					mount="$mount"
				clear
				echo ""
				echo "  -----------------------------------------------"
				echo "  MOUNTING, PLEASE WAIT"
				echo "  -----------------------------------------------"
				else
					echo ""
					echo -e "  ${red}Invalid Drive Name${none}"
					sleep 1
					break
				fi
				mkdir -p /mnt/usb /mnt/disk1 /mnt/disk2 /mnt/disk3
 				mount -rw /dev/$mount /mnt/usb
 				mount -o loop /mnt/usb/*1.iso /mnt/disk1
 				mount -o loop /mnt/usb/*2.iso /mnt/disk2
 				mount -o loop /mnt/usb/*3.iso /mnt/disk3
 				echo "
deb [trusted=yes] file:///mnt/usb wheezy main contrib
deb [trusted=yes] file:///mnt/disk1 wheezy main contrib
deb [trusted=yes] file:///mnt/disk2 wheezy main contrib
deb [trusted=yes] file:///mnt/disk3 wheezy main contrib" > /etc/apt/sources.list
				apt-get update
				break
			fi;;

			"2") if grep -qs "$mountloc" /proc/mounts;
				then
				 clear
				 umount /mnt/disk1
 				 umount /mnt/disk2
 				 umount /mnt/disk3
 				 umount /mnt/usb
 				 echo "" > /etc/apt/sources.list
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT"
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT."
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT.."
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT..."
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT...."
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT....."
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo "  EJECTING, PLEASE WAIT......"
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 else
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting'
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting.'
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting..'
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting...'
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting....'
				 echo "  -----------------------------------------------"
				 sleep 0.200
				 clear
				 echo ""
				 echo "  -----------------------------------------------"
				 echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting.....'
				 echo "  -----------------------------------------------"
				 sleep 1
				 break
				 fi;;

			"q") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"Q") clear
				 exit;;
			"r") clear
				 break;;
			"R") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			esac
			sleep 1
		done;;



	"2") while :
		do
		clear
		cat<<EOF

  DOMAIN NAME SERVER (DNS)
  ----------------------------------

  1) Install + Configure Bind9
  2) Add Subdomain

  U) Uninstall Bind9

  r) Return to Main Menu
  Q) Quit

EOF
		read -n1 -p $'  \e[5m\e[31mChoose:\e[0m '
		case "$REPLY" in
			"1") if grep -qs "$mountloc" /proc/mounts || grep -q 1 "/root/.ignore";
				then
				clear
				apt-get install bind9 -y --force-yes
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - SETUP"
				echo "  -----------------------------------------------------------"
				read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' binddns
				if [[ $binddns =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					binddns="$binddns"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - SETUP"
				echo "  -----------------------------------------------------------"
				read -p $'  Enter the \e[31mFIRST\e[0m IP Address (ex. \e[5m\e[31m192\e[0m\e[2m.168.10.1\e[0m): ' ip1
				if [[ $ip1 =~ ^[0-9]{1,3}$ ]];then
					ip1="$ip1"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - SETUP"
				echo "  -----------------------------------------------------------"
				read -p $'  Enter the \e[31mSECOND\e[0m IP Address (ex. \e[2m192.\e[0m\e[31m\e[5m168\e[0m\e[2m.10.1\e[0m): ' ip2
				if [[ $ip2 =~ ^[0-9]{1,3}$ ]];then
					ip2="$ip2"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - SETUP"
				echo "  -----------------------------------------------------------"
				read -p $'  Enter the \e[31mTHIRD\e[0m IP Address (ex. \e[2m192.168.\e[0m\e[5m\e[31m10\e[0m\e[2m.1\e[0m): ' ip3
				if [[ $ip3 =~ ^[0-9]{1,3}$ ]];then
					ip3="$ip3"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - SETUP"
				echo "  -----------------------------------------------------------"
				read -p $'  Enter the \e[31mFOURTH\e[0m IP Address (ex. \e[2m192.168.10.\e[0m\e[31m\e[5m1\e[0m): ' ip4
				if [[ $ip4 =~ ^[0-9]{1,3}$ ]];then
					ip4="$ip4"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				clear
				while :
				do
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - OVERVIEW"
				echo "  -----------------------------------------------------------"
				echo -e "  Domain             : ${red} $binddns ${none}"
				echo -e "  IP Address         : ${red} $ip1.$ip2.$ip3.$ip4 ${none}"
				echo "  -----------------------------------------------------------"
				echo ""
				read -n1 -p $'  Is this correct? [\e[5m\e[31my\e[0m/n]: '
				case "$REPLY" in
					"y") echo ";
; BIND data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     $binddns. root.$binddns. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      $binddns.
@       IN      A       $ip1.$ip2.$ip3.$ip4
@       IN      AAAA    ::1
" > /etc/bind/db.local

echo ";
; BIND reverse data file for local loopback interface
;
\$TTL    604800
@       IN      SOA     $binddns. root.$binddns. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      $binddns.
$ip4       IN      PTR     $binddns.
" > /etc/bind/db.127

double='"'
      echo "zone ${double}${binddns}${double}{
      type master;
      file ${double}/etc/bind/db.local${double};
      };
zone ${double}$ip3.$ip2.$ip1.in-addr.arpa${double}{
      type master;
      file ${double}/etc/bind/db.127${double};
      };" > /etc/bind/named.conf.local
	  echo "domain $binddns
search $binddns
nameserver $ip1.$ip2.$ip3.$ip4
nameserver 1.1.1.1
nameserver 1.0.0.1" > /etc/resolv.conf
		clear
      /etc/init.d/bind9 restart
      /etc/init.d/bind9 status
	  nslookup $binddns
	  nslookup $ip1.$ip2.$ip3.$ip4
	  sleep 1
	  break;;
					"n") break;;
					esac
					sleep 1
				done
				else
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting...'
					sleep 1
					break
				fi;;



			"U") if [ $(dpkg-query -W -f='${Status}' bind9 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
					clear
					apt-get purge bind9 -y
					apt-get autoremove -y
				 fi;;

			"2")if [ $(dpkg-query -W -f='${Status}' bind9 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Bind9 \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				else
				clear
				echo ""
				echo "  DOMAIN NAME SERVER (DNS) - ADD SUBDOMAINS"
				echo "  -----------------------------------------------------------"
				 read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' binddns
				 if [[ $binddns =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					binddns="$binddns"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
				 clear
				 echo ""
				 echo "  DOMAIN NAME SERVER (DNS) - ADD SUBDOMAINS"
				 echo "  -----------------------------------------------------------"
				 read -p $'  Enter the \e[31mFIRST\e[0m IP Address (ex. \e[5m\e[31m192\e[0m\e[2m.168.10.1\e[0m): ' ip1
				 if [[ $ip1 =~ ^[0-9]{1,3}$ ]];then
					ip1="$ip1"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				clear
				 echo ""
				 echo "  DOMAIN NAME SERVER (DNS) - ADD SUBDOMAINS"
				 echo "  -----------------------------------------------------------"
				 read -p $'  Enter the \e[31mSECOND\e[0m IP Address (ex. \e[2m192.\e[0m\e[31m\e[5m168\e[0m\e[2m.10.1\e[0m): ' ip2
				 if [[ $ip2 =~ ^[0-9]{1,3}$ ]];then
					ip2="$ip2"
				 else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				 fi
				 clear
				 echo ""
				 echo "  DOMAIN NAME SERVER (DNS) - ADD SUBDOMAINS"
				 echo "  -----------------------------------------------------------"
				 read -p $'  Enter the \e[31mTHIRD\e[0m IP Address (ex. \e[2m192.168.\e[0m\e[5m\e[31m10\e[0m\e[2m.1\e[0m): ' ip3
				 if [[ $ip3 =~ ^[0-9]{1,3}$ ]];then
					ip3="$ip3"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				 clear
				 echo ""
				 echo "  DOMAIN NAME SERVER (DNS) - ADD SUBDOMAINS"
				 echo "  -----------------------------------------------------------"
				 read -p $'  Enter the \e[31mFOURTH\e[0m IP Address (ex. \e[2m192.168.10.\e[0m\e[31m\e[5m1\e[0m): ' ip4
				 if [[ $ip4 =~ ^[0-9]{1,3}$ ]];then
					ip4="$ip4"
				else
					echo ""
					echo -e "  ${red}Invalid IP Address${none}"
					sleep 1
					break
				fi
				 clear
				 echo ""
				 echo "  DOMAIN NAME SERVER (DNS) - ADD SUBDOMAINS"
				 echo "  -----------------------------------------------------------"
				 read -p $'  Enter the Subdomains Names (ex. \e[5m\e[31mftp\e[0m or \e[5m\e[31mwww\e[0m): ' bindsub
				 clear
				 while :
				 do
				 clear
				 echo ""
				 echo "  DOMAIN NAME SERVER (DNS) - OVERVIEW"
				 echo "  -----------------------------------------------------------"
				 echo -e "  Domain             : ${red} $bindsub.$binddns ${none}"
				 echo -e "  IP Address         : ${red} $ip1.$ip2.$ip3.$ip4 ${none}"
				 echo "  -----------------------------------------------------------"
				 echo ""
				 read -n1 -p $'  Is this correct? [\e[5m\e[31my\e[0m/n]: '
				 case "$REPLY" in
				 	"y") clear
						 echo "$bindsub       IN      A       $ip1.$ip2.$ip3.$ip4" >> /etc/bind/db.local
						 echo "$ip4       IN      PTR       $bindsub.$binddns." >> /etc/bind/db.127
						 /etc/init.d/bind9 restart
						 nslookup $bindsub.$binddns
						 nslookup $ip1.$ip2.$ip3.$ip4
						 sleep 1
						 break;;
				 	"n") break;;
				 	esac
				 	sleep 1
				 done
				 fi;;

			"q") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"Q") clear
				 exit;;
			"r") clear
				 break;;
			"u") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"R") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			esac
			sleep 0
		done;;



	"3")while :
		do
		clear
		cat<<EOF

  WEB SERVER - Access with http://your-domain.com
  --------------------------------------------------------------------

  1) Install Apache2
EOF
echo    $'  2) Enable SSL Support ( \e[32mHTTPS://\e[0myour-domain.com )'
cat<<EOF
  3) Redirect Options

  U) Uninstall Apache2

  r) Return to Main Menu
  Q) Quit

EOF

		read -n1 -p $'  \e[5m\e[31mChoose:\e[0m '
		case "$REPLY" in
			"1") if grep -qs "$mountloc" /proc/mounts || grep -q 1 "/root/.ignore";
				then
				 clear
				 apt-get install apache2 apache2.2-common php5 libapache2-mod-php5 -y --force-yes
				 /etc/init.d/apache2 status
				 else
				 	clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting...'
					sleep 1
					break
					fi;;
			"U") if [ $(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
				 clear
				 apt-get purge apache* -y
				 apt-get purge php5 -y
				 rm -r /etc/apache2
				 fi;;
			"2") if [ $(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
				 clear
				 a2enmod ssl
				 mkdir -p /etc/apache2/ssl
				 mkdir -p /var/ftp
				 clear
				 echo ""
				 echo "  SSL CERTIFICATE - SETUP"
				echo "  -----------------------------------------------------------"
				read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' apachedns
				if [[ $apachedns =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					binddns="$binddns"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
				 echo "
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no
[req_distinguished_name]
C = ID
ST = VA
L = Surabaya
O = Debian
OU = Debian Server
CN = $apachedns
[v3_req]
keyUsage = critical, digitalSignature, keyAgreement
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = $apachedns
DNS.2 = www.$apachedns
DNS.3 = *.$apachedns" > /etc/apache2/req.cnf
				 clear
				 openssl req -x509 -nodes -days 1 -newkey rsa:2048 -keyout /etc/apache2/ssl/ca.key -out /etc/apache2/ssl/ca.pem -config /etc/apache2/req.cnf -sha256
				 openssl x509 -outform der -in /etc/apache2/ssl/ca.pem -out /var/ftp/SSL-CERTIFICATE.crt
				 backslash='\'
				 open='('
				 close=')'
				 file='cgi|shtml|phtml|php'
				 echo "
<IfModule mod_ssl.c>
<VirtualHost _default_:443>
	ServerAdmin webmaster@localhost

	DocumentRoot /var/www
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /var/www/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog \${APACHE_LOG_DIR}/error.log

	LogLevel warn

	CustomLog \${APACHE_LOG_DIR}/ssl_access.log combined

	SSLEngine on

	SSLCertificateFile    /etc/apache2/ssl/ca.pem
	SSLCertificateKeyFile /etc/apache2/ssl/ca.key

	<FilesMatch ${double}$backslash.$open$file$close\$${double}>
		SSLOptions +StdEnvVars
	</FilesMatch>
	<Directory /usr/lib/cgi-bin>
		SSLOptions +StdEnvVars
	</Directory>

</VirtualHost>
</IfModule>
" > /etc/apache2/sites-available/default-ssl
			a2ensite default-ssl
			/etc/init.d/apache2 restart
			fi;;
			"3") if [ $(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Apache2 \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
			while :
		do
		clear
		cat<<EOF

  WEB SERVER - REDIRECT OPTIONS
  --------------------------------------------------------------------

  1) Redirect FTP Only
  2) Redirect HTTP Only
  3) Redirect FTP + HTTP

  r) Return to Main Menu
  Q) Quit

EOF
				read -n1 -p $'  \e[5m\e[31mChoose:\e[0m '
				case "$REPLY" in
			"1") a2enmod rewrite
				 clear
				 echo ""
				 echo "  WEB SERVER - REDIRECT FTP"
				 echo "  -----------------------------------------------------------"
				  read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' apachedns
				  if [[ $apachedns =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					apachedns="$apachedns"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
				  echo "
<VirtualHost *:80>
	ServerAdmin webmaster@localhost

	DocumentRoot /var/www
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /var/www/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog \${APACHE_LOG_DIR}/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog \${APACHE_LOG_DIR}/access.log combined

RewriteEngine on
ServerName $apachedns
RewriteCond %{SERVER_NAME} =ftp.$apachedns
RewriteRule ^ ftp://%{SERVER_NAME}%{REQUEST_URI}
</VirtualHost>
" > /etc/apache2/sites-enabled/000-default
				  clear
				  /etc/init.d/apache2 restart
					break;;
			"2") a2enmod rewrite
				 clear
				 echo ""
				 echo "  WEB SERVER - REDIRECT HTTP"
				 echo "  -----------------------------------------------------------"
				  read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' apachedns
				  if [[ $apachedns =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					apachedns="$apachedns"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
				  echo "
<VirtualHost *:80>
	ServerAdmin webmaster@localhost

	DocumentRoot /var/www
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /var/www/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog \${APACHE_LOG_DIR}/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog \${APACHE_LOG_DIR}/access.log combined

RewriteEngine on
ServerName $apachedns
RewriteCond %{SERVER_NAME} =$apachedns
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI}
</VirtualHost>
" > /etc/apache2/sites-enabled/000-default
				  clear
				  /etc/init.d/apache2 restart
					break;;
			"3") a2enmod rewrite
				 clear
				 echo ""
				 echo "  WEB SERVER - REDIRECT FTP + HTTP"
				 echo "  -----------------------------------------------------------"
				  read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' apachedns
				  if [[ $apachedns =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					apachedns="$apachedns"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
				  echo "
<VirtualHost *:80>
	ServerAdmin webmaster@localhost

	DocumentRoot /var/www
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory /var/www/>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	</Directory>

	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
	<Directory "/usr/lib/cgi-bin">
		AllowOverride None
		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
		Order allow,deny
		Allow from all
	</Directory>

	ErrorLog \${APACHE_LOG_DIR}/error.log

	# Possible values include: debug, info, notice, warn, error, crit,
	# alert, emerg.
	LogLevel warn

	CustomLog \${APACHE_LOG_DIR}/access.log combined

RewriteEngine on
ServerName $apachedns
RewriteCond %{SERVER_NAME} =ftp.$apachedns
RewriteRule ^ ftp://%{SERVER_NAME}%{REQUEST_URI}
RewriteCond %{SERVER_NAME} =$apachedns
RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI}
</VirtualHost>
" > /etc/apache2/sites-enabled/000-default
				  clear
				  /etc/init.d/apache2 restart
					break;;

			"q") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"Q") clear
				 exit;;
			"r") clear
				 break;;
			"u") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"R") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			esac
			sleep 0.050
		done
		fi;;

		"q") echo $' \e[7mCASE SENSITIVE\e[0m'
			sleep 1;;
			"Q") clear
				 exit;;
			"r") clear
				 break;;
			"u") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"R") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
		esac
		sleep 0.050
	done;;


	"4") while :
		do
		clear
		cat<<EOF

  FTP Server - Access with ftp://your-domain.com
  --------------------------------------------------------------------

  1) Install Proftpd

  U) Uninstall Proftpd

  r) Return to Main Menu
  Q) Quit

EOF
		read -n1 -p $'  \e[5m\e[31mChoose:\e[0m '
		case "$REPLY" in
			"1") if grep -qs "$mountloc" /proc/mounts || grep -q 1 "/root/.ignore";
				then
				 clear
				 mkdir -p /var/ftp
				 fallocate -l 50M /var/ftp/dummy.file
				 apt-get install proftpd -y --force-yes
				 chown ftp:nogroup /var/ftp
				 clear
				 echo ""
				 echo "  FILE TRANSFER PROTOCOL (FTP) - SETUP"
				 echo "  -----------------------------------------------------------"
				 read -p $'  Enter the Domain Names (ex. \e[5m\e[31mdomain.com\e[0m): ' ftpname
				 if [[ $ftpname =~ ^([a-zA-Z0-9](([a-zA-Z0-9-]){0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]];then
					ftpname="$ftpname"
				else
					echo ""
					echo -e "  ${red}Invalid Domain Name${none}"
					sleep 1
					break
				fi
		echo "
#
# /etc/proftpd/proftpd.conf -- This is a basic ProFTPD configuration file.
# To really apply changes, reload proftpd after modifications, if
# it runs in daemon mode. It is not required in inetd/xinetd mode.
#

# Includes DSO modules
Include /etc/proftpd/modules.conf

# Set off to disable IPv6 support which is annoying on IPv4 only boxes.
UseIPv6                         on
# If set on you can experience a longer connection delay in many cases.
IdentLookups                    off

ServerName                      ${double}$ftpname${double}
ServerType                      standalone
DeferWelcome                    off

MultilineRFC2228                on
DefaultServer                   on
ShowSymlinks                    on

TimeoutNoTransfer               600
TimeoutStalled                  600
TimeoutIdle                     1200

DisplayLogin                    welcome.msg
DisplayChdir                    .message true
ListOptions                     "-l"

DenyFilter                      \*.*/

# Use this to jail all users in their homes
# DefaultRoot                   ~

# Users require a valid shell listed in /etc/shells to login.
# Use this directive to release that constrain.
# RequireValidShell             off

# Port 21 is the standard FTP port.
Port                            21

# In some cases you have to specify passive ports range to by-pass
# firewall limitations. Ephemeral ports can be used for that, but
# feel free to use a more narrow range.
# PassivePorts                  49152 65534

# If your host was NATted, this option is useful in order to
# allow passive tranfers to work. You have to use your public
# address and opening the passive ports used on your firewall as well.
# MasqueradeAddress             1.2.3.4

# This is useful for masquerading address with dynamic IPs:
# refresh any configured MasqueradeAddress directives every 8 hours
<IfModule mod_dynmasq.c>
# DynMasqRefresh 28800
</IfModule>

# To prevent DoS attacks, set the maximum number of child processes
# to 30.  If you need to allow more than 30 concurrent connections
# at once, simply increase this value.  Note that this ONLY works
# in standalone mode, in inetd mode you should use an inetd server
# that allows you to limit maximum number of processes per service
# (such as xinetd)
MaxInstances                    30

# Set the user and group that the server normally runs at.
User                            proftpd
Group                           nogroup

# Umask 022 is a good standard umask to prevent new files and dirs
# (second parm) from being group and world writable.
Umask                           022  022
# Normally, we want files to be overwriteable.
AllowOverwrite                  on

# Uncomment this if you are using NIS or LDAP via NSS to retrieve passwords:
# PersistentPasswd              off

# This is required to use both PAM-based authentication and local passwords
# AuthOrder                     mod_auth_pam.c* mod_auth_unix.c

# Be warned: use of this directive impacts CPU average load!
# Uncomment this if you like to see progress and transfer rate with ftpwho
# in downloads. That is not needed for uploads rates.
#
# UseSendFile                   off

TransferLog /var/log/proftpd/xferlog
SystemLog   /var/log/proftpd/proftpd.log

# Logging onto /var/log/lastlog is enabled but set to off by default
#UseLastlog on

# In order to keep log file dates consistent after chroot, use timezone info
# from /etc/localtime.  If this is not set, and proftpd is configured to
# chroot (e.g. DefaultRoot or <Anonymous>), it will use the non-daylight
# savings timezone regardless of whether DST is in effect.
#SetEnv TZ :/etc/localtime

<IfModule mod_quotatab.c>
QuotaEngine off
</IfModule>

<IfModule mod_ratio.c>
Ratios off
</IfModule>


# Delay engine reduces impact of the so-called Timing Attack described in
# http://www.securityfocus.com/bid/11430/discuss
# It is on by default.
<IfModule mod_delay.c>
DelayEngine on
</IfModule>

<IfModule mod_ctrls.c>
ControlsEngine        off
ControlsMaxClients    2
ControlsLog           /var/log/proftpd/controls.log
ControlsInterval      5
ControlsSocket        /var/run/proftpd/proftpd.sock
</IfModule>

<IfModule mod_ctrls_admin.c>
AdminControlsEngine off
</IfModule>

#
# Alternative authentication frameworks
#
#Include /etc/proftpd/ldap.conf
#Include /etc/proftpd/sql.conf

#
# This is used for FTPS connections
#
#Include /etc/proftpd/tls.conf

#
# Useful to keep VirtualHost/VirtualRoot directives separated
#
#Include /etc/proftpd/virtuals.conf

# A basic anonymous configuration, no upload directories.

 <Anonymous /var/ftp>
   User                                ftp
   Group                               nogroup
   # We want clients to be able to login with "anonymous" as well as "ftp"
   UserAlias                   anonymous ftp
   # Cosmetic changes, all files belongs to ftp user
   DirFakeUser on ftp
   DirFakeGroup on ftp

   RequireValidShell           off

   # Limit the maximum number of anonymous logins
   MaxClients                  10

   # We want 'welcome.msg' displayed at login, and '.message' displayed
   # in each newly chdired directory.
   DisplayLogin                        welcome.msg
   DisplayChdir                .message

   # Limit WRITE everywhere in the anonymous chroot
   <Directory *>
     <Limit WRITE>
       AllowAll
     </Limit>
   </Directory>

   # Uncomment this if you're brave.
   # <Directory incoming>
   #   # Umask 022 is a good standard umask to prevent new files and dirs
   #   # (second parm) from being group and world writable.
   #   Umask                           022  022
   #            <Limit READ WRITE>
   #            DenyAll
   #            </Limit>
   #            <Limit STOR>
   #            AllowAll
   #            </Limit>
   # </Directory>

 </Anonymous>

# Include other custom configuration files
Include /etc/proftpd/conf.d/
" > /etc/proftpd/proftpd.conf
	clear
	/etc/init.d/proftpd restart
	else
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting...'
					sleep 1
					break
					fi;;
			"U") if [ $(dpkg-query -W -f='${Status}' proftpd-* 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Proftpd \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Proftpd \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Proftpd \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Proftpd \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
				 clear
				 apt-get purge proftpd-* -y
				 apt-get autoremove -y
				 rm -r /var/ftp
				 fi;;

			"q") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"Q") clear
				 exit;;
			"r") clear
				 break;;
			"u") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"R") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			esac
			sleep 0
		done;;


	"5")while :
		do
		clear
		cat<<EOF

  MAIL SERVER - Access with http://your-domain.com/mail
  --------------------------------------------------------------------

  1) Install + Configure Mail Server (Postfix, Dovecot, Squirrelmail)
  2) Create User
  3) Remove User

  U) Uninstall Mail Server

  r) Return to Main Menu
  Q) Quit

EOF
		read -n1 -p $'  \e[5m\e[31mChoose:\e[0m '
		case "$REPLY" in
			"1") if grep -qs "$mountloc" /proc/mounts || grep -q 1 "/root/.ignore";
				then
				clear
				 apt-get install postfix -y --force-yes
				 apt-get install dovecot-imapd dovecot-pop3d -y --force-yes
				 apt-get install squirrelmail -y --force-yes
				 cp -r /usr/share/squirrelmail/ /var/www/mail
				 chown www-data:www-data /var/www/mail
				 else
				 	clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  USB Repository \e[31mNot Mounted\e[0m, Exiting...'
					sleep 1
					break
					fi;;

			"U") if [ $(dpkg-query -W -f='${Status}' squirrelmail 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
				 clear
				 apt-get purge postfix dovecot-* squirrelmail -y
				 apt-get autoremove -y
				 fi;;

			"2") if [ $(dpkg-query -W -f='${Status}' postfix dovecot-* squirrelmail 2>/dev/null | grep -c "ok installed") -eq 0 ];
				 then
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting'
					sleep 0.20
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting.'
					sleep 0.20
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting..'
					sleep 0.20
					clear
					echo ""
					echo $'  Squirrelmail \e[31mNot Installed\e[0m, Exiting...'
					sleep 1
					break
				 else
				 clear
				 echo ""
				 echo "  MAIL SERVER - CREATE USER"
				 echo "  -----------------------------------------------------------"
				 usermail(){
					 cut -d: -f6 /etc/passwd | grep home | cut -c 7-
				 }
				 echo "  Created Users:"
				 echo -e "${red}$(usermail)${none}"
				 echo ""
				 read -p "  Enter Username: " user
				 adduser ${user}
				 adduser ${user} mail
				 sleep 1
				 fi;;
			"3") clear
				 echo ""
				 echo "  MAIL SERVER - REMOVE USER"
				 echo "  -----------------------------------------------------------"
				 usermail(){
					 cut -d: -f6 /etc/passwd | grep home | cut -c 7-
				 }
				 echo -e "${red}$(usermail)${none}"
				 echo ""
				 read -p $'  Enter the Username to \e[31mREMOVE\e[0m (ex. \e[31muser\e[0m): ' user
				 deluser ${user}
				 rm -r /home/$user
				 sleep 1;;
			"q") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"Q") clear
				 exit;;
			"r") clear
				 break;;
			"u") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			"R") echo $' \e[7mCASE SENSITIVE\e[0m'
				sleep 1;;
			esac
			sleep 0
		done;;

	"i") if grep -q 1 "/root/.ignore"
			then
				echo "0" > /root/.ignore
			else
				echo "1" > /root/.ignore
			fi;;
	"I") echo $' \e[7mCASE SENSITIVE\e[0m'
		sleep 1;;
	"q") echo $' \e[7mCASE SENSITIVE\e[0m'
		sleep 1;;
	"Q") clear
		 echo ""
		 echo "  Thank you for using Auto Debian"
		 echo ""
		 sleep 1
		 exit;;
	esac
	sleep 0.050
done

else
	clear
	echo ""
	echo -e "  ${red}Need run as root user${none}, Exiting"
	sleep 0.35
	clear
	echo ""
	echo -e "  ${red}Need run as root user${none}, Exiting."
	sleep 0.35
	clear
	echo ""
	echo -e "  ${red}Need run as root user${none}, Exiting.."
	sleep 0.35
	clear
	echo ""
	echo -e "  ${red}Need run as root user${none}, Exiting..."
	sleep 1
	echo ""
	exit
fi
else
	 clear
	 echo ""
	 echo -e "  ${red}Required${none} Run on SSH Connection, Exiting"
	 sleep 0.35
	 clear
	 echo ""
	 echo -e "  ${red}Required${none} Run on SSH Connection, Exiting."
	 sleep 0.35
	 clear
	 echo ""
	 echo -e "  ${red}Required${none} Run on SSH Connection, Exiting.."
	 sleep 0.35
	 clear
	 echo ""
	 echo -e "  ${red}Required${none} Run on SSH Connection, Exiting..."
	 echo ""
	 sleep 1
	 tput rmcup
	exit
fi
